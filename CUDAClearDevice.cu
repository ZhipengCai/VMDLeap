/***************************************************************************
 *cr
 *cr            (C) Copyright 2007-2009 The Board of Trustees of the
 *cr                        University of Illinois
 *cr                         All Rights Reserved
 *cr
 ***************************************************************************/

/***************************************************************************
 * RCS INFORMATION:
 *
 *      $RCSfile: CUDAClearDevice.cu,v $
 *      $Author: johns $        $Locker:  $             $State: Exp $
 *      $Revision: 1.11 $      $Date: 2010/03/22 20:33:24 $
 *
 ***************************************************************************
 * DESCRIPTION:
 *   CUDA utility to clear all global and constant GPU memory areas to 
 *   known values.
 *
 ***************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <cuda.h>

#include "utilities.h"
#include "CUDAKernels.h"

#define CUERR { cudaError_t err; \
  if ((err = cudaGetLastError()) != cudaSuccess) { \
  printf("CUDA error: %s, %s line %d\n", cudaGetErrorString(err), __FILE__, __LINE__); \
  return NULL; }}

// a full-sized 64-kB constant memory buffer to use to clear
// any existing device state
__constant__ static float constbuf[16384];

// maximum number of allocations to use to soak up all available RAM
#define MAXLOOPS 16

void * vmd_cuda_devpool_clear_device_mem(void * voidparms) {
  int i, id, count, dev, bufcnt;
  char *bufs[MAXLOOPS];
  size_t bufszs[MAXLOOPS];
  size_t totalsz=0;
  float zerobuf[16 * 1024];
  int verbose=0;

  if (getenv("VMDCUDAVERBOSE") != NULL)
    verbose=1;

  memset(zerobuf, 0, sizeof(zerobuf));
  memset(bufs, 0, MAXLOOPS * sizeof(sizeof(char *)));
  memset(bufszs, 0, MAXLOOPS * sizeof(sizeof(size_t)));

  wkf_threadpool_worker_getid(voidparms, &id, &count);
  wkf_threadpool_worker_getdevid(voidparms, &dev);

  // clear constant memory
  cudaMemcpyToSymbol(constbuf, zerobuf, sizeof(zerobuf), 0);
  CUERR

  // 
  // Allocate, clear, and deallocate all global memory we can touch
  //
  // XXX In MPI enabled builds, we skip the global memory clearing step 
  //     since multiple VMD processes may end up being mapped to the
  //     same node, sharing the same set of GPUs.  A better way of handling
  //     this would be either to perform the memory clear only on one 
  //     MPI rank per physical node, or to distribute GPUs among 
  //     VMD processes so no sharing occurs.
  //
#if !defined(VMDMPI)
  size_t sz(1024 * 1024 * 1024); /* start with 1GB buffer size */
  bufcnt=0;
  for (i=0; i<MAXLOOPS; i++) {
    // Allocate the largest buffer we can get. If we fail, we reduce request
    // size to half of the previous, and try again until we reach the minimum
    // request size threshold.
    cudaError_t rc;
    while ((sz > (16 * 1024 * 1024)) && 
           ((rc=cudaMalloc((void **) &bufs[i], sz)) != cudaSuccess)) {
      cudaGetLastError(); // reset error state
      sz >>= 1;
    }

    if (rc == cudaSuccess) {
      bufszs[i] = sz;
      totalsz += sz; 
      bufcnt++;
      if (verbose)
        printf("devpool thread[%d / %d], dev %d buf[%d] size: %d\n", id, count, dev, i, sz);
    } else {
      bufs[i] = NULL;
      bufszs[i] = 0;
      if (verbose)
        printf("devpool thread[%d / %d], dev %d buf[%d] failed min allocation size: %d\n", id, count, dev, i, sz);

      // terminate allocation loop early
      break;
    } 
  }

  if (verbose)
    printf("devpool thread[%d / %d], dev %d allocated %d buffers\n", id, count, dev, bufcnt);

  for (i=0; i<bufcnt; i++) {
    if ((bufs[i] != NULL) && (bufszs[i] > 0)) {
      cudaMemset(bufs[i], 0, bufszs[i]);
      cudaFree(bufs[i]);
      bufs[i] = NULL;
      bufszs[i] = 0;
    }
  }
  CUERR

  if (verbose)
    printf("  Device %d cleared %d MB of GPU memory\n", dev, totalsz / (1024 * 1024));

#endif

  return NULL;
}


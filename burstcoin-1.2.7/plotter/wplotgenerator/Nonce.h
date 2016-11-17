#pragma once

#define USE_MULTI_SHABAL

#ifdef USE_MULTI_SHABAL // enable Multi-shabal
#if _MSC_VER > 1600
#define USE_MULTI_SHABAL256 // enable AVX2 Multi-shabal
#endif // #if _MSC_VER > 1600
#endif // #ifdef USE_MULTI_SHABAL

#include "InstructionSet.h"

#define PLOT_SIZE	(4096 * 64)
#define HASH_SIZE	32
#define HASH_CAP	4096
#define WRITE_BLOCK_SIZE	(1024 * 1024 * 10)

#define HASHSIZE 256
#define HASHBYTES (HASHSIZE / 8)

extern unsigned long long addr;
extern unsigned long long startnonce;
extern unsigned int nonces;
extern unsigned int staggersize;
extern unsigned int threads;
extern unsigned int noncesperthread;
extern bool bAsync;

extern bool bIsAVX1Available;
extern bool bIsAVX2Available;

extern char *cache;
extern char *write_cache;

#define SET_NONCE(gendata, nonce) \
  xv = (char*)&nonce; \
  gendata[PLOT_SIZE + 8] = xv[7]; gendata[PLOT_SIZE + 9] = xv[6]; gendata[PLOT_SIZE + 10] = xv[5]; gendata[PLOT_SIZE + 11] = xv[4]; \
  gendata[PLOT_SIZE + 12] = xv[3]; gendata[PLOT_SIZE + 13] = xv[2]; gendata[PLOT_SIZE + 14] = xv[1]; gendata[PLOT_SIZE + 15] = xv[0]

namespace SSE4
{
  int nonce(unsigned long long int addr, unsigned long long int nonce, unsigned long long cachepos);

  DWORD WINAPI work_i(void *x_void_ptr);

  void test_shabal(size_t len, char* test1, byte* hash);

#ifdef USE_MULTI_SHABAL // enable Multi-shabal
  void test_mshabal(size_t len, char* test1, char* test2, char* test3, char* test4, byte* mhash1, byte* mhash2, byte* mhash3, byte* mhash4);
#endif // #ifdef USE_MULTI_SHABAL
}

namespace AVX1
{
  DWORD WINAPI work_i(void *x_void_ptr);

  void test_shabal(size_t len, char* test1, byte* hash);

#ifdef USE_MULTI_SHABAL // enable Multi-shabal
  void test_mshabal(size_t len, char* test1, char* test2, char* test3, char* test4, byte* mhash1, byte* mhash2, byte* mhash3, byte* mhash4);
#endif // #ifdef USE_MULTI_SHABAL
}

namespace AVX2
{
  DWORD WINAPI work_i(void *x_void_ptr);

  void test_shabal(size_t len, char* test1, byte* hash);

#ifdef USE_MULTI_SHABAL // enable Multi-shabal
  void test_mshabal(size_t len, char* test1, char* test2, char* test3, char* test4, byte* mhash1, byte* mhash2, byte* mhash3, byte* mhash4);

#ifdef USE_MULTI_SHABAL256 // enable Multi-shabal
  void test_mshabal256(size_t len, char* test1, char* test2, char* test3, char* test4, char* test5, char* test6, char* test7, char* test8, byte* ahash1, byte* ahash2, byte* ahash3, byte* ahash4, byte* ahash5, byte* ahash6, byte* ahash7, byte* ahash8);
#endif // #ifdef USE_MULTI_SHABAL256

#endif // #ifdef USE_MULTI_SHABAL
}

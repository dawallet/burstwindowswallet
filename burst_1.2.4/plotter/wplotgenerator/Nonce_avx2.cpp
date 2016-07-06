#include "stdafx.h"
#include "Nonce.h"
#include "mshabal256.h"
#include "mshabal.h"
#include "shabal.h"

namespace AVX2
{
  int m256nonce(unsigned long long int addr,
    unsigned long long int nonce1, unsigned long long int nonce2, unsigned long long int nonce3, unsigned long long int nonce4,
    unsigned long long int nonce5, unsigned long long int nonce6, unsigned long long int nonce7, unsigned long long int nonce8,
    unsigned long long cachepos1, unsigned long long cachepos2, unsigned long long cachepos3, unsigned long long cachepos4,
    unsigned long long cachepos5, unsigned long long cachepos6, unsigned long long cachepos7, unsigned long long cachepos8)
  {
    char final1[32], final2[32], final3[32], final4[32];
    char final5[32], final6[32], final7[32], final8[32];
    char gendata1[16 + PLOT_SIZE], gendata2[16 + PLOT_SIZE], gendata3[16 + PLOT_SIZE], gendata4[16 + PLOT_SIZE];
    char gendata5[16 + PLOT_SIZE], gendata6[16 + PLOT_SIZE], gendata7[16 + PLOT_SIZE], gendata8[16 + PLOT_SIZE];

    char *xv = (char*)&addr;

    gendata1[PLOT_SIZE] = xv[7]; gendata1[PLOT_SIZE + 1] = xv[6]; gendata1[PLOT_SIZE + 2] = xv[5]; gendata1[PLOT_SIZE + 3] = xv[4];
    gendata1[PLOT_SIZE + 4] = xv[3]; gendata1[PLOT_SIZE + 5] = xv[2]; gendata1[PLOT_SIZE + 6] = xv[1]; gendata1[PLOT_SIZE + 7] = xv[0];

    for (int i = PLOT_SIZE; i <= PLOT_SIZE + 7; ++i)
    {
      gendata2[i] = gendata1[i];
      gendata3[i] = gendata1[i];
      gendata4[i] = gendata1[i];
      gendata5[i] = gendata1[i];
      gendata6[i] = gendata1[i];
      gendata7[i] = gendata1[i];
      gendata8[i] = gendata1[i];
    }

    xv = (char*)&nonce1;

    SET_NONCE(gendata1, nonce1);
    SET_NONCE(gendata2, nonce2);
    SET_NONCE(gendata3, nonce3);
    SET_NONCE(gendata4, nonce4);
    SET_NONCE(gendata5, nonce5);
    SET_NONCE(gendata6, nonce6);
    SET_NONCE(gendata7, nonce7);
    SET_NONCE(gendata8, nonce8);

    mshabal256_context x;
    int i, len;

    for (i = PLOT_SIZE; i > 0; i -= HASH_SIZE)
    {

      mshabal256_init(&x, 256);

      len = PLOT_SIZE + 16 - i;
      if (len > HASH_CAP)
        len = HASH_CAP;

      mshabal256(&x, &gendata1[i], &gendata2[i], &gendata3[i], &gendata4[i], &gendata5[i], &gendata6[i], &gendata7[i], &gendata8[i], len);
      mshabal256_close(&x, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        &gendata1[i - HASH_SIZE], &gendata2[i - HASH_SIZE], &gendata3[i - HASH_SIZE], &gendata4[i - HASH_SIZE],
        &gendata5[i - HASH_SIZE], &gendata6[i - HASH_SIZE], &gendata7[i - HASH_SIZE], &gendata8[i - HASH_SIZE]);

    }

    mshabal256_init(&x, 256);
    mshabal256(&x, gendata1, gendata2, gendata3, gendata4, gendata5, gendata6, gendata7, gendata8, 16 + PLOT_SIZE);
    mshabal256_close(&x, 0, 0, 0, 0, 0, 0, 0, 0, 0, final1, final2, final3, final4, final5, final6, final7, final8);

    // XOR with final
    for (i = 0; i < PLOT_SIZE; i++)
    {
      gendata1[i] ^= (final1[i % 32]);
      gendata2[i] ^= (final2[i % 32]);
      gendata3[i] ^= (final3[i % 32]);
      gendata4[i] ^= (final4[i % 32]);
      gendata5[i] ^= (final5[i % 32]);
      gendata6[i] ^= (final6[i % 32]);
      gendata7[i] ^= (final7[i % 32]);
      gendata8[i] ^= (final8[i % 32]);
    }

    // Sort them:
    for (i = 0; i < PLOT_SIZE; i += 64)
    {
      memmove(&cache[cachepos1 * 64 + (unsigned long long)i * staggersize], &gendata1[i], 64);
      memmove(&cache[cachepos2 * 64 + (unsigned long long)i * staggersize], &gendata2[i], 64);
      memmove(&cache[cachepos3 * 64 + (unsigned long long)i * staggersize], &gendata3[i], 64);
      memmove(&cache[cachepos4 * 64 + (unsigned long long)i * staggersize], &gendata4[i], 64);
      memmove(&cache[cachepos5 * 64 + (unsigned long long)i * staggersize], &gendata5[i], 64);
      memmove(&cache[cachepos6 * 64 + (unsigned long long)i * staggersize], &gendata6[i], 64);
      memmove(&cache[cachepos7 * 64 + (unsigned long long)i * staggersize], &gendata7[i], 64);
      memmove(&cache[cachepos8 * 64 + (unsigned long long)i * staggersize], &gendata8[i], 64);
    }

    return 0;
  }

  int mnonce(unsigned long long int addr,
    unsigned long long int nonce1, unsigned long long int nonce2, unsigned long long int nonce3, unsigned long long int nonce4,
    unsigned long long cachepos1, unsigned long long cachepos2, unsigned long long cachepos3, unsigned long long cachepos4)
  {
    char final1[32], final2[32], final3[32], final4[32];
    char gendata1[16 + PLOT_SIZE], gendata2[16 + PLOT_SIZE], gendata3[16 + PLOT_SIZE], gendata4[16 + PLOT_SIZE];

    char *xv = (char*)&addr;

    gendata1[PLOT_SIZE] = xv[7]; gendata1[PLOT_SIZE + 1] = xv[6]; gendata1[PLOT_SIZE + 2] = xv[5]; gendata1[PLOT_SIZE + 3] = xv[4];
    gendata1[PLOT_SIZE + 4] = xv[3]; gendata1[PLOT_SIZE + 5] = xv[2]; gendata1[PLOT_SIZE + 6] = xv[1]; gendata1[PLOT_SIZE + 7] = xv[0];

    for (int i = PLOT_SIZE; i <= PLOT_SIZE + 7; ++i)
    {
      gendata2[i] = gendata1[i];
      gendata3[i] = gendata1[i];
      gendata4[i] = gendata1[i];
    }

    SET_NONCE(gendata1, nonce1);
    SET_NONCE(gendata2, nonce2);
    SET_NONCE(gendata3, nonce3);
    SET_NONCE(gendata4, nonce4);

    mshabal_context x;
    int i, len;

    for (i = PLOT_SIZE; i > 0; i -= HASH_SIZE)
    {

      avx2_mshabal_init(&x, 256);

      len = PLOT_SIZE + 16 - i;
      if (len > HASH_CAP)
        len = HASH_CAP;

      avx2_mshabal(&x, &gendata1[i], &gendata2[i], &gendata3[i], &gendata4[i], len);
      avx2_mshabal_close(&x, 0, 0, 0, 0, 0, &gendata1[i - HASH_SIZE], &gendata2[i - HASH_SIZE], &gendata3[i - HASH_SIZE], &gendata4[i - HASH_SIZE]);

    }

    avx2_mshabal_init(&x, 256);
    avx2_mshabal(&x, gendata1, gendata2, gendata3, gendata4, 16 + PLOT_SIZE);
    avx2_mshabal_close(&x, 0, 0, 0, 0, 0, final1, final2, final3, final4);

    // XOR with final
    for (i = 0; i < PLOT_SIZE; i++)
    {
      gendata1[i] ^= (final1[i % 32]);
      gendata2[i] ^= (final2[i % 32]);
      gendata3[i] ^= (final3[i % 32]);
      gendata4[i] ^= (final4[i % 32]);
    }

    // Sort them:
    for (i = 0; i < PLOT_SIZE; i += 64)
    {
      memmove(&cache[cachepos1 * 64 + (unsigned long long)i * staggersize], &gendata1[i], 64);
      memmove(&cache[cachepos2 * 64 + (unsigned long long)i * staggersize], &gendata2[i], 64);
      memmove(&cache[cachepos3 * 64 + (unsigned long long)i * staggersize], &gendata3[i], 64);
      memmove(&cache[cachepos4 * 64 + (unsigned long long)i * staggersize], &gendata4[i], 64);
    }

    return 0;
  }

  int nonce(unsigned long long int addr, unsigned long long int nonce, unsigned long long cachepos)
  {
    char final[32];
    char gendata[16 + PLOT_SIZE];

    char *xv = (char*)&addr;

    gendata[PLOT_SIZE] = xv[7]; gendata[PLOT_SIZE + 1] = xv[6]; gendata[PLOT_SIZE + 2] = xv[5]; gendata[PLOT_SIZE + 3] = xv[4];
    gendata[PLOT_SIZE + 4] = xv[3]; gendata[PLOT_SIZE + 5] = xv[2]; gendata[PLOT_SIZE + 6] = xv[1]; gendata[PLOT_SIZE + 7] = xv[0];

    xv = (char*)&nonce;

    gendata[PLOT_SIZE + 8] = xv[7]; gendata[PLOT_SIZE + 9] = xv[6]; gendata[PLOT_SIZE + 10] = xv[5]; gendata[PLOT_SIZE + 11] = xv[4];
    gendata[PLOT_SIZE + 12] = xv[3]; gendata[PLOT_SIZE + 13] = xv[2]; gendata[PLOT_SIZE + 14] = xv[1]; gendata[PLOT_SIZE + 15] = xv[0];

    shabal_context x;
    int i, len;

    for (i = PLOT_SIZE; i > 0; i -= HASH_SIZE)
    {
      shabal_init(&x, 256);

      len = PLOT_SIZE + 16 - i;
      if (len > HASH_CAP)
        len = HASH_CAP;

      shabal(&x, &gendata[i], len);
      shabal_close(&x, 0, 0, &gendata[i - HASH_SIZE]);
    }

    shabal_init(&x, 256);
    shabal(&x, gendata, 16 + PLOT_SIZE);
    shabal_close(&x, 0, 0, final);

    // XOR with final
    for (i = 0; i < PLOT_SIZE; i++)
      gendata[i] ^= (final[i % 32]);

    // Sort them:
    for (i = 0; i < PLOT_SIZE; i += 64)
      memmove(&cache[cachepos * 64 + (unsigned long long)i * staggersize], &gendata[i], 64);

    return 0;
  }

  DWORD WINAPI work_i(void *x_void_ptr)
  {
    unsigned long long *x_ptr = (unsigned long long *)x_void_ptr;
    unsigned long long i = *x_ptr;

    unsigned int n;

    for (n = 0; n < noncesperthread; n++)
    {
#ifdef USE_MULTI_SHABAL256
      if (n + 8 < noncesperthread)
      {
        m256nonce(addr,
          (i + n + 0), (i + n + 1), (i + n + 2), (i + n + 3),
          (i + n + 4), (i + n + 5), (i + n + 6), (i + n + 7),
          (unsigned long long)(i - startnonce + n + 0),
          (unsigned long long)(i - startnonce + n + 1),
          (unsigned long long)(i - startnonce + n + 2),
          (unsigned long long)(i - startnonce + n + 3),
          (unsigned long long)(i - startnonce + n + 4),
          (unsigned long long)(i - startnonce + n + 5),
          (unsigned long long)(i - startnonce + n + 6),
          (unsigned long long)(i - startnonce + n + 7));

        n += 7;
      }
      else
#endif
#ifdef USE_MULTI_SHABAL
        if (n + 4 < noncesperthread)
        {
        mnonce(addr,
          (i + n + 0), (i + n + 1), (i + n + 2), (i + n + 3),
          (unsigned long long)(i - startnonce + n + 0),
          (unsigned long long)(i - startnonce + n + 1),
          (unsigned long long)(i - startnonce + n + 2),
          (unsigned long long)(i - startnonce + n + 3));

        n += 3;
        }
        else
#endif
        {
          _mm256_zeroupper(); // https://software.intel.com/sites/products/documentation/studio/composer/en-us/2011Update/compiler_c/intref_cls/common/intref_avx_zeroupper.htm
          nonce(addr,
            (i + n), (unsigned long long)(i - startnonce + n));
        }
    }

    return 0;
  }

  void test_shabal(size_t len, char* test1, byte* hash)
  {
    shabal_context x;
    _mm256_zeroupper(); // https://software.intel.com/sites/products/documentation/studio/composer/en-us/2011Update/compiler_c/intref_cls/common/intref_avx_zeroupper.htm
    shabal_init(&x, HASHSIZE);
    shabal(&x, test1, len);
    shabal_close(&x, 0, 0, hash);
  }

  void test_mshabal(size_t len, char* test1, char* test2, char* test3, char* test4, byte* mhash1, byte* mhash2, byte* mhash3, byte* mhash4)
  {
    mshabal_context m;
    avx2_mshabal_init(&m, HASHSIZE);
    avx2_mshabal(&m, test1, test2, test3, test4, len);
    avx2_mshabal_close(&m, 0, 0, 0, 0, 0, mhash1, mhash2, mhash3, mhash4);
  }

  void test_mshabal256(size_t len, char* test1, char* test2, char* test3, char* test4, char* test5, char* test6, char* test7, char* test8, byte* ahash1, byte* ahash2, byte* ahash3, byte* ahash4, byte* ahash5, byte* ahash6, byte* ahash7, byte* ahash8)
  {
    mshabal256_context a;
    mshabal256_init(&a, HASHSIZE);
    mshabal256(&a, test1, test2, test3, test4, test5, test6, test7, test8, len);
    mshabal256_close(&a, 0, 0, 0, 0, 0, 0, 0, 0, 0, ahash1, ahash2, ahash3, ahash4, ahash5, ahash6, ahash7, ahash8);
  }
}

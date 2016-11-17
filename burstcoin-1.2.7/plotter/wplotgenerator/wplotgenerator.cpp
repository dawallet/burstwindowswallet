/*
Windows Burstcoin plot generator optimized for SSE4 / AVX / AVX2
Author: Cerr Janror <cerr.janror@gmail.com>
Burst for donations: BURST-LNVN-5M4L-S9KP-H5AAC

Based on the linux c-port of: Markus Tervooren <info@bchain.info>, Burst: BURST-R5LP-KEL9-UYLG-GFG6T
Implementation of Shabal is taken from: http://www.shabal.com/?p=198 (single hash SSE 4 - disassembled to convert from AT&T-Syntax to MASM-Syntax - ported to Microsoft x64 calling convention)
Implementation of Multi-Shabal is taken from: http://www.shabal.com/?p=140 (multiple hash SSE 4 / AVX - ported AVX2)

Usage: wplotgenerator <account id> <start nonce> <number of nonces> <stagger size> <threads> [/async]
         <account id> = your numeric acount id
         <start nonce> = where you want to start plotting, if this is your first HDD then set it to 0, other wise set it to your last hdd's <start nonce> + <number of nonces>
         <number of nonces> = how many nonces you want to plot - 200gb is about 800000 nonces
         <stagger size> = set it to 2x the amount of MB RAM your system has (with async 1x the RAM your system has)
         <threads> = How many CPU threads you want to utilise
       options:
         /async ... writing plots from a background-thread for best throughput (needs twice as much RAM)
*/

#include "stdafx.h"
#include "Nonce.h"

// Initialize static member data
const InstructionSet::InstructionSet_Internal InstructionSet::CPU_Rep;

unsigned long long addr;
unsigned long long startnonce;
unsigned int nonces;
unsigned int staggersize;
unsigned int threads;
unsigned int noncesperthread;
bool bAsync;

bool bIsAVX1Available;
bool bIsAVX2Available;

char *cache;
char *write_cache;

unsigned long long getMS()
{
  return GetTickCount64() * 1000;
}

DWORD WINAPI writer(void *x_void_ptr)
{
  int ofd = reinterpret_cast<int>(x_void_ptr);

  unsigned long long bytes = (unsigned long long) staggersize * PLOT_SIZE;
  unsigned long long position = 0;
  do
  {
    int b = _write(ofd, &write_cache[position], (bytes > WRITE_BLOCK_SIZE) ? WRITE_BLOCK_SIZE : static_cast<int>(bytes));
    position += b;
    bytes -= b;
  } while (bytes > 0);

  return 0;
}

#ifdef DEBUG
void test_hashes() // test SSE/AVX1/AVX2 hashes, test multi-shabal for SSE/AVX1/AVX2, test multi-shabal256 for AVX2
{
  char* test1 = "TestAllSame";
  char* test2 = "TestAllSame";
  char* test3 = "TestAllSame";
  char* test4 = "TestAllSame";
  char* test5 = "TestAllSame";
  char* test6 = "TestAllSame";
  char* test7 = "TestAllSame";
  char* test8 = "TestAllSame";

  //bIsAVX1Available = false;
  //bIsAVX2Available = false;
  //bIsAVX2Available = true;

  for (int testrun = 0; testrun < 2; ++testrun)
  {
    if (testrun == 1)
    {
      test1 = "Test1";
      test2 = "Test2";
      test3 = "Test3";
      test4 = "Test4";
      test5 = "Test5";
      test6 = "Test6";
      test7 = "Test7";
      test8 = "Test8";
    }

    size_t len1 = strlen(test1);
    ATLASSERT(len1 == strlen(test2));
    ATLASSERT(len1 == strlen(test3));
    ATLASSERT(len1 == strlen(test4));
    ATLASSERT(len1 == strlen(test5));
    ATLASSERT(len1 == strlen(test6));
    ATLASSERT(len1 == strlen(test7));
    ATLASSERT(len1 == strlen(test8));

    byte hash[HASHBYTES] = {};
    byte avx1_hash[HASHBYTES] = {};
    byte avx2_hash[HASHBYTES] = {};

    SSE4::test_shabal(len1, test1, hash);
    if (bIsAVX1Available)
      AVX1::test_shabal(len1, test1, avx1_hash);
    if (bIsAVX2Available)
      AVX2::test_shabal(len1, test1, avx2_hash);

#ifdef USE_MULTI_SHABAL
    byte mhash1[HASHBYTES] = {};
    byte mhash2[HASHBYTES] = {};
    byte mhash3[HASHBYTES] = {};
    byte mhash4[HASHBYTES] = {};

    SSE4::test_mshabal(len1, test1, test2, test3, test4, mhash1, mhash2, mhash3, mhash4);

    byte avx1_mhash1[HASHBYTES] = {};
    byte avx1_mhash2[HASHBYTES] = {};
    byte avx1_mhash3[HASHBYTES] = {};
    byte avx1_mhash4[HASHBYTES] = {};

    if (bIsAVX1Available)
      AVX1::test_mshabal(len1, test1, test2, test3, test4, avx1_mhash1, avx1_mhash2, avx1_mhash3, avx1_mhash4);

    byte avx2_mhash1[HASHBYTES] = {};
    byte avx2_mhash2[HASHBYTES] = {};
    byte avx2_mhash3[HASHBYTES] = {};
    byte avx2_mhash4[HASHBYTES] = {};

    if (bIsAVX2Available)
      AVX2::test_mshabal(len1, test1, test2, test3, test4, avx2_mhash1, avx2_mhash2, avx2_mhash3, avx2_mhash4);

#ifdef USE_MULTI_SHABAL256
    byte avx2_m256hash1[HASHBYTES] = {};
    byte avx2_m256hash2[HASHBYTES] = {};
    byte avx2_m256hash3[HASHBYTES] = {};
    byte avx2_m256hash4[HASHBYTES] = {};
    byte avx2_m256hash5[HASHBYTES] = {};
    byte avx2_m256hash6[HASHBYTES] = {};
    byte avx2_m256hash7[HASHBYTES] = {};
    byte avx2_m256hash8[HASHBYTES] = {};

    if (bIsAVX2Available)
      AVX2::test_mshabal256(len1, test1, test2, test3, test4, test5, test6, test7, test8, avx2_m256hash1, avx2_m256hash2, avx2_m256hash3, avx2_m256hash4, avx2_m256hash5, avx2_m256hash6, avx2_m256hash7, avx2_m256hash8);
#endif // #ifdef USE_MULTI_SHABAL256
#endif // #ifdef USE_MULTI_SHABAL

    int i;
    for (i = 0; i < _countof(hash); ++i)
    {
      if (bIsAVX1Available)
        ATLASSERT(hash[i] == avx1_hash[i]);
      if (bIsAVX2Available)
        ATLASSERT(hash[i] == avx2_hash[i]);

#ifdef USE_MULTI_SHABAL
      ATLASSERT(hash[i] == mhash1[i]);

      if (bIsAVX1Available)
      {
        ATLASSERT(mhash1[i] == avx1_mhash1[i]);
        ATLASSERT(mhash2[i] == avx1_mhash2[i]);
        ATLASSERT(mhash3[i] == avx1_mhash3[i]);
        ATLASSERT(mhash4[i] == avx1_mhash4[i]);
      }

      if (bIsAVX2Available)
      {
        ATLASSERT(mhash1[i] == avx2_mhash1[i]);
        ATLASSERT(mhash2[i] == avx2_mhash2[i]);
        ATLASSERT(mhash3[i] == avx2_mhash3[i]);
        ATLASSERT(mhash4[i] == avx2_mhash4[i]);
      }

#ifdef USE_MULTI_SHABAL256
      if (bIsAVX2Available)
      {
        ATLASSERT(mhash1[i] == avx2_m256hash1[i]);
        ATLASSERT(mhash2[i] == avx2_m256hash2[i]);
        ATLASSERT(mhash3[i] == avx2_m256hash3[i]);
        ATLASSERT(mhash4[i] == avx2_m256hash4[i]);
      }
#endif // #ifdef USE_MULTI_SHABAL256
#endif // #ifdef USE_MULTI_SHABAL

      if (testrun == 0)
      {
#ifdef USE_MULTI_SHABAL
        ATLASSERT(hash[i] == mhash1[i]);
        ATLASSERT(hash[i] == mhash2[i]);
        ATLASSERT(hash[i] == mhash3[i]);
        ATLASSERT(hash[i] == mhash4[i]);

        if (bIsAVX1Available)
        {
          ATLASSERT(hash[i] == avx1_mhash1[i]);
          ATLASSERT(hash[i] == avx1_mhash2[i]);
          ATLASSERT(hash[i] == avx1_mhash3[i]);
          ATLASSERT(hash[i] == avx1_mhash4[i]);
        }

        if (bIsAVX2Available)
        {
          ATLASSERT(hash[i] == avx2_mhash1[i]);
          ATLASSERT(hash[i] == avx2_mhash2[i]);
          ATLASSERT(hash[i] == avx2_mhash3[i]);
          ATLASSERT(hash[i] == avx2_mhash4[i]);

#ifdef USE_MULTI_SHABAL256
          ATLASSERT(hash[i] == avx2_m256hash1[i]);
          ATLASSERT(hash[i] == avx2_m256hash2[i]);
          ATLASSERT(hash[i] == avx2_m256hash3[i]);
          ATLASSERT(hash[i] == avx2_m256hash4[i]);
          ATLASSERT(hash[i] == avx2_m256hash5[i]);
          ATLASSERT(hash[i] == avx2_m256hash6[i]);
          ATLASSERT(hash[i] == avx2_m256hash7[i]);
          ATLASSERT(hash[i] == avx2_m256hash8[i]);
#endif // #ifdef USE_MULTI_SHABAL256
        }
#endif // #ifdef USE_MULTI_SHABAL
      }
    }
  }

  ATLASSERT(strcmp(test1, "Test1") == 0);
}
#endif // #ifdef DEBUG


int _tmain(int argc, _TCHAR* argv[])
{
  bIsAVX1Available = InstructionSet::AVX();
  bIsAVX2Available = InstructionSet::AVX2();

#ifdef DEBUG
  test_hashes(); // test SSE/AVX1/AVX2 hashes, test multi-shabal for SSE/AVX1/AVX2, test multi-shabal256 for AVX2
#endif // #ifdef DEBUG

  printf("Windows Burstcoin plot generator V1.17 by Cerr Janror\n\n");
  printf("Please consider donating some of your newly mined Bursts to support further development:\n");
  printf("    BURST-LNVN-5M4L-S9KP-H5AAC\n\n");

  if (argc != 6 && argc != 7)
  {
    printf("Usage: wplotgenerator <account id> <start nonce> <number of nonces> <stagger size> <threads> [/async]\n");
    printf("         <account id> = your numeric acount id\n");
    printf("         <start nonce> = where you want to start plotting, if this is your first HDD then set it to 0, other wise set it to your last hdd's <start nonce> + <number of nonces>\n");
    printf("         <number of nonces> = how many nonces you want to plot - 200gb is about 800000 nonces\n");
    printf("         <stagger size> = set it to 2x the amount of MB RAM your system has (with async 1x the RAM your system has)\n");
    printf("         <threads> = How many CPU threads you want to utilise\n");
    printf("       options:\n");
    printf("         /async ... writing plots from a background-thread for best throughput (needs twice as much RAM)\n");
    exit(-1);
  }

  // Parse inputs
  addr = _tcstoui64(argv[1], 0, 10);
  startnonce = _tcstoui64(argv[2], 0, 10);
  nonces = _tstol(argv[3]);
  staggersize = _tstol(argv[4]);
  threads = _tstol(argv[5]);
  bAsync = argc > 6 && (_tcsicmp(argv[6], _T("/async")) == 0 || _tcsicmp(argv[6], _T("-async")) == 0);

  if (nonces % staggersize != 0)
  {
    nonces -= nonces % staggersize;
    nonces += staggersize;
    printf("Adjusting total nonces to %u to match stagger size\n", nonces);
  }

  LPCSTR szCodePath = " - using SSE4 codepath";
  if (bIsAVX2Available)
    szCodePath = " - using AVX2 codepath";
  else if (bIsAVX1Available)
    szCodePath = " - using AVX codepath";

  printf("Creating plots for nonces %llu to %llu (%u GB) using %u MB memory and %u threads%s%s...\n",
    startnonce,
    (startnonce + nonces),
    (unsigned int)(nonces / 4 / 1024),
    (unsigned int)(staggersize / 4) * (bAsync ? 2 : 1),
    threads,
    bAsync ? " with async writing" : "",
    szCodePath);

  // Comment this out/change it if you really want more than 200 Threads
  if (threads > 200)
  {
    printf("%u threads? Sure?\n", threads);
    exit(-1);
  }

  printf("Setting priority class 'below normal'...\n");
  if (!SetPriorityClass(GetCurrentProcess(), BELOW_NORMAL_PRIORITY_CLASS))
  {
    printf("Warning: Setting priority class 'below normal' returned with error %lu.\n", ::GetLastError());
    exit(-1);
  }

  printf("Allocating memory...\n");
  cache = (char*)calloc(PLOT_SIZE, staggersize);

  if (cache == NULL)
  {
    printf("Error allocating memory. Try lower stagger size.\n");
    exit(-1);
  }

  if (bAsync)
  {
    printf("Allocating secondary buffer...\n");
    write_cache = (char*)calloc(PLOT_SIZE, staggersize);

    if (write_cache == NULL)
    {
      printf("Error allocating memory for secondary buffer. Try lower stagger size or disable /async.\n");
      exit(-1);
    }
  }
  else
    write_cache = cache;

  printf("Checking directory...\n");
  _mkdir("plots");

  char name[100];
  sprintf_s(name, "plots/%llu_%llu_%u_%u", addr, startnonce, nonces, staggersize);

  printf("Opening file...\n");
  int ofd = -1;
  _sopen_s(&ofd, name, _O_CREAT | O_WRONLY | _O_BINARY, _SH_DENYWR, _S_IREAD | _S_IWRITE);
  if (ofd < 0)
  {
    printf("Error opening file %s\n", name);
    exit(-1);
  }

  // Threads:
  noncesperthread = (unsigned long)(staggersize / threads);

  if (noncesperthread == 0)
  {
    threads = staggersize;
    noncesperthread = 1;
  }

  HANDLE* worker_threads;
  worker_threads = new HANDLE[threads + 1]; // + 1 for writer-thread on /async
  ZeroMemory(worker_threads, sizeof(HANDLE) * (threads + 1));

  unsigned long long* nonceoffset;
  nonceoffset = new unsigned long long[threads];

  unsigned long long run = 0;

  printf("Checking file size...\n");
  struct _stat64 fileStat;
  if (_fstat64(ofd, &fileStat) == 0 && fileStat.st_size > 0)
  {
    printf("Opened existing file with a size of %lld bytes.\n", fileStat.st_size);
    if (fileStat.st_size % ((unsigned long long)staggersize * PLOT_SIZE) != 0)
    {
      fileStat.st_size = fileStat.st_size / ((unsigned long long)staggersize * PLOT_SIZE) * ((unsigned long long)staggersize * PLOT_SIZE);
      printf("File size doesn't match a multiple of staggersize and plotsize. Restarting at %lld bytes.\n", fileStat.st_size);
    }

    run = fileStat.st_size / PLOT_SIZE;
    startnonce += run;

    if (run < nonces)
    {
      printf("Continuing with startnounce %llu in run %ld.\n", startnonce, run);
      if (_lseeki64(ofd, fileStat.st_size, SEEK_SET) != fileStat.st_size)
      {
        printf("Error seeking to new position. Delete the existing file to start over.\n");
        exit(-1);
      }
    }
    else if (run == nonces)
    {
      printf("File is already finished. Delete the existing file to start over.\n");
      exit(-1);
    }
    else 
    {
      printf("The existing file is to big for the specified arguments. Probably the content doesn't match the file name.\n");
      exit(-1);
    }
  }

  int percent = 0;
  int speed = 0;
  int avgspeed = 0;

  double summinutes = 0.0;
  unsigned long long sumnonces = 0;

  DWORD dwStacksize = 0;
#ifdef USE_MULTI_SHABAL
  dwStacksize += 2 * 1024 * 1024; // 2 MB
#endif
#ifdef USE_MULTI_SHABAL256
  dwStacksize += 2 * 1024 * 1024; // 2+2 MB
#endif

  printf("Choosing worker routine...\n");
  LPTHREAD_START_ROUTINE lpWorkerStartAddress = SSE4::work_i;
  if (bIsAVX2Available)
    lpWorkerStartAddress = AVX2::work_i;
  else if (bIsAVX1Available)
    lpWorkerStartAddress = AVX1::work_i;

  printf("0 Percent done. Calculating first stagger...                            ", percent, speed, avgspeed);
  for (; run < nonces; run += staggersize)
  {
    unsigned long long starttime = getMS();

    unsigned int i;
    for (i = 0; i < threads; i++)
    {
      nonceoffset[i] = startnonce + i * noncesperthread;

      if ((worker_threads[i] = CreateThread(NULL, dwStacksize, lpWorkerStartAddress, &nonceoffset[i], CREATE_SUSPENDED, NULL)) == NULL)
      {
        printf("Error creating thread. Out of memory? Try lower stagger size\n");
        exit(-1);
      }

      // Set thread priority 
      SetThreadPriority(worker_threads[i], THREAD_PRIORITY_BELOW_NORMAL);
      ResumeThread(worker_threads[i]);
    }

    bool bRun = true;
    while (bRun && worker_threads[threads] != NULL)
    {
      bool bWriterThreadReady = WaitForMultipleObjects(threads + 1, worker_threads, FALSE, INFINITE) == (WAIT_OBJECT_0 + threads);
      if (bWriterThreadReady)
      {
        printf("\r%i Percent done. %i nonces/minute (avg %i - data written)...             ", percent, speed, avgspeed);
        bRun = false;
      }
      else
      {
        bool bAllReady = true;
        for (i = 0; i < threads; i++)
        {
          bAllReady &= WaitForSingleObject(worker_threads[i], 0) == WAIT_OBJECT_0;
        }
        bRun = !bAllReady;
      }
    }

    // Wait for Threads to finish;
    for (i = 0; i < threads; i++)
    {
      WaitForSingleObject(worker_threads[i], INFINITE);
      CloseHandle(worker_threads[i]);
    }

    percent = (int)(100 * (run + staggersize) / nonces);
    printf("\r%i Percent calculated. calculating leftover nonces...                    ", percent);

    // Run leftover nonces
    for (i = threads * noncesperthread; i < staggersize; i++)
      SSE4::nonce(addr, startnonce + i, (unsigned long long)i);

    if (worker_threads[threads] != NULL) // writer-thread started? wait until it has finished
    {
      if (WaitForSingleObject(worker_threads[threads], 0) != WAIT_OBJECT_0)
      {
        printf("\r%i Percent calculated. Last write not finished...                        ", percent);
        WaitForSingleObject(worker_threads[threads], INFINITE);
      }

      CloseHandle(worker_threads[threads]);
      worker_threads[threads] = NULL;
    }

    if (bAsync)
      printf("\r%i Percent calculated. start async writing data...                       ", percent);
    else
      printf("\r%i Percent calculated. writing data...                                   ", percent);

    // swap cache with write_cache --> write_cache must be written
    if (bAsync)
    {
      char* swap = write_cache;
      write_cache = cache;
      cache = swap;
    }

    // Write plot to disk:
    if (bAsync)
    {
      if ((worker_threads[threads] = CreateThread(NULL, 0, writer, reinterpret_cast<LPVOID>(ofd), 0, NULL)) == NULL)
      {
        printf("Error creating thread. Out of memory? Try lower stagger size or disable /async\n");
        exit(-1);
      }
    }
    else
      writer(reinterpret_cast<LPVOID>(ofd));

    unsigned long long ms = getMS() - starttime;

    double minutes = (double)ms / (1000000 * 60);
    speed = (int)(staggersize / minutes);

    summinutes += minutes;
    sumnonces += staggersize;

    avgspeed = (int)(sumnonces / summinutes);

    if (worker_threads[threads] != NULL)
      printf("\r%i Percent done. %i nonces/minute (avg %i - write async)...              ", percent, speed, avgspeed);
    else
      printf("\r%i Percent done. %i nonces/minute (avg %i)...                            ", percent, speed, avgspeed);
    fflush(stdout);

    startnonce += staggersize;
  }

  if (worker_threads[threads] != NULL) // writer-thread started? wait until it has finished
  {
    printf("\r100 Percent done. Average %i nonces/minute. waiting for last writer...   ", avgspeed);
    WaitForSingleObject(worker_threads[threads], INFINITE);
    CloseHandle(worker_threads[threads]);
    worker_threads[threads] = NULL;
  }
  printf("\r100 Percent done. Average %i nonces/minute.                              ", avgspeed);

  _close(ofd);

  printf("\nFinished plotting.\n");

  delete worker_threads;
  delete nonceoffset;
}

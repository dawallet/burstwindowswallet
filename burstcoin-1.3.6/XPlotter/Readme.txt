Usage:

XPlotter_avx.exe -id <ID> -sn <start_nonce> [-n <nonces>] -t <threads> [-path <d:\plots>] [-mem <8G>]


Technical information:
If not specified the number of nonces, or it is 0, the file is created on all the free disk space.

The calculation of nonces is in <threads>. Parallel computing nonces (after the first iteration) is asynchronously recorded to the drive without using the system write caching (FILE_FLAG_NO_BUFFERING).

If the free RAM is not enough to generate the nonces, the nonces number will be decreased, the number of threads remains unchanged.

When you start the plotter creates an empty file desired size, it prevents a write error if for some reason the drive space is reduced while plotting.

Writes to drive produced in 4096 iterations, of approximately by threads*64KB.
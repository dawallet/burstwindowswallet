#BurstSoftware
=============
Windows Burstcoin plot generator optimized for SSE4 / AVX / AVX2<br>
Author: Cerr Janror <cerr.janror@gmail.com><br>
Burst for donations: BURST-LNVN-5M4L-S9KP-H5AAC<br>

Based on the linux c-port of: Markus Tervooren <info@bchain.info>, Burst: BURST-R5LP-KEL9-UYLG-GFG6T<br>
Implementation of Shabal is taken from: http://www.shabal.com/?p=198 (single hash SSE 4 - disassembled to convert from AT&T-Syntax to MASM-Syntax - ported to Microsoft x64 calling convention)<br>
Implementation of Multi-Shabal is taken from: http://www.shabal.com/?p=140 (multiple hash SSE 4 / AVX - ported AVX2)<br>

###Usage
> wplotgenerator [account id] [start nonce] [number of nonces] [stagger size] [threads] {/async}

######Mandatory parameters:

* [account id] = your numeric acount id<br>
* [start nonce] = where you want to start plotting, if this is your first HDD then set it to 0, other wise set it to your last hdd's [start nonce] + [number of nonces]<br>
* [number of nonces] = how many nonces you want to plot - 200gb is about 800000 nonces<br>
* [stagger size] = set it to 2x the amount of MB RAM your system has (with async 1x the RAM your system has)<br>
* [threads] = How many CPU threads you want to utilise<br>

######Options:

* /async ... writing plots from a background-thread for best throughput (needs twice as much RAM)<br>
         
=============
######Built with Visual Studio 2013
Since this code is using AVX2 intrinsics, Visual Studio 2013 is necessary to build this project.

=============
###Some benchmark results for V1.15:

Pocminer launched with the following commandline: 
>  java -Xmx4000m -cp pocminer.jar;lib/*;lib/akka/*;lib/jetty/* pocminer.POCMiner generate 1 0 9600 1920 %NUMBER_OF_PROCESSORS%
  
Windows plot generator launched with the following commandline:
>  wplotgenerator 1 0 9600 1920 %NUMBER_OF_PROCESSORS% /async

Plotter         |  Codepath  |  CPU                                        |  Codename            |  Logical processors  |  Total average nonces per minute  |  Average nonces per thread per minute
----------------|------------|---------------------------------------------|----------------------|----------------------|-----------------------------------|--------------------------------------
pocminer_v1     |  Java      |  Intel(R) Xeon(R) CPU E5-1660 0 @ 3.30GHz   |  Sandy Bridge-EP/EX  |  12                  |    2'048                          |     170,67
wplotgenerator  |  SSE4      |  Intel(R) Xeon(R) CPU E5405 @ 2.00GHz       |  Harpertown          |   4                  |    2'411                          |     602,75
wplotgenerator  |  SSE4      |  Dual Intel(R) Xeon(R) CPU X5650 @ 2.67GHz  |  Westmere-EP         |  24                  |   15'200                          |     633,33
wplotgenerator  |  AVX       |  Intel(R) Xeon(R) CPU E5-1660 0 @ 3.30GHz   |  Sandy Bridge-EP/EX  |  12                  |   15'144                          |   1'262,00
wplotgenerator  |  AVX2      |  Intel(R) Core(TM) i5-4200M CPU @ 2.50GHz   |  Haswell             |   4                  |    7'830                          |   1'957.50
wplotgenerator  |  AVX2      |  Intel(R) Core(TM) i7-4790 CPU @ 3.60GHz    |  Haswell             |   8                  |   20'233                          |   2'529.13

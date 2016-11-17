POCMiner ver 1

Requirements:
Java 7 compatible JVM
Lots of free HDD space

POCMiner was made for use with Burst. POCMiner generates large amounts of data, known as plots, and then can use it for mining.

Quick start guide is at the bottom for people who don't care about the finer details.

1. Getting a public address:
Plots are specific to your burst address, so the miner needs to know your public address, and when mining, your passphrase to that address will also be needed for signing blocks. You can put your passphrase/s in passphrases.txt, 1 per line if you have multiple. Passphrases should be long and random(35+ characters). You can retrieve your address/es by running  run_dump_address.sh/.bat, which will write them out into a file called address.txt, or "java -cp burst.jar:lib/*:conf nxt.Nxt dumpaddr" if you really like to type. Shortcut .sh/.bat files are provided for generating and mining also.

2. Generating data:
Using the generate sh/bat files are recommended, although if you want more control over the JVM configuration, use them for reference. The miner takes the following parameters in order: public_address starting_nonce number_of_nonces number_of_plots_to_stagger_together threads. The public address is the long number you retrieved in step 1. You can use any range of nonces you like, although for simplicity you probably want to start at 0 or 1. Do not generate files with overlapping nonce ranges, or you will be wasting space. The total amount of nonces should be a multiple of the stagger amount. The stagger amount should be as high as possible. Due to a JVM limitation and the way generation is currently implemented, the maximum stagger amount is currently 8191. Higher stagger amounts reduce disk stress by reducing the amount of seeking needed when mining, however use more ram when generating. The maximum stagger amount of 8191 will cause the JVM to require almost 4GB of ram while generating, and will write data in chunks of just under 2GB at a time.

3. Mining:
The mining sh/bat files are setup to mine to a wallet running on the same computer with the default port. Configuration changes should be obvious from the example files. https support should work if you generate keys for the wallet and set them in config, but is untested. Run one instance of the miner for each hdd you're mining with. If running multiple instances, you may want want to cap the JVM heap size(-Xmx switch). You probably want to use around -Xmx500m, but it may depend on your storage speed. As low as -Xmx250m might be stable, but others might not be stable on -Xmx500m or higher. If it crashes with bad alloc errors, you need a higher number. If it seems stable for a while, it probably is, and you can try lower if you want and want to save some RAM. Warning: your passphrase/s will be sent to the wallet when mining, so take that into consideration when mining to another computer.

Quickstart(for windows):
Sync your clock. Go to set date/time -> Internet time, and manually make it sync.
Java must be installed and runnable from the command line.
Put a long password in passphrases.txt
Run run_dump_address.bat
Copy the long number generated after your password from address.txt
Now you can run run_generate.bat like this "run_generate.bat <number retrieved in last step> <plot number you want to start with> <number of plots you want to generate> 8191 <number of threads>
The number of plots should be a multiple of 8191.
This will generate plots with nonces from <starting plot num> up to <starting plot + number of plots>. Don't make overlapping ranges.
When your client is running and synced, run run_mine.bat to start mining.
You can mine while still generating plots. The miner will throw some read errors, but you can ignore them.
Use the password from before to access your coins in the wallet.

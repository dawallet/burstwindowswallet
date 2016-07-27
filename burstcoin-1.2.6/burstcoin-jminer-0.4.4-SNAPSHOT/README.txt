1. edit 'jminer.properties' with text editor to configure miner
2. ensure java8 (64bit) and openCL driver/sdk is installed
3. execute 'java -jar -d64 -XX:+UseG1GC burstcoin-jminer-0.4.4-SNAPSHOT.jar' or run the *.bat file

QUICKSTART editing 'jminer.properties'...

POOL min. required settings:
--------------------------------------------------------------------------------
plotPaths=D:/,C:/,E:/plots,F:/plots
numericAccountId=YOUR NUMERIC ACCOUNT ID
poolServer=http://pool.com

DEV-POOL min. required settings:
--------------------------------------------------------------------------------
plotPaths=D:/,C:/,E:/plots,F:/plots
numericAccountId=YOUR NUMERIC ACCOUNT ID
poolServer=http://pool.com
devPool=true

SOLO min. required settings, default server (http://localhost:8125) will be used
--------------------------------------------------------------------------------
plotPaths=D:/,C:/,E:/plots,F:/plots
poolMining=false
passPhrase=YOUR PASS PHRASE

For mor info please read description/comments in jminer.properties
CP=classes/:lib/*:lib/akka/*:lib/jetty/*
SP=src/

/bin/mkdir -p classes/

javac -sourcepath $SP -classpath $CP -d classes/ src/pocminer_pool/*.java src/pocminer_pool/*/*.java src/fr/cryptohash/*.java || exit 1

/bin/rm pocminer_pool.jar
jar cf pocminer_pool.jar -C classes . || exit 1
/bin/rm -rf classes

echo "pocminer_pool.jar generated successfully"


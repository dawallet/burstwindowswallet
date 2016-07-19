CP=classes/:lib/*:lib/akka/*:lib/jetty/*
SP=src/

/bin/mkdir -p classes/

javac -sourcepath $SP -classpath $CP -d classes/ src/pocminer/*.java src/pocminer/*/*.java src/fr/cryptohash/*.java || exit 1

/bin/rm pocminer.jar
jar cf pocminer.jar -C classes . || exit 1
/bin/rm -rf classes

echo "pocminer.jar generated successfully"


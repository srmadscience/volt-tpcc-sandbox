#!/bin/bash

#
#  Copyright (C) 2025 Volt Active Data Inc.
# 
#  Use of this source code is governed by an MIT
#  license that can be found in the LICENSE file or at
#  https://opensource.org/licenses/MIT.
# 

cd /home/ubuntu
. ./.profile

. /home/ubuntu/voltdb-ent-14.2.0-x86_64/bin/voltenv
APPNAME="tpcc"


if 
	[ ! -d logs ]
then
	mkdir logs
fi

cd volt-tpcc-sandbox
cd tpcc

# compile java source
javac -classpath $APPCLASSPATH src/com/procedures/*.java client/com/*.java
# build procedure and client jars
jar cf $APPNAME-procs.jar -C client com/Constants.class -C src com/procedures
jar cf $APPNAME-client.jar -C client com
# remove compiled .class files
rm -rf src/com/procedures/*.class client/com/*.class

sqlcmd --servers=vdb1 < ddl.sql

exit 0

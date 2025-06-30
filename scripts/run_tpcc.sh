#!/bin/bash

#
#  Copyright (C) 2025 Volt Active Data Inc.
# 
#  Use of this source code is governed by an MIT
#  license that can be found in the LICENSE file or at
#  https://opensource.org/licenses/MIT.
# 

. $HOME/.profile

VENV=`which voltenv`
. ${VENV}
APPNAME="tpcc"

cd
cd volt-tpcc-sandbox

cd scripts

sqlcmd --servers=vdb1 < clear_tables.sql

cd ..
cd tpcc

if
	[ "$#" = 3 ]
then
	DURATION=$1
	WAREHOUSES=$2
	SCALEFACTOR=$3
else
	DURATION=180
	WAREHOUSES=256
	SCALEFACTOR=22
fi

java -classpath $APPNAME-client.jar:$APPNAME-procs.jar:$APPCLASSPATH com.MyTPCC \
        --servers=`cat $HOME/.vdbhostnames` \
        --duration=${DURATION} \
        --warehouses=${WAREHOUSES} \
        --scalefactor=${SCALEFACTOR} 


exit 0

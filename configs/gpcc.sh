#!/bin/bash

echo "host all gpmon samenet trust" >> /gpdata/master/gpseg-1/pg_hba.conf
export MASTER_DATA_DIRECTORY=/gpdata/master/gpseg-1
source /usr/local/greenplum-db/greenplum_path.sh
source /usr/local/greenplum-cc-web/gpcc_path.sh
gpstart -a
#/usr/local/greenplum-cc-web-2.0.0-build-32/bin/gpcmdr --setup --config_file /tmp/gpcmdr.conf
/usr/local/greenplum-cc-web-2.0.0-build-32/bin/gpcmdr --start gpdb_docker

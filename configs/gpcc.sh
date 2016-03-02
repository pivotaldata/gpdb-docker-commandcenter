#!/bin/bash

echo "host all gpmon samenet trust" >> /gpdata/master/gpseg-1/pg_hba.conf
export MASTER_DATA_DIRECTORY=/gpdata/master/gpseg-1
source /usr/local/greenplum-db/greenplum_path.sh
source /usr/local/greenplum-cc-web/gpcc_path.sh
gpstart -a

# Detect/Create GPCC Objects on Start
result=`psql -d gpadmin -t -c "select count(*) from (select 1 from pg_roles where rolname='gpmon')z"`
if [ $result == 0 ]; then
  echo "Setting up GPCC"
  echo 'pivotal\npivotal\n'|createuser -s -l gpmon
  createdb gpperfmon
  source /usr/local/greenplum-cc-web/gpcc_path.sh 
  /usr/local/greenplum-cc-web-2.0.0-build-32/bin/gpcmdr --setup --config_file /tmp/gpcmdr.conf
fi

# Start up GPCC Instance
/usr/local/greenplum-cc-web-2.0.0-build-32/bin/gpcmdr --start gpdb_docker

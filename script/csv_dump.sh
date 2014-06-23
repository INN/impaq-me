#!/bin/bash -e

mkdir -p db/dump

PG_URL="postgres://uf4qf12qo61b6p:peaa4dspnccacqaqp30ep0lkhip@ec2-54-83-22-114.compute-1.amazonaws.com:5532/d4lmupei92e0gv"
SQL="COPY $1 TO STDOUT DELIMITER ',' CSV HEADER;"
DEST="db/dump/$1.csv"
psql $PG_URL -c "$SQL" > $DEST

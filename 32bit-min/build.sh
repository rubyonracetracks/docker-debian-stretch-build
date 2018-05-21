#!/bin/bash

if [ "$(id -u)" = "0" ]; then
   echo 'This script must be run as user' 1>&2
   exit 1
fi

DATE=`date +%Y_%m%d_%H%M_%S`
DIR_ROOT=$(dirname $PWD)
DIR_LOG=$DIR_ROOT/log
FILE_LOG=$DIR_LOG/build-$DATE.txt
mkdir -p $DIR_LOG

sh delete.sh
sh build-min.sh | tee $FILE_LOG

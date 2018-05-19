#!/bin/bash

DOCKER_IMAGE='rubyonracetracks/debian-stretch-jekyll-rubyonracetracks-com'

echo '************************************'
echo "Docker image to build: $DOCKER_IMAGE"
echo '************************************'

DIR_ROOT=$(dirname $PWD)
cp $DIR_ROOT/delete.sh $PWD

sh delete.sh $DOCKER_IMAGE

DATE=`date +%Y_%m%d_%H%M_%S`
DIR_ROOT=$(dirname $PWD)
DIR_LOG=$DIR_ROOT/log
mkdir -p $DIR_LOG

echo '****************************'
echo "BEGIN building $DOCKER_IMAGE"
echo '****************************'

docker build -t $DOCKER_IMAGE . 2>&1 | tee $DIR_LOG/build-$DATE.txt

echo '*******************************'
echo "Finished building $DOCKER_IMAGE"
echo '*******************************'

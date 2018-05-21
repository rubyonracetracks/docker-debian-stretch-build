#!/bin/bash

# Creates tgz file from chroot directory
# Example: create_tgz '32bit-debian-stretch-min-BLAH.tgz' '/var/chroot/stretch/min'
create_tgz ()
{
  TGZ_FILE=$1
  DIR_CHROOT=$2
  echo '----------------------------------'
  echo "tar cfz $TGZ_FILE -C $DIR_CHROOT ."
  tar cfz $TGZ_FILE -C $DIR_CHROOT .
  echo '----------------------'
  echo 'Recording md5sum value'
  MD5SUM1=$(md5sum $TGZ_FILE)
  echo $MD5SUM1 > "$TGZ_FILE.md5sum"
}

# Imports image from *.tgz file
# Example: import_local_image '32bit-debian-stretch-min.tgz' 'rubyonracetracks/32bit-debian-stretch-min'
import_local_image ()
{
  echo '---------------------------------------'
  echo "Removing old containers ($DOCKER_IMAGE)"
  for i in $(docker ps -a | grep $DOCKER_IMAGE | awk '{print $1}')
  do
    docker kill $i; wait;
    docker rm $i; wait;
  done;

  echo '---------------------------------'
  echo "docker ps -a | grep $DOCKER_IMAGE"
  docker ps -a | grep $DOCKER_IMAGE

  echo '--------------------------------'
  echo "Removing images of $DOCKER_IMAGE"
  for i in $(docker images -a | grep $DOCKER_IMAGE | awk '{print $3}')
    do
    docker kill $i; wait;
    docker rmi $i; wait;
  done;

  echo '-------------------------------------'
  echo "docker images -a | grep $DOCKER_IMAGE"
  docker images -a | grep $DOCKER_IMAGE

  TGZ_FILE=$1
  DOCKER_IMAGE=$2
  echo '---------------------------------------------'
  echo "cat $TGZ_FILE | docker import - $DOCKER_IMAGE"
  cat $TGZ_FILE | docker import - $DOCKER_IMAGE
}

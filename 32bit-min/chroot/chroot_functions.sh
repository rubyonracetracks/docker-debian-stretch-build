#!/bin/bash

# NOTE: This script is called from this repository's root directory
# through sudo.

# exec_chroot $1 $2
# cd into $DIR_BUILD, chroot into $1, execute $2
# NOTE: $1 is the SUB-directory, NOT the full path
exec_chroot ()
{
  export DEBIAN_FRONTEND='noninteractive'
  export DEBCONF_NOWARNINGS='true'
  export HOME=/root
  export LC_ALL=C
  # Note that an argument with a space is actually treated as two arguments.
  # The following code corrects this.
  DIR_CHROOT=$1
  shift # $2 becomes the new $1, $3 becomes the new $2, etc.
  COMMAND_CHROOT=''
  while [ $# -gt 0 ]
    do # Until there is nothing to add to COMMAND_CHROOT
      COMMAND_CHROOT=$COMMAND_CHROOT' '$1
      shift # $2 becomes the new $1, $3 becomes the new $2, etc.
  done 
  chroot $DIR_CHROOT $COMMAND_CHROOT
}

# EXAMPLE: create_debian 'rubyonracetracks' 'stretch' '/var/chroot/stretch/min'
create_debian ()
{
  # Settings
  OWNER=$1
  SUITE=$2
  DIR_CHROOT=$3
  APT_MIRROR='http://httpredir.debian.org/debian'
  ARCH=i386

  echo '------------------'
  echo "rm -rf $DIR_CHROOT"
  rm -rf $DIR_CHROOT

  sudo apt-get update

  # Make sure that the required tools are installed in the host system
  echo '----------------------------------------'
  echo 'apt-get install -y debootstrap coreutils'
  apt-get install -y debootstrap coreutils # coreutils: md5sum

  # Add jessie (needed for dchroot)
  echo '-------------'
  echo 'Adding jessie'
  echo 'deb http://http.debian.net/debian jessie main' | sudo tee /etc/apt/sources.list.d/jessie.list
  apt-get update

  # Make sure that the required tools are installed in the host system
  echo '--------------------------'
  echo 'apt-get install -y dchroot'
  apt-get install -y dchroot

  # Remove jessie
  echo '-------------'
  echo 'Remove jessie'
  rm /etc/apt/sources.list.d/jessie.list
  apt-get update

  echo '***************************************'
  echo 'BEGIN Debian from scratch (debootstrap)'
  echo '***************************************'
  echo '-------------------------------------------------------------------------------------------'
  echo "debootstrap --arch $ARCH --variant=minbase --components=main $SUITE $DIR_CHROOT $APT_MIRROR"
  debootstrap --arch $ARCH --variant=minbase --components=main $SUITE $DIR_CHROOT $APT_MIRROR
  echo '******************************************'
  echo 'FINISHED Debian from scratch (debootstrap)'
  echo '******************************************'
}

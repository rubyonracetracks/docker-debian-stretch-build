#!/bin/bash

if [ "$(id -u)" = "0" ]; then
   echo 'This script must be run as user' 1>&2
   exit 1
fi

OWNER='rubyonracetracks'
DISTRO='debian'
SUITE='stretch'
DATE=`date +%Y_%m%d_%H%M_%S`
UNAME=`whoami`

TGZ1="$DISTRO-$SUITE-min.tgz"
TGZ2="$DISTRO-$SUITE-min-$DATE.tgz"
sudo sh debootstrap.sh $OWNER $DISTRO $SUITE $TGZ1 $TGZ2 $UNAME

DOCKER_IMAGE=$OWNER/32bit-$DISTRO-$SUITE-'min'

echo ''
echo '*******************************************************'
echo "Check this new image ($DOCKER_IMAGE) before pushing it."
echo 'Verify that the sanity checks performed during the'
echo 'build process produced the expected results.'
echo ''
sleep 0.1s
read -p "Are you ready to push this new image? (y/n) " choice
case "$choice" in 
  y|Y )
    echo '-------------------------'
    echo "docker push $DOCKER_IMAGE"
    docker push $DOCKER_IMAGE
    ;;
  * )
    echo '-------------------------'
    echo "Not pushing $DOCKER_IMAGE"
    echo 'If you wish to push this image, enter the following command:'
    echo "docker push $DOCKER_IMAGE"
  ;;
esac

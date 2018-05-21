#!/bin/bash

ABBREV='rails-general'
DOCKER_IMAGE="rubyonracetracks/debian-stretch-$ABBREV"

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

rm -rf $PWD/usr_local_bin
cp -r $DIR_ROOT/$ABBREV/usr_local_bin $PWD

docker build -t $DOCKER_IMAGE . 2>&1 | tee $DIR_LOG/build-$DATE.txt

echo '*******************************'
echo "Finished building $DOCKER_IMAGE"
echo '*******************************'

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

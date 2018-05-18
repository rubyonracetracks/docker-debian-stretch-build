#!/bin/bash

# Clean up
echo '++++++++++++++++++++++++++++++++++'
echo 'BEGIN cleaning up the Docker image'
echo '++++++++++++++++++++++++++++++++++'

echo '-------------'
echo 'cd / && du -s'
cd / && du -s

echo '-----------------'
echo "apt-get -y clean;"
apt-get -y clean;

echo '-----------------'
echo "apt-get autoclean"
apt-get autoclean

echo '----------------------'
echo "rm -rf /usr/share/doc;"
rm -rf /usr/share/doc;

echo '------------------------------------------'
echo "find /var/cache -type f -exec rm -rf {} \;"
find /var/cache -type f -exec rm -rf {} \;

echo '----------------------------------------------------------'
echo "find /var/lib/apt/lists -maxdepth 1 -type f -exec rm {} \;"
find /var/lib/apt/lists -maxdepth 1 -type f -exec rm {} \;

echo '-----------------------------------------------------'
echo 'Removing non-English languages from /usr/share/locale'
for lang in $(ls /usr/share/locale | grep -v ^en)
do
  rm -rf /usr/share/locale/$lang
done

echo '-------------'
echo 'cd / && du -s'
cd / && du -s

echo '+++++++++++++++++++++++++++++++++++++'
echo 'FINISHED cleaning up the Docker image'
echo '+++++++++++++++++++++++++++++++++++++'

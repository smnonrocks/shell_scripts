#!/bin/bash

rm -fr /home/subhankar/Desktop/local_repo/
rm -fr /home/subhankar/Desktop/local_repo.zip
mkdir /home/subhankar/Desktop/local_repo
cp -r /var/cache/apt/archives/*.deb /home/subhankar/Desktop/local_repo/
cd /home/subhankar/Desktop/local_repo/
rm -fr Packages.gz
dpkg-scanpackages . /dev/null | gzip -9c > Packages.gz
cd ..
zip -r local_repo.zip local_repo

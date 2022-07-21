#!/bin/bash

source check_env_file.sh

source git_process.sh "${1}"

echo 'RUN: '
sed -i "s/goldrush_prod_web:1.3.0/goldrush_cookie_kohls:latest/" Dockerrun.aws.json

echo 'RUN: '
git add Dockerrun.aws.json
echo 'RUN: '
git commit -m "kohls ${versionname}"

#./deployToFleet.sh -i kohls-sampling -r us-east-1 -p prod -g | tee ../../release_kohls_"${versionname}".log

gitEnd

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo
echo "Release $versionname to Kohls has been successfully deployed"
echo
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
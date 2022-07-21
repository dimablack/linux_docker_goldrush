#!/bin/bash

source check_env_file.sh

source git_process.sh "${1}"

sed -i "s/goldrush_prod_web:1.3.0/goldrush_cookie_kohls:latest/" Dockerrun.aws.json

git add Dockerrun.aws.json
git commit -m "kohls ${versionname}"

#./deployToFleet.sh -i kohls-sampling -r us-east-1 -p prod -g | tee ../../release_kohls_"${versionname}".log

git restore --staged .
git checkout -- .
git clean -f

git reset --hard HEAD~1

git checkout develop
cd ..

echo
echo "Returned to develop branch"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo
echo "Release $versionname to Kohls has been successfully deployed"
echo
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
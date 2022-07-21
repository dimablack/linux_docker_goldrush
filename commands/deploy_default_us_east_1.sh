#!/bin/bash

source check_env_file.sh

source git_process.sh "${1}"

#./deployToFleet.sh -r us-east-1 -p default -g | tee ../release_${versionname}_us_default.log

git restore --staged .
git checkout -- .
git clean -f

git checkout develop
cd ..

echo
echo "Returned to develop branch"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo
echo "Release $versionname to Profile default | region us-east-1 has been successfully deployed"
echo
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
#!/bin/bash

source check_env_file.sh

source git_process.sh "${1}"

#./deployToFleet.sh -r eu-west-1 -p prod -g | tee ../release_"${versionname}"_us_default.log

gitEnd

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo
echo "Release $versionname to Profile prod | region eu-west-1 has been successfully deployed"
echo
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
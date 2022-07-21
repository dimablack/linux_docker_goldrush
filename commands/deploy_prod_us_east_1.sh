#!/bin/bash

source check_env_file.sh

source git_process.sh "${1}"

sed -i "s/BLACKLISTED=('')/BLACKLISTED=('kohls-sampling')/" deployToFleet.sh

./deployToFleet.sh -r us-east-1 -p prod -g | tee ../release_"${versionname}"_us_default.log

gitEnd

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo
echo "Release $versionname to Profile prod | region us-east-1 has been successfully deployed"
echo
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"


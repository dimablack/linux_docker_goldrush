#!/bin/bash

source ./check_env_file.sh

versionname="${1}"

if [ -z "$1" ]
  then
    echo
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo
    echo "Enter release version | git checkout ...|:?"
    read -r versionname
fi

source deploy_default_us_east_1.sh "${versionname}"
source deploy_prod_eu_west_1.sh "${versionname}"
source deploy_prod_us_east_1.sh "${versionname}"
source deploy_kohls.sh "${versionname}"


echo
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "~                              SUCCESS                              ~"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo
echo "Release $versionname has been successfully deployed to all instances in all regions "
echo
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
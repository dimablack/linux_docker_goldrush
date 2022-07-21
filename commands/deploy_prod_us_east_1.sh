#!/bin/bash

source check_env_file.sh

versionname="${1}"

if [ -z "$1" ]
  then
    echo
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo
    echo "Enter release version | git checkout ...|:?"
    read versionname
fi

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Removing goldrush folder..."
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
rm -rf goldrush

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Clone new goldrush repository..."
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
git clone git@github.com:bazaarvoice/goldrush.git

cd goldrush

function checkVersion() {
git checkout "${versionname}"
status=$?
echo $status
if [ $status -ne 0 ]
  then
    echo
    echo 'Wrong version name, try again:'
    if [ -z "$1" ]
    then
      echo
      echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      echo
      echo "Enter release version | git checkout ...|:?"
      read -r versionname
      checkVersion
    fi
fi
}

checkVersion

git checkout "${versionname}"

git config --global user.email "${GIT_GLOBAL_USER_EMAIL}"
git config --global user.name "${GIT_GLOBAL_USER_NAME}"

sed -i "s/BLACKLISTED=('')/BLACKLISTED=('kohls-sampling')/" deployToFleet.sh

#./deployToFleet.sh -r us-east-1 -p prod -g | tee ../release_"${versionname}"_us_default.log

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
echo "Release $versionname to Profile prod | region us-east-1 has been successfully deployed"
echo
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"


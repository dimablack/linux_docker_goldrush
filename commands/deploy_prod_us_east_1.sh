#!/bin/bash

# Local .env
if [ -f .env ]; then
    # Load Environment Variables
    export $(cat .env | grep -v '#' | sed 's/\r$//' | awk '/=/ {print $1}' )
fi

echo "GIT_GLOBAL_USER_EMAIL=${GIT_GLOBAL_USER_EMAIL}"
echo "GIT_GLOBAL_USER_NAME=${GIT_GLOBAL_USER_NAME}"

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

git checkout $versionname

git config --global user.email "${GIT_GLOBAL_USER_EMAIL}"
git config --global user.name "${GIT_GLOBAL_USER_NAME}"

sed -i "s/BLACKLISTED=('')/BLACKLISTED=('kohls-sampling')/" deployToFleet.sh

./deployToFleet.sh -r us-east-1 -p prod -g | tee ../release_${versionname}_us_default.log

git restore --staged .
git checkout -- .
git clean -f

git checkout develop

echo "Returned to develop branch"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Profile prod | region us-east-1 has been successfully deployed"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"


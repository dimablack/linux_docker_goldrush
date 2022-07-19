#!/bin/bash

# Local .env
if [ -f .env ]; then
    # Load Environment Variables
    export $(cat .env | grep -v '#' | sed 's/\r$//' | awk '/=/ {print $1}' )
fi

#cat .env
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

sed -i "s/goldrush_prod_web:1.3.0/goldrush_cookie_kohls:latest/" Dockerrun.aws.json

git config --global user.email "${GIT_GLOBAL_USER_EMAIL}"
git config --global user.name "${GIT_GLOBAL_USER_NAME}"

git add Dockerrun.aws.json
git commit -m "kohls ${versionname}"

./deployToFleet.sh -i kohls-sampling -r us-east-1 -p prod -g | tee ../../release_kohls_${versionname}.log

git restore --staged .
git checkout -- .
git clean -f

git reset --hard HEAD~1

git checkout develop

echo "Returned to develop branch"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Kohls has been successfully deployed"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
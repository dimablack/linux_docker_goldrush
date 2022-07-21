#!/bin/bash

source check_env_file.sh

versionname="${1}"

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Removing goldrush folder..."
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
#rm -rf goldrush

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Clone new goldrush repository..."
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
#git clone git@github.com:bazaarvoice/goldrush.git
#if [ $? -ne 0 ]
#then
#  startPrintWarning
#  echo 'There was some error when execute: "git clone git@github.com:bazaarvoice/goldrush.git"'
#  endPrintWarning
#fi

cd goldrush
if [ $? -ne 0 ]
then
  startPrintWarning
  echo 'There was some error when execute: "cd goldrush"'
  endPrintWarning
fi

function checkVersion() {
git checkout "${versionname}"
if [ $? -ne 0 ]
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

git config --global user.email "${GIT_GLOBAL_USER_EMAIL}"
git config --global user.name "${GIT_GLOBAL_USER_NAME}"

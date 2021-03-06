#!/bin/bash

source check_env_file.sh

versionname="${1}"

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Removing goldrush folder..."
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo 'RUN: rm -rf goldrush ...'
rm -rf goldrush

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Clone new goldrush repository..."
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo 'RUN: git clone git@github.com:bazaarvoice/goldrush.git ...'
git clone git@github.com:bazaarvoice/goldrush.git
if [ $? -ne 0 ]
then
  startPrintWarning
  echo 'There was some error when execute: "git clone git@github.com:bazaarvoice/goldrush.git"'
  endPrintWarning
  exit
fi

echo 'RUN: cd goldrush ...'
cd goldrush
if [ $? -ne 0 ]
then
  startPrintWarning
  echo 'There was some error when execute: "cd goldrush"'
  endPrintWarning
  exit
fi

function checkVersion() {
echo 'RUN:  ...'
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

function gitEnd() {
  echo 'RUN: git restore --staged . ...'
  git restore --staged .
  echo 'RUN: git checkout -- . ...'
  git checkout -- .
  echo 'RUN: git clean -f ...'
  git clean -f

  echo 'RUN: git reset --hard HEAD~1 ...'
  git reset --hard HEAD~1

  echo 'RUN: git checkout develop ...'
  git checkout develop
  echo 'RUN: cd .. ...'
  cd ..

  echo
  echo "Returned to develop branch"
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo
}
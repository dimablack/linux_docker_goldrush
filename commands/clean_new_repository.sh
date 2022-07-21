#!/bin/bash

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

echo 'RUN: cd goldrush ...'
cd goldrush

git config --global user.email "${GIT_GLOBAL_USER_EMAIL}"
git config --global user.name "${GIT_GLOBAL_USER_NAME}"


echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "The last version of the repository has been successfully cloned"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

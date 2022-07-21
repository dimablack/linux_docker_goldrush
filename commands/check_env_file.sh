#!/bin/bash

function startPrintWarning ()
{
  echo
  echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
  echo '~                   WARNING                   ~'
  echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
  echo
  echo
}

function endPrintWarning ()
{
  echo
  echo
  echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
  echo
}

# Local .env
if [ -f .env ]; then
  # Load Environment Variables
  export $(cat .env | grep -v '#' | sed 's/\r$//' | awk '/=/ {print $1}' )
else
  startPrintWarning
  echo 'Create .env (see .env.copy) file with next ENV_VARIABLES:'
  echo
  echo 'GIT_GLOBAL_USER_EMAIL='
  echo 'GIT_GLOBAL_USER_NAME='
  endPrintWarning
  exit
fi

if [[ -z "${GIT_GLOBAL_USER_EMAIL}" ]]
then
  startPrintWarning
  echo 'GIT_GLOBAL_USER_EMAIL in .env file is empty or unset, please create it'
  endPrintWarning
  exit
else
  :
fi

if [[ -z "${GIT_GLOBAL_USER_NAME}" ]]
then
  startPrintWarning
  echo 'GIT_GLOBAL_USER_NAME in .env file is empty or unset, please create it'
  endPrintWarning
  exit
else
  :
fi
#!/bin/bash
#
# A simple script, which purpose is to point the docker cli to the specified
# remote docker engine (specified as a docker-machine host). If no arguments
# is passed, then it will fallback to the local docker-engine.
#
# Note! passing "localhost" as the parameter will unset absolutely all
# environment variables containing the "DOCKER" keyword
#
# *** Setup and Use ***
#
# 1) Place this file in your PATH
#
# 2) Append the following line to your .bashrc:
#    alias docker-host=". ./docker-host.sh"
#
# 3) To point the docker cli to a specified docker-machine node, run:
#    docker-host connect <DOCKER_MACHINE_NAME>
#
#    Or, to point the docker cli to your local docker engine, run:
#    docker-host connect
#
#   Or, to list all possible hosts, run:
#   docker-host ls
#
function ls-running-machines () {
    docker-machine ls | grep Running
}

if [ -z "$1" ] || [ "$1" = "help" ] || [ "$1" = "h" ];
then
  echo
  echo " Usage: docker-host [MACHINE_NODE|COMMAND]"
  echo
  echo " MACHINE_NODE:           Connect the docker cli to the specified machine node."
  echo
  echo " COMMAND:"
  echo " localhost               Ensures the docker cli is reconnected with the docker engine running on the docker cli host "
  echo " ls                      Lists all running docker machines"
  echo " help                    Show this help menu"
  echo
elif [ "$1" = "local" ] || [ "$1" = "localhost" ] || [ "$1" = "l" ];
then
  docker_env_vars=$(printenv | grep '^DOCKER_')
  echo
  if [ -z "$docker_env_vars" ];
  then
    echo "The docker cli is already connected with you local docker engine."
  else
    echo "The operation will unset the following variables:"
    echo "---"
    echo "$docker_env_vars"
    echo "---"
    unset $(echo $docker_env_vars | sed -E "s/(.*)=.*/\1/g");
    echo
    ls-running-machines
    echo
    echo "The docker cli is now connected to the local docker engine."
  fi
elif [ "$1" = "ls" ];
then
  ls-running-machines
else
    eval $(docker-machine env $1)
    ls-running-machines
fi

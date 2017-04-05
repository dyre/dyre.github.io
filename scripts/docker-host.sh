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
#    docker-host reset
#
#   Or, to list all possible hosts, run:
#   docker-host ls
#
function ls-running-machines () {
    docker-machine ls | grep Running
}

if [[ "$1" == "ls" ]];
then
  ls-running-machines
elif [[ "$1" == "reset" ]];
then
  for line in $(printenv | grep '^DOCKER_'); do
    echo "Unset $line"
    unset $(echo $line | sed -E "s/(.*)=.*/\1/g");
  done
  echo
  ls-running-machines
  echo
  echo "The docker cli is now connected to the local docker engine."
elif [[ "$1" == "connect" && ! -z "$2" ]];
then
  eval $(docker-machine env $2)
  ls-running-machines
else
  echo
  echo " Usage: docker-host [option]"
  echo
  echo " Options:"
  echo " connect <MACHINE_NODE>         Connect to the machine node"
  echo " reset                          Removes connection with remote docker host"
  echo " ls                             Lists all running docker machines"
  echo " help                           Show this help menu"
  echo
fi

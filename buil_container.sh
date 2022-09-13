#!/bin/bash
#
#
#

function main(){
  clear
  echo "Iniciando processo de criacao de Container"
  sleep 2
  echo "-------------------------------------------"
  create_image
  sleep 2
  echo "-------------------------------------------"
  create_volume
  sleep 2
  echo "-------------------------------------------"
  create_container
  sleep 2
  echo "-------------------------------------------"
  echo -e "\033[32m Finished \033[m"
  sleep 2
  echo "-------------------------------------------"
  /usr/bin/docker ps -a
}

function verivay_container(){
  unset VAR
  VAR=`/usr/bin/docker ps -aq -f name=smart_prd`
  if [ -z $VAR ]; then
    echo -n "Container is Not Found "
    echo -e "\033[31m Warning \033[m"
  else
    echo -n "Container Found "
    echo -e "\033[31m Success \033[m"
  fi
  sleep 2
}

function create_image(){
  /usr/bin/docker build -t smart_prd:latest . > /dev/null 2>&1 &
  #ls -la > /dev/null 2>&1 &
  if [ $? = 0 ]; then
    echo -n "Image django for Docker Created Successfully "
    echo -e "\033[32m Ok \033[m"
  else
    echo -n "Ops! Error created docker image"
    echo -e "\033[31m Error \033[m"
    exit 0
  fi
  sleep 2
}

function create_volume(){
  /usr/bin/docker volume create --driver local --name smart_prd_vol > /dev/null 2>&1 &
  # ls -la > /dev/null 2>&1 &
  if [ $? = 0 ]; then
    echo -n "Volume Created Succesfully "
    echo -e "\033[32m Ok \033[m"
  else
    echo -n "Ops Error to create volume "
    echo -e "\033[31m Error \033[m"
    exit 1
  fi
  sleep 2
}

function create_container(){
  /usr/bin/docker run -d -it -p 7000:7000 --name smart_prd --hostname=smart_prd --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v smart_prd_vol:/usr/src/app smart_prd:latest
  #ls -la > /dev/null 2>&1 &
  if [ $? = 0 ]; then
    echo -n "Container Created Successfuly "
    echo -e "\033[32m Ok \033[m"
  else
    echo -n "Ops! Any Error on try create container"
    echo -e "\033[31m Error \033[m"
    exit 3
  fi
}

main
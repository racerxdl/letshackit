#!/bin/bash

if [ -e /run/secrets/ ]
then
  for i in /run/secrets/*
  do
    VARNAME=`basename ${i}`
    echo "Importing Secret ${VARNAME}"
    declare $VARNAME=`cat ${i}`
  done
fi

echo "Starting NGINX"

/usr/sbin/nginx

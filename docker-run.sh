#! /bin/bash

NAME=dk

XQUARTZ_RUNNING=$(ps x | grep XQuartz | grep -v grep)
if [ -z "$XQUARTZ_RUNNING" ]; then
    open -a XQuartz
    xhost +localhost
fi

ID=$(docker ps -q -a --filter name=^/$NAME$)

if [ -z "$ID" ]; then
    echo "Launching Container"
    docker run -it --name $NAME -e DISPLAY=host.docker.internal:0 -v "$PWD:/$NAME" -w /$NAME nesdev bash
else
    echo "Restarting Container $ID"
    docker start $ID
    docker attach $ID
fi

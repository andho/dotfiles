#!/bin/bash
source $HOME/.bashrc
if [ -f /tmp/whereami ]
then
    WHEREAMI=$(cat /tmp/whereami)
    if [ -f $WHEREAMI ]
    then
        WHEREAMI=$HOME
    fi
else
    WHEREAMI=$HOME
fi
alacritty --working-directory="$WHEREAMI"

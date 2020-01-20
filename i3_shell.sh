#!/bin/bash
source $HOME/.bashrc
if [ -f /tmp/whereami ]
then
    WHEREAMI=$(cat /tmp/whereami)
else
    WHEREAMI=$HOME
fi
termite --directory="$WHEREAMI"

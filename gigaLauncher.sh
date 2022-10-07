#!/bin/bash

export GIGA_SW_PATH="/home/pi/gigaSW"
echo ${GIGA_SW_PATH}/rs485/rx
sleep 10
bash ${GIGA_SW_PATH}/rs485/rxLoop.sh
xterm -fullscreen -e 'bash ${GIGA_SW_PATH}/main.sh'

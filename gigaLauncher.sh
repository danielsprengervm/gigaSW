#!/bin/bash

sleep 10
sudo bash /home/pi/gigaSW/rs485/rxLoop.sh
xterm -fullscreen -e 'sudo bash /home/pi/gigaSW/main.sh'

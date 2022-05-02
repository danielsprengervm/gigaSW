#!/bin/sh

rx=$(python /home/pi/gigaSW/rs485/test485.py)
if [[ "${rx}" == *"Ok"* ]]; then
	exit 0
else
	exit 1
fi

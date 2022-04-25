#!/bin/sh

rx=$(python rs485/test485.py)
if [[ "${rx}" == *"Ok"* ]]; then
	exit 0
else
	exit 1
fi

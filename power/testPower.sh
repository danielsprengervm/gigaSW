#!/bin/bash

raspi-gpio set 21 ip pu

rx=$(raspi-gpio get 21)
if [[ "${rx}" != *"level=0"* ]]; then
	echo "Vout desligado"
	exit 1
fi

#teste Watchdog
success=0
startTime=$(date +%s)
now=$(date +%s)
python ${GIGA_SW_PATH}/power/setWd100.py
while [[ $((now)) -le $((startTime+2)) ]]
do
	rx=$(raspi-gpio get 21)
	if [[ "${rx}" == *"level=1"* ]]; then
		success=1
		break
	fi
	now=$(date +%s)
done

if [ $success -eq 0 ]; then
	echo "Falha watchdog"
	exit 2
fi
echo "Watchdog OK"
exit 0

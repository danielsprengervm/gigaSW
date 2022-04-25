#!/bin/sh

raspi-gpio set 7 ip
raspi-gpio set 7 pd

#configSS
raspi-gpio set 5 op
raspi-gpio set 5 dl

rx=$(raspi-gpio get 7)
if [[ "${rx}" != *"level=0"* ]; then
	echo "Vout desligado"
	exit 1
fi

#teste Watchdog
success=0
startTime=$(date +%s)
now=$(date +%s)
python setWd1000.py
while [[ $((now)) -le $((startTime+3)) ]]
do
	rx=$(raspi-gpio get 7)
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

#teste EN_PWR
raspi-gpio set 6 op
raspi-gpio set 6 dl
sucess=0
startTime=$(date +%s)
now=$(date +%s)
raspi-gpio set 6 dh
while [[ $((now)) -le $((startTime+3)) ]]
do
	rx=$(raspi-gpio get 7)
	if [[ "${rx}" == *"level=1"* ]]; then
		success=1
		break
	fi
	now=$(date +%s)
done

if [ $success -eq 0 ]; then
	echo "Falha EN_PWR"
	exit 3
echo "EN_PWR OK"
exit 0

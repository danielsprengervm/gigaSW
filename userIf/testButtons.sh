#!/bin/bash

#Testa botoes SW1, SW2 e leds

#teste botão SW1
raspi-gpio set 18 ip
raspi-gpio set 18 pu
rx_gpio=" "
rx_gpio=$(raspi-gpio get 18)
if [[ "${rx_gpio}" != *"level=1"* ]]; then
	echo "Falha SW1"
	exit 1
fi

echo "pressione o SW1"
success=0
startTime=$(date +%s)
now=$(date +%s)
while [[ $((now)) -le $((startTime+10)) ]]
do
	rx_gpio=$(raspi-gpio get 18)
	if [[ "${rx_gpio}" == *"level=0"* ]]; then
		success=1
		break
	fi
	now=$(date +%s)
done

if [ $success -eq 0 ]; then
	echo "Falha SW1"
	exit 2
fi
echo "SW1 ok"

#Teste SW2
raspi-gpio set 7 ip
raspi-gpio set 7 pd
rx_gpio=$(raspi-gpio get 7)
if [[ "${rx_gpio}" != *"level=0"* ]]; then
	echo "Falha SW2"
	exit 3
fi

echo "Pressione SW2"
success=0
startTime=$(date +%s)
now=$(date +%s)
while [ $((now)) -le $((startTime+10)) ]]
do
	rx_gpio=$(raspi-gpio get 7)
	if [[ "${rx_gpio}" == *"level=1"* ]]; then
		success=1
		break
	fi
	now=$(date +%s)
done
if [ $success -eq 0 ]; then
	echo "Falha SW2"
	exit 4
echo "SW2 ok"

exit 0



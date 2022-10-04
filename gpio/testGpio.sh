#!/bin/bash

#Testa a entrada e saída da IF1 e IF2

if1_out="12"
if1_in="20"

if2_out="13"
if2_in="27"

#config IF1
raspi-gpio set ${if1_in} ip pn
raspi-gpio set ${if1_out} op
#config IF2
raspi-gpio set ${if2_in} ip pn
raspi-gpio set ${if2_out} op

#teste IF1
raspi-gpio set ${if1_out} dh
raspi-gpio set ${if2_out} dl
sleep 0.1
rx_gpio1=$(raspi-gpio get ${if1_in})
rx_gpio2=$(raspi-gpio get ${if2_in})
if [[ "${rx_gpio1}" != *"level=1"* || "${rx_gpio2}" != *"level=0"* ]]; then
	echo "Erro GPIO IF1"
	exit 1
fi

raspi-gpio set ${if1_out} dl
raspi-gpio set ${if2_out} dl
sleep 0.1
rx_gpio1=$(raspi-gpio get ${if1_in})
rx_gpio2=$(raspi-gpio get ${if2_in})
if [[ "${rx_gpio1}" != *"level=0"* || "${rx_gpio2}" != *"level=0"* ]]; then
	echo "Erro GPIO IF1"
	exit 2
fi
#Teste IF2
raspi-gpio set ${if1_out} dl
raspi-gpio set ${if2_out} dh
sleep 0.1
rx_gpio1=$(raspi-gpio get ${if1_in})
rx_gpio2=$(raspi-gpio get ${if2_in})
if [[ "${rx_gpio1}" != *"level=0"* || "${rx_gpio2}" != *"level=1"* ]]; then
	echo "Erro GPIO IF2"
	exit 3
fi
raspi-gpio set ${if1_out} dl
raspi-gpio set ${if2_out} dl
sleep 0.1
rx_gpio1=$(raspi-gpio get ${if1_in})
rx_gpio2=$(raspi-gpio get ${if2_in})
if [[ "${rx_gpio1}" != *"level=0"* || "${rx_gpio2}" != *"level=0"* ]]; then
	echo "Erro GPIO IF2"
	exit 4
fi

echo "Teste GPIO OK"
exit 0

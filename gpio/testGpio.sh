#!/bin/bash

#Testa a entrada e saída da IF1 e IF2

#config IF1
raspi-gpio set 19 ip
raspi-gpio set 19 pn
raspi-gpio set 16 op
#config IF2
raspi-gpio set 12 ip
raspi-gpio set 12 pn
raspi-gpio set 13 op

#teste IF1
raspi-gpio set 16 dh
raspi-gpio set 13 dl
sleep 0.5
rx_gpio1=$(raspi-gpio get 19)
rx_gpio2=$(raspi-gpio get 12)
if [[ "${rx_gpio1}" != *"level=1"* || "${rx_gpio2}" != *"level=0"* ]]; then
	echo "Erro GPIO IF1"
	exit 1
fi

raspi-gpio set 16 dl
raspi-gpio set 13 dl
sleep 0.5
rx_gpio1=$(raspi-gpio get 19)
rx_gpio2=$(raspi-gpio get 12)
if [[ "${rx_gpio1}" != *"level=0"* || "${rx_gpio2}" != *"level=0"* ]]; then
	echo "Erro GPIO IF1"
	exit 2
fi
#Teste IF2
raspi-gpio set 16 dl
raspi-gpio set 13 dh
sleep 0.5
rx_gpio1=$(raspi-gpio get 19)
rx_gpio2=$(raspi-gpio get 12)
if [[ "${rx_gpio1}" != *"level=0"* || "${rx_gpio2}" != *"level=1"* ]]; then
	echo "Erro GPIO IF2"
	exit 3
fi
raspi-gpio set 16 dl
raspi-gpio set 13 dl
sleep 0.5
rx_gpio1=$(raspi-gpio get 19)
rx_gpio2=$(raspi-gpio get 12)
if [[ "${rx_gpio1}" != *"level=0"* || "${rx_gpio2}" != *"level=0"* ]]; then
	echo "Erro GPIO IF2"
	exit 4
fi

echo "Teste GPIO OK"
exit 0

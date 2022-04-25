#!/bin/sh

#Testa os leds, n tem feedback entao sempre retorna 0


raspi-gpio set 17 op
raspi-gpio set 25 op
echo "Teste dos leds"
echo "Verifique se os leds verde e vermelho piscam alternadamente"
aux=0
for i in {1..10}
do
        if [ $aux -eq 0 ]; then
                raspi-gpio set 17 dl
                raspi-gpio set 25 dh
                aux=1
        else
                raspi-gpio set 17 dh
                raspi-gpio set 25 dl
                aux=0
        fi
        sleep 0.5
done
raspi-gpio set 17 dl
raspi-gpio set 25 dl
sleep .25
raspi-gpio set 17 dh
raspi-gpio set 25 dh
sleep 0.5
raspi-gpio set 17 dl
raspi-gpio set 25 dl
echo "Teste dos leds finalizado"

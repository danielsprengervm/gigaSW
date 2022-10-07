#!/bin/bash

# Testa a comunicação entre RPi e ATM com protocolo e o comando do pino de reset

#habilita SS
raspi-gpio set 5 op
raspi-gpio set 5 dl

spi_rx=" "
echo "Testando a comunicação SPI..."
spi_rx=$(python ${GIGA_SW_PATH}/spi/spiComm.py)
if [[ "${spi_rx}" != "Ok" ]]; then
	echo "Falha na comunicação SPI"
	exit 1
fi

echo "Comunicacao SPI ok!"
echo "Testando reset do ATM..."
# reset uC
raspi-gpio set 4 op
raspi-gpio set 4 dl
sleep 1

spi_ngood="Nok"
spi_rx=" "
spi_rx=$(python ${GIGA_SW_PATH}/spi/spiComm.py)
# nresetUc
raspi-gpio set 4 ip
raspi-gpio set 4 pn
sleep 1
if [[ "${spi_rx}" != "Nok" ]]; then
	echo "Falha no reset do ATM"
	exit 2
fi

exit 0


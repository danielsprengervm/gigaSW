#!/bin/bash

# Testa os PUPs dos pinos que leem o estado do carregador
# Retorna 0 se os pinos estiverem integros ou 1 caso contrario

raspi-gpio set 5 op
raspi-gpio set 5 dl
spi_rx=" "
echo "Testando a leitura do carregador"
spi_rx=$(python ${GIGA_SW_PATH}/spi/getChg.py)
if [[ "${spi_rx}" != "Ok" ]]; then
	echo "Falha na leitura do carregador"
	exit 1
fi

echo "Leitura do carregador ok"
exit 0

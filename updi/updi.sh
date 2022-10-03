#!/bin/bash

# Teste da interface UPDI, pinga o dispositivo, apaga a memoria,
# grava flash e fuse do reset
# retorna 0 se houver tudo bem e outro valor dependendo do erro que ocorreu 
# ocorrer bem.

# Pendente implementacao com multiplexacao da UART por HW
#- - - - - - - - - 

ping_good="Ping response"
ping_rx=" "
echo "Testando conexao com o ATM3208..."
ping_rx=$(pymcuprog ping -t uart -u /dev/ttyAMA0 -d atmega3208)
if [[ "${ping_rx}" == *"${ping_good}"* ]]; then
	echo "Conexão com o ATM3208 OK!"
else
	sleep 1
	echo "Falha na conexão com o ATM3208"
	exit 1
fi

echo "Iniciando a gravacao do firmware do ATM3208"
erase_good="Erased"
erase_rx=" "
erase_rx=$(pymcuprog erase -t uart -u /dev/ttyAMA0 -d atmega3208)
if [[ "${erase_rx}" != *"${erase_good}"* ]]; then
	sleep 1
	echo "Falha apagando a memória"
	exit 2
fi

write_good="Done"
write_rx=" "
write_rx=$(pymcuprog write -t uart -u /dev/ttyAMA0 -d atmega3208 -f ${GIGA_SW_PATH}/updi/box5_fw100.hex)
if [[ "${write_rx}" != *"${write_good}"* ]]; then
	sleep 1
	echo "Falha na gravacao do firmware"
	exit 3
fi

write_rx=" "
write_rx=$(pymcuprog write -t uart -u /dev/ttyAMA0 -d atmega3208 -m fuses -o 0x05 -l 0xC8)
if [[ "${write_rx}" != *"${write_good}"* ]]; then
	sleep 1
	echo "Falha na gravacao do fuse"
	exit 4
fi

echo "Gravacao Finalizada com sucesso"
exit 0


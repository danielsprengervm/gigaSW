#!/bin/bash

# Gravacao da aplicacao do ATM via bootloader SPI.
# Exige que o bootloader tenha sido gravado via UPDI previamente
# Retorna 0 se ok, outro valor dependendo do erro

# - - - - - - -

echo "Gravando FW do ATM..."
bash /home/pi/gigaSW/spi/resetUc.sh
python /home/pi/gigaSW/spi/ATMprogrammer.py app100.bin
if [[ $? -ne 0 ]]; then
	echo "Erro na gravacao do Firmware"
	exit 1
echo "Gravacao Finalizada com sucesso"
exit 0

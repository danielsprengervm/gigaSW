#!/bin/bash

# Gravacao da aplicacao do ATM via bootloader SPI.
# Exige que o bootloader tenha sido gravado via UPDI previamente
# Retorna 0 se ok, outro valor dependendo do erro

# - - - - - - -

echo "Gravando FW do ATM..."
bash ${GIGA_SW_PATH}/spi/resetUc.sh
python ${GIGA_SW_PATH}/spi/ATMprogrammer.py ${GIGA_SW_PATH}/spi/ATMvmbox5v15.bin
if [[ $? -ne 0 ]]; then
	echo "Erro na gravacao do Firmware"
	exit 1
fi
echo "Gravacao Finalizada com sucesso"
exit 0

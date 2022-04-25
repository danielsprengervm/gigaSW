#!/bin/sh

# Testa escrita e leitura na EEPROM e WP
# retorna 0 se o teste for aprovado

#WNP
raspi-gpio set 20 op
raspi-gpio set 20 dh

i2cset -y 0 0x50 0 0 0xaa i
i2cset -y 0 0x50 0 0
read_rx=" "
read_rx=$(i2cget -y 0 0x50)
if [[ "${read_rx}" != "0xaa" ]]; then
	echo "Erro EEPROM"
	exit 1
fi

i2cset -y 0 0x50 0 0 0xbb i
i2cset -y 0 0x50 0 0
read_rx=" "
read_rx=$(i2cget -y 0 0x50)
if [[ "${read_rx}" != "0xbb" ]]; then
	echo "Erro EEPROM"
	exit 1
fi


#WP
raspi-gpio set 20 dl

i2cset -y 0 0x50 0 0 0xcc i
i2cset -y 0 0x50 0 0
read_rx=" "
read_rx=$(i2cget -y 0 0x50)
if [[ "${read_rx}" == "0xcc" ]]; then
	echo "Erro WP"
	exit 2
fi

echo "Teste EEPROM ok"
exit 0



#!/bin/bash

# Testa se o ADC está lendo o valor correto.
# Pino da bateria deve estar ligado no 5v

raspi-gpio set 5 op
raspi-gpio set 5 dl
adc_good="Ok"
adc_rx=" "
echo "Testando a leitura do ADC"
adc_rx=$(python /home/pi/gigaSW/spi/testAdc.py)
if [[ "${adc_rx}" != "${adc_good}" ]]; then
	echo "Falha no ADC"
	exit 1
fi

echo "Teste do ADC ok"
exit 0

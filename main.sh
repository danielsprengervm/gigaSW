#!/bin/bash

while true; do
	clear
	errors=""
	echo "---------- GIGA VMBOX 5 TOTEM ----------"
	echo ""
	echo "Pressione ENTER para iniciar os testes"
	read -p "" dummy

	echo "Teste UPDI..."
	echo ""
	bash updi/updi.sh
	if [[ $? -ne 0 ]]; then
		echo "Teste UPDI reprovado!"
		errors+=" UPDI,"
	else
		echo "Teste UPDI ok!"
	fi
        echo ""
        echo "Teste SPI"
        echo ""
        bash spi/spiTest.sh
	sleep 1
        if [[ $? -ne 0 ]]; then
                echo "Teste SPI reprovado!"
                errors+=" SPI,"
        else
                echo "Teste SPI ok"
        fi
	echo ""
	echo "Teste ADC..."
	echo ""
	bash spi/adcTest.sh
	if [[ $? -ne 0 ]]; then
		echo "Teste ADC reprovado!"
		errors+=" ADC,"
	else
		echo "Teste ADC ok!"
	fi
	echo ""
	echo "Teste Carregador..."
	echo ""
	bash spi/chargerTest.sh
	if [[ $? -ne 0 ]]; then
		echo "Teste Carregador reprovado!"
		errors+=" Carregador,"
	else
		echo "Teste Carregador ok!"
	fi
	echo ""
	echo "Teste GPIO..."
	echo ""
	bash gpio/testGpio.sh
	if [[ $? -ne 0 ]]; then
		echo "Teste GPIO reprovado!"
		errors+=" GPIO,"
	else
		echo "Teste GPIO ok!"
	fi
	echo ""
	echo "Teste RS485"
	echo ""
	bash rs485/test485.sh
	if [[ $? -ne 0 ]]; then
		echo "Teste RS485 reprovado!"
		errors+=" RS485,"
	else
		echo "Teste RS485 ok!"
	fi
	echo ""
	echo "Teste Power"
	echo ""
	echo "Pulando teste do power..."
	sleep 1
	echo ""
	echo "Teste EEPROM"
	echo ""
	bash eeprom/testEeprom.sh
	if [[ $? -ne 0 ]]; then
		echo "Teste EEPROM reprovado!"
		errors+=" EEPROM,"
	else
		echo "Teste EEPROM ok!"
	fi
	echo ""
	echo "Teste Botões"
	echo ""
	bash userIf/testButtons.sh
	if [[ $? -ne 0 ]]; then
		echo "Teste Botões reprovado!"
		errors+=" Botões,"
	else
		echo "Teste Botões ok!"
	fi
	echo ""
	echo "Teste Leds"
	echo ""
	bash userIf/testLeds.sh
	echo "- - - - - - - - - - - - - - -"
	echo ""
	echo "---- Testes finalizados ----"
	echo ""
	echo "- - - - - - - - - - - - - - -"
	if [ -z "$errors" ]; then
		echo "Equipamento aprovado!"
	else
		echo "Equipamento reprovado"
		echo "Testes reprovados: ${errors}"
	fi
	echo "Pressione ENTER para fechar o report"
	read -p "" dummy
done

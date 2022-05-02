#!/bin/bash
raspi-gpio set 7 ip
raspi-gpio set 7 pu

#tira bloqueio de tela
xset s noblank
xset -dpms
xset -s off

while true; do
	clear
	bash /home/pi/gigaSW/resetPins.sh
	errors=""
	echo "---------- GIGA VMBOX 5 TOTEM ----------"
	echo ""
	echo "Pressione o botão para iniciar os testes"
	sleep 1
	but=$(raspi-gpio get 7)
	while [[ "${but}" != *"level=0"* ]]
	do
		but=$(raspi-gpio get 7)
	done

	echo "Teste UPDI..."
	echo ""
	bash /home/pi/gigaSW/updi/updi.sh
	if [[ $? -ne 0 ]]; then
		echo "Teste UPDI reprovado!"
		errors+=" UPDI,"
	else
		echo "Teste UPDI ok!"
	fi
        echo ""
        echo "Teste SPI"
        echo ""
	sleep 1
        bash /home/pi/gigaSW/spi/spiTest.sh
        if [[ $? -ne 0 ]]; then
                echo "Teste SPI reprovado!"
                errors+=" SPI,"
        else
                echo "Teste SPI ok"
        fi
	echo ""
	echo "Teste ADC..."
	echo ""
	bash /home/pi/gigaSW/spi/adcTest.sh
	if [[ $? -ne 0 ]]; then
		echo "Teste ADC reprovado!"
		errors+=" ADC,"
	else
		echo "Teste ADC ok!"
	fi
	echo ""
	echo "Teste Carregador..."
	echo ""
	bash /home/pi/gigaSW/spi/chargerTest.sh
	if [[ $? -ne 0 ]]; then
		echo "Teste Carregador reprovado!"
		errors+=" Carregador,"
	else
		echo "Teste Carregador ok!"
	fi
	echo ""
	echo "Teste GPIO..."
	echo ""
	bash /home/pi/gigaSW/gpio/testGpio.sh
	if [[ $? -ne 0 ]]; then
		echo "Teste GPIO reprovado!"
		errors+=" GPIO,"
	else
		echo "Teste GPIO ok!"
	fi
	echo ""
	echo "Teste RS485"
	echo ""
	bash /home/pi/gigaSW/rs485/test485.sh
	if [[ $? -ne 0 ]]; then
		echo "Teste RS485 reprovado!"
		errors+=" RS485,"
	else
		echo "Teste RS485 ok!"
	fi
	echo ""
	echo "Teste Power"
	echo ""
	bash /home/pi/gigaSW/power/testPower.sh
	if [[ $? -ne 0 ]]; then
		echo "Teste Power reprovado!"
		errors+=" Power,"
	else
		echo "Teste Power ok!"
	fi
	sleep 1
	echo ""
	echo "Teste EEPROM"
	echo ""
	bash /home/pi/gigaSW/eeprom/testEeprom.sh
	if [[ $? -ne 0 ]]; then
		echo "Teste EEPROM reprovado!"
		errors+=" EEPROM,"
	else
		echo "Teste EEPROM ok!"
	fi
	echo ""
	echo "Teste Botões, pressione o botão da giga para iniciar"
	echo ""
	but=$(raspi-gpio get 7)
	while [[ "${but}" != *"level=0"* ]]
	do
		but=$(raspi-gpio get 7)
	done
	bash /home/pi/gigaSW/userIf/testButtons.sh
	if [[ $? -ne 0 ]]; then
		echo "Teste Botões reprovado!"
		errors+=" Botões,"
	else
		echo "Teste Botões ok!"
	fi
	echo ""
	echo "Teste Leds"
	echo ""
	bash /home/pi/gigaSW/userIf/testLeds.sh
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
	echo "Pressione o botão para fechar o report"
	bash /home/pi/gigaSW/resetPins.sh
	but=$(raspi-gpio get 7)
	while [[ "${but}" != *"level=0"* ]]
	do
		but=$(raspi-gpio get 7)
	done
done

#!/bin/bash
raspi-gpio set 7 ip
raspi-gpio set 7 pu

#tira bloqueio de tela
xset s noblank
xset -dpms
xset -s off

GIGA_SW_PATH = "/home/pi/gigaSW"

while true; do
	clear
	bash ${GIGA_SW_PATH}/resetPins.sh
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

	bash ${GIGA_SW_PATH}/testScript.sh
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

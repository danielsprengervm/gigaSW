#!/bin/bash

# tira o bloqueio de tela

xset s noblank
xset -dpms
xset -s off

while true; do
	clear
	bash ${GIGA_SW_PATH}/resetPins.sh
	echo "---------- GIGA VMBOX 5 TOTEM ----------"
	echo ""
	echo "Versao giga = 1.0 | Versao ATM = 1.1"
	echo ""
	echo "Pressione o botão para iniciar os testes"
	sleep 0.5
	bash ${GIGA_SW_PATH}/getGigaButton.sh
	bash ${GIGA_SW_PATH}/testScript.sh
	echo "- - - - - - - - - - - - - - -"
	echo ""
	echo "---- Testes finalizados ----"
	echo ""
	echo "- - - - - - - - - - - - - - -"
	if [ -f "${GIGA_SW_PATH}/errors.txt" ]; then
		echo ""
		echo "! ! ! ! ! ! ! ! ! ! ! ! ! ! !"
		echo "!!! EQUIPAMENTO REPROVADO !!!"
		echo "! ! ! ! ! ! ! ! ! ! ! ! ! ! !"
		echo ""
		echo -n "Erros: "
		cat ${GIGA_SW_PATH}/errors.txt
		echo ""
	else
		echo "Equipamento aprovado!"
	fi
	echo "Pressione o botão para fechar o report"
	bash ${GIGA_SW_PATH}/resetPins.sh
	bash ${GIGA_SW_PATH}/getGigaButton.sh
done


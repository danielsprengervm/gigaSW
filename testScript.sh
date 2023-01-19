#!/bin/bash

if [ -f "${GIGA_SW_PATH}/errors.txt" ]; then
  rm ${GIGA_SW_PATH}/errors.txt > /dev/null
fi

echo "Gravando FW do ATM..."
echo ""
bash ${GIGA_SW_PATH}/spi/burnFw.sh
if [[ $? -ne 0 ]]; then
  echo "Erro na Gravacao do FW"
  echo -n "Gravacao FW" >> ${GIGA_SW_PATH}/errors.txt
  exit 1
else
  echo "Gravacao do FW ok!"
fi

echo ""
echo "Teste SPI..."
echo ""
sleep 1
bash ${GIGA_SW_PATH}/spi/spiTest.sh
if [[ $? -ne 0 ]]; then
  echo "Teste SPI reprovado!"
  echo -n " SPI," >> ${GIGA_SW_PATH}/errors.txt
else
  echo "Teste SPI ok"
fi
echo ""
echo "Teste RS485"
echo ""
bash ${GIGA_SW_PATH}/rs485/test485.sh
if [[ $? -ne 0 ]]; then
  echo "Teste RS485 reprovado!"
  echo -n " RS485," >> ${GIGA_SW_PATH}/errors.txt
else
  echo "Teste RS485 ok!"
fi
sleep 1
echo ""
echo "Teste Power"
echo ""
bash ${GIGA_SW_PATH}/power/testPower.sh
if [[ $? -ne 0 ]]; then
  echo "Teste Power reprovado!"
  echo -n " Power," >> ${GIGA_SW_PATH}/errors.txt
else
  echo "Teste Power ok"
fi
sleep 1
echo ""
echo "Teste Botoes, pressione o botao da giga para iniciar"
echo ""
but=$(raspi-gpio get 7)
bash ${GIGA_SW_PATH}/getGigaButton.sh

bash ${GIGA_SW_PATH}/userIf/testButtons.sh
if [[ $? -ne 0 ]]; then
  echo "Teste botoes Reprovado!"
  echo -n " Botao," >> ${GIGA_SW_PATH}/errors.txt
else
  echo "Teste botoes ok!"
fi
echo ""
echo "Teste Leds"
echo ""
bash ${GIGA_SW_PATH}/userIf/testLeds.sh
if [ -f "${GIGA_SW_PATH}/errors.txt" ]; then
  exit 2
else
  exit 0
fi

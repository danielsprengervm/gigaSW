#!/bin/bash

echo "Gravando FW do ATM..."
echo ""
bash ${GIGA_SW_PATH}/spi/burnFw.sh
if [[ $? -ne 0 ]];; then
  echo "Erro na Gravacao do FW"
  errors+="Gravacao FW"
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
  errors+=" SPI,"
else
  echo "Teste SPI ok"
fi
echo ""
echo "Teste Carregador..."
echo ""
echo "Teste GPIO..."
echo ""
bash ${GIGA_SW_PATH}/gpio/testGpio.sh
if [[ $? -ne 0 ]]; then
  echo "Teste GPIO reprovado!"
  errors+="GPIO ,"
else
  echo "Teste GPIO OK!"
fi
echo ""
echo "Teste RS485"
echo ""
bash ${GIGA_SW_PATH}/rs485/test485.sh
if [[ $? -ne 0 ]]; then
  echo "Teste RS485 reprovado!"
  errors+=" RS485,"
else
  echo "Teste RS485 ok!"
fi
echo ""
echo "Teste Power"
echo ""
bash ${GIGA_SW_PATH}/power/testPower.sh
if [[ $? -ne 0 ]]; then
  echo "Teste Power reprovado!"
  errors+=" Power,"
else
  echo "Teste Power ok"
fi
sleep 1
echo ""
echo "Teste Botoes, pressione o botao da giga para iniciar"
echo ""
but=$(raspi-gpio get 7)
while [[ "${but}" != *"level=0"* ]]
do
  but=$(raspi-gpio get 7)
done

bash ${GIGA_SW_PATH}/userIf/testButtons.sh
if [[ $? -ne 0 ]]; then
  echo "Teste botoes Reprovado!"
else
  echo "Teste botoes ok!"
fi
echo ""
echo "Teste Leds"
echo ""
bash ${GIGA_SW_PATH}/userIf/testLeds.sh
if [ -z "$errors" ]; then
  exit 0
else
  exit 2
fi

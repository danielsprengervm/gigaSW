#!/bin/sh

usr=$(whoami)
if [[ "${usr}" != "root" ]]; then
	echo "Precisa ser root para executar esse script"
	echo "Rode 'sudo -i' e tente novamente"
	exit 1
fi

echo "enable_uart=1" >> /boot/config.txt
echo "dtoverlay=pi3-miniuart-bt" >> /boot/config.txt
systemctl stop serial-getty@ttyS0.service
systemctl disable serial-getty@ttyS0.service
sed -i 's/console=serial0,115200 //g' /boot/cmdline.txt

echo "i2c-dev" >> /etc/modules
echo "i2c-bcm2708" >> /etc/modules
echo "dtparam=i2c_arm=on" >> /boot/config.txt
echo "dtparam=i2c1=on" >>/boot/config.txt
echo "dtparam=i2c_vc=on" >> /boot/config.txt
sudo apt-get install i2c-tools libi2c-dev python-smbus

echo "dtparam=spi=on" >> /boot/config.txt

sudo apt install xterm

echo "[Desktop Entry]" > /etc/xdg/autostart/giga.desktop
echo "Name=gigaBox5Totem" >> /etc/xdg/autostart/giga.desktop
echo "Exec=xterm -fullscreen -e 'sudo bash /home/pi/gigaSW/gigaLauncher.sh'" >> /etc/xdg/autostart/giga.desktop



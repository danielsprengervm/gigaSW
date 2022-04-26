#!/bin/sh

echo "enable_uart=1" >> /boot/config.txt
echo "dtoverlay=pi3-miniuart-bt" >> /boot/config.txt
chmod 666 /dev/ttyAMA0
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


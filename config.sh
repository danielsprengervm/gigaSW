#!/bin/sh

sudo -i
echo "enable_uart=1" >> /boot/config.txt
echo "dtoverlay=pi3-miniuart-bt" >> /boot/config.txt
chmod 666 /dev/ttyAMA0
systemctl stop serial-getty@ttyS0.service
systemctl disable serial-getty@ttyS0.service
echo "console=tty1 root=PARTUUID=7b9105cd-02 rootfstype=ext4 fsck.repair=yes rootwait quiet splash plymouth.ignore-serial-consoles" >/boot/cmdline.txt

echo "i2c-dev" >> /etc/modules
echo "i2c-bcm2708" >> /etc/modules
echo "dtparam=i2c_arm=on" >> /boot/config.txt
echo "dtparam=i2c1=on" >>/boot/config.txt
echo "dtparam=i2c_vc=on" >> /boot/config.txt
sudo apt-get install i2c-tools libi2c-dev python-smbus

echo "dtparam=spi=on" >> /boot/config.txt

(crontab -l; echo "@reboot sudo sh /home/pi/gigaSW/main.sh &") | sort -u | crontab -;

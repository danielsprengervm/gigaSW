# -*- coding: utf-8 -*-
import serial
import RPi.GPIO as gpio
from time import sleep

DLE_ETX = bytearray([0x10, 0x03])
BOOK_CMD = bytearray([0x10, 0x02, 0x00, 0x04, 0x00, 0x54, 0x10, 0x03])
BOOK_RX = bytes([0,0x10, 0x02, 0x0A, 0x04, 0x01, 0x53, 0x10, 0x03])

DE_485 = 23

gpio.setwarnings(False)
port=serial.Serial()
port.baudrate=115200
port.timeout=2

gpio.setmode(gpio.BCM)

port.port = "/dev/ttyAMA0"
port.open()
gpio.setup(DE_485,gpio.OUT)

gpio.output(DE_485,gpio.HIGH)
port.write(BOOK_CMD)
sleep(0.01)
gpio.output(DE_485,gpio.LOW)
rx=port.read_until(DLE_ETX)
if rx == BOOK_RX:
	print("Ok")
else:
	print("Nok")


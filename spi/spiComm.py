import spidev
import time

spi_bus = 0
spi_device = 0

spi =  spidev.SpiDev()
spi.open(spi_bus, spi_device)
spi.max_speed_hz = 100000

rcv_byte = spi.xfer2([0x10, 0x02, 0xFF, 0xFF, 0x10, 0x03])
time.sleep(0.05)
rcv_byte = spi.xfer2([0,0,0,0,0,0,0,0,0,0,0])

if rcv_byte[0:6] == [16, 2, 255, 86, 1, 1]:
	print("Ok")
else:
	print("Nok")


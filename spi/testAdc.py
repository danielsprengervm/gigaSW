import spidev
import time

spi_bus = 0
spi_device = 0

spi =  spidev.SpiDev()
spi.open(spi_bus, spi_device)
spi.max_speed_hz = 100000

rcv_byte = spi.xfer2([0x10, 0x02, 0x08, 0x08, 0x10, 0x03])
time.sleep(0.01)
rcv_byte = spi.xfer2([0,0,0,0,0,0,0,0,0,0,0])
vbat = rcv_byte[3] + (rcv_byte[4]<<8)
if vbat > 4800 and vbat < 5300:
	print("Ok")
else:
	print("Nok")

# -*- coding: utf-8 -*-
import spidev
from time import sleep
import sys
import os

class Main:
    if len(sys.argv) < 2:
        print("Erro, arquivo binario nao especificado")
        exit(2)
    if len(sys.argv) == 2:
        PAYLOAD_SIZE = 64
    if len(sys.argv) > 2:
        PAYLOAD_SIZE = int(sys.argv[2])

    DATA_OK = [0x10, 0x02, 0xB0, 0x01, 0xB1, 0x10, 0x03]
    EMPTY_TX = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]
    FINISH_UPDATE = [0x10, 0x02, 0xB1, 0xB1, 0x10, 0x03,0,0,0,0,0,0,0]

    spi_bus = 0
    spi_device = 0
    spi = spidev.SpiDev()
    spi.open(spi_bus,spi_device)
    spi.max_speed_hz = 100000

    f = open(sys.argv[1], "rb")

    def crc8(self, data):
        crc=0
        for i in data:
            crc ^= i
            crc = crc % 256
            for j in range(8):
                if crc & 0x80 != 0x00:
                    crc = ((crc << 1) ^ 0x07) % 256
                else:
                    crc = (crc << 1) % 256
        return crc

    def protocolEncap(self, input):
        out = []
        aux = []
        out.append(0x10)
        out.append(0x02)
        out.append(0xb0)
        aux.append(0xb0)
        for i in range(len(input)):
            out.append(input[i])
            aux.append(input[i])
            if input[i] == 16:
                out.append(input[i])

        crc = self.crc8(aux)
        if crc == 16:
            out.append(crc)
        out.append(crc)
        aux.append(crc)

        cs=0
        for i in aux:
            cs += i
        cs = cs % 256
        if cs == 16:
            out.append(cs)
        out.append(cs)
        out.append(0x10)
        out.append(0x03)
        return out

    def sendSlot(self, slot):
        packet = self.protocolEncap(slot)
        self.spi.xfer2(packet)
        sleep(0.05)
        rx = self.spi.xfer2(self.EMPTY_TX)
        sleep(0.05)
        if rx != self.DATA_OK:
            return 0
        else:
            return 1

    def Main(self):
        byte = self.f.read(1)
        slot = []
        currentAddress = 0
        print("Iniciando atualizacao...")
        while byte != b'':
            slot.append(int(byte.hex(),16))
            currentAddress += 1
            if currentAddress % 512 == 0:
                print("Gravando endereço ",currentAddress)
            if len(slot) == self.PAYLOAD_SIZE:
                if self.sendSlot(slot) == 0:
                    print("Erro na escrita, end: ",currentAddress-len(slot))
                    exit(1)
                slot = []
            byte = self.f.read(1)

        if len(slot) != 0:
            if self.sendSlot(slot) == 0:
                print("Erro na escrita, end: ", currentAddress - len(slot))
                exit(1)
        # Preenche o restante da ultima pagina com 0xFF, se não a ultima pagina não é gravada
        lastPage = int(currentAddress/128)
        nextPage = lastPage+1
        while int(currentAddress/128) != nextPage:
            slot = [0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF]
            if(self.sendSlot(slot) == 0):
                print("Erro na escrita enquanto finalizava ultima pagina")
                exit(1)
            currentAddress += 8
        rx=self.spi.xfer2(self.FINISH_UPDATE)
        print("Atualizacao finalizada")
        exit(0)

if __name__ == "__main__":
    main = Main()
    main.Main()

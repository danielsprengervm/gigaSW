#!/bin/bash

raspi-gpio set 7 ip pu

but=$(raspi-gpio get 7)
while [[ "${but}" != *"level=0"* ]]
do
	but=$(raspi-gpio get 7)
done

exit 0

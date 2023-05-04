#!/bin/bash

#sudo ifconfig enp1s0f0 down
#sudo ifconfig enp1s0f1 down
sudo ~/onvm/onvm-upf/dpdk/usertools/dpdk-devbind.py -b igb_uio 0000:5e:00.0 0000:5e:00.1
sudo ~/onvm/onvm-upf/dpdk/usertools/dpdk-devbind.py -s

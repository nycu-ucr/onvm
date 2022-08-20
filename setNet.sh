#!/bin/bash

sudo ~/onvm/onvm-upf/dpdk/usertools/dpdk-devbind.py -b i40e 0000:01:00.0 0000:01:00.1
sudo ifconfig enp1s0f0 up
sudo ifconfig enp1s0f1 up
sudo ip a add 10.100.200.3/24 dev enp1s0f0
sudo ip a add 192.168.0.2/24 dev enp1s0f1
sudo arp -s 192.168.0.1 90:e2:ba:c2:f0:42
sudo arp -s 10.100.200.1 90:e2:ba:c2:ec:d8
sudo sysctl -w net.ipv4.ip_forward=1
sudo systemctl stop ufw

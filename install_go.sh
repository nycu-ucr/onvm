#!/bin/bash
sudo rm -rf /usr/local/go
wget https://dl.google.com/go/go1.19.3.linux-amd64.tar.gz
sudo tar -C /usr/local -zxvf go1.19.3.linux-amd64.tar.gz
rm go1.19.3.linux-amd64.tar.gz
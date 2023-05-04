#!/bin/bash
sudo rm -rf /usr/local/go
sudo rm -rf ~/go

mkdir -p ~/go/{bin,pkg,src}

wget https://dl.google.com/go/go1.19.3.linux-amd64.tar.gz
sudo tar -C /usr/local -zxf go1.19.3.linux-amd64.tar.gz

# The following assume that your shell is bash
echo 'export GOPATH=$HOME/go' >> ~/.bashrc
echo 'export GOROOT=/usr/local/go' >> ~/.bashrc
echo 'export PATH=$PATH:$GOPATH/bin:$GOROOT/bin' >> ~/.bashrc
echo 'export GO111MODULE=auto' >> ~/.bashrc
source ~/.bashrc

rm go1.19.3.linux-amd64.tar.gz

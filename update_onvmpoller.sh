#!/bin/bash
YELLOW='\033[1;33m'
NC='\033[0m'

workdir=$(pwd)
github_dir="$HOME/go/pkg/mod/github.com/nycu-ucr"

cd $github_dir
# net
for target in $(ls | grep 'net@*')
do
    echo "Handle $target"
    sudo cp -R $workdir/net/* $target
done

# http2_util
for target in $(ls | grep 'http2_util@*')
do
    echo "Handle $target"
    sudo cp -R $workdir/http2_util/* $target
done

# openapi
for target in $(ls | grep 'openapi@*')
do
    echo "Handle $target"
    sudo cp -R $workdir/openapi/* $target
done

# gin
for target in $(ls | grep 'gin@*')
do
    echo "Handle $target"
    sudo cp -R $workdir/gin/* $target
done

# gonet
for target in $(ls | grep 'gonet@*')
do
    echo "Handle $target"
    sudo cp -R $workdir/gonet/* $target
done

# pfcp
for target in $(ls | grep 'pfcp@*')
do
    echo "Handle $target"
    sudo cp -R $workdir/pfcp/* $target
done


echo -e "Replace ${YELLOW}/home/hstsai${NC} to ${YELLOW}$HOME${NC}"
echo -e "Put onvm directory under your $HOME"
# onvmpoller
for target in $(ls | grep 'onvmpoller@*')
do
    cd $github_dir
    echo "Handle $target"
    sudo cp -R $workdir/onvmpoller/* $target
    cd $target
    sudo sed -i "s#/home/hstsai#$HOME#g" poller.go
    sudo sed -i "s#/home/hstsai#$HOME#g" onvm_poller.c
    sudo rm -f listen.go
done

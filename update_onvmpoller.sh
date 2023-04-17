#!/bin/bash

workdir=$(pwd)
github_dir="/users/YouSheng/go/pkg/mod/github.com/nycu-ucr"

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

# onvmpoller
for target in $(ls | grep 'onvmpoller@*')
do
    cd $github_dir
    echo "Handle $target"
    sudo cp -R $workdir/onvmpoller/* $target
    cd $target
    sudo sed -i 's#/home/hstsai#/users/YouSheng#g' poller.go
    sudo sed -i 's#/home/hstsai#/users/YouSheng#g' onvm_poller.c
done

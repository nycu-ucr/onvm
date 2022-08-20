#!/bin/bash

workdir=$(pwd)

echo "Update onvmpoller"
sudo cp -R $workdir/onvmpoller/* /home/hstsai/go/pkg/mod/github.com/nycu-ucr/onvmpoller@v0.0.0-20220816115249-51ada923b11d
cd /home/hstsai/go/pkg/mod/github.com/nycu-ucr/onvmpoller@v0.0.0-20220816115249-51ada923b11d
sudo sed -i 's#<replace path>#'$workdir'#g' poller.go

echo "make server and client"
cd $workdir/testbed/bin
rm server client
cd $workdir/testbed
make
#!/bin/bash

workdir=$(pwd)
target="/home/johnson/go/pkg/mod/github.com/nycu-ucr/onvmpoller@v0.0.0-20230206045804-e3f65dd61911"
net_target="/home/johnson/go/pkg/mod/github.com/nycu-ucr/net@v0.0.0-20230213095825-a2603f1a06e9"
amf_target="/home/johnson/go/pkg/mod/github.com/nycu-ucr/amf@v0.0.0-20221021122605-1c0e74501dbb"
http2_util_target="/home/johnson/go/pkg/mod/github.com/nycu-ucr/http2_util@v0.0.0-20230213074247-99b574560ae4"
openapi_target="/home/johnson/go/pkg/mod/github.com/nycu-ucr/openapi@v0.0.0-20230213074007-db43c56e0efa"
gin_target="/home/johnson/go/pkg/mod/github.com/nycu-ucr/gin@v0.0.0-20221108140334-9ba2d17cede5"
gonet_target="/home/johnson/go/pkg/mod/github.com/nycu-ucr/gonet@v0.0.0-20230214053946-2f5515604c06"

echo "Update onvmpoller"
echo "Target: $target"
echo "Net Target: $net_target"
echo "HTTP2 Utility Target: $http2_util_target"
echo "OpenAPI Target: $openapi_target"
echo "Gin Target: $gin_target"
echo "GoNet Target: $gonet_target"

sudo cp -R $workdir/onvmpoller/* $target
cd $target
sudo sed -i 's#hstsai#johnson#g' poller.go
sudo sed -i 's#hstsai#johnson#g' onvm_poller.c

# net
cd $workdir
sudo cp -R $workdir/net/* $net_target

# http2_util
cd $workdir
sudo cp -R $workdir/http2_util/* $http2_util_target

# openapi
cd $workdir
sudo cp -R $workdir/openapi/* $openapi_target

# gin
cd $workdir
sudo cp -R $workdir/gin/* $gin_target

# gonet
cd $workdir
sudo cp -R $workdir/gonet/* $gonet_target
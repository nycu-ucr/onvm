# !/bin/bash

workdir=$(pwd)
echo "Working directory is $workdir"
cd $workdir

# echo "========= Build onvm ========="
# sudo apt-get install -y build-essential linux-headers-$(uname -r) git bc
# sudo apt-get install -y python3
# sudo apt-get install -y libnuma-dev

git clone https://github.com/nycu-ucr/onvm-upf.git
cd $workdir/onvm-upf
git submodule sync
git submodule update --init
echo export ONVM_HOME=$(pwd) >> ~/.bashrc
cd dpdk && echo export RTE_SDK=$(pwd) >> ~/.bashrc
echo export RTE_TARGET=x86_64-native-linuxapp-gcc  >> ~/.bashrc
echo export ONVM_NUM_HUGEPAGES=1024 >> ~/.bashrc
source ~/.bashrc
sudo sh -c "echo 0 > /proc/sys/kernel/randomize_va_space"
cd ../scripts
./install.sh
cd ../onvm
make

echo "========= Build testbed ========="
echo "Go to onvmNet repository"
cd $HOME'/go/pkg/mod/github.com/nycu-ucr/onvmpoller@v0.0.0-20220816115249-51ada923b11d/'
sudo chmod +w ./*
cp ./ipid.yaml $workdir/testbed
cp ./onvmConfig.json $workdir/testbed
echo "Modify conn.go"
sudo sed -i 's#\<replace path>#'$workdir'#g' poller.go
echo "Modify ipid.yaml"
sed -i 's#ID:\ 2#ID:\ 4#g' $workdir/testbed/ipid.yaml
sed -i 's#ID:\ 1#ID:\ 2#g' $workdir/testbed/ipid.yaml
sed -i 's#ID:\ 4#ID:\ 1#g' $workdir/testbed/ipid.yaml
echo "Modify conn.c"
sudo sed -i 's#\/root\/onvmNet#'$workdir'#g' conn.c

echo "Go to $workdir/testbed and build NFs"
cd $workdir/testbed
echo "Build TCP server"
make server
echo "Build TCP client"
make client

cp $workdir/testbed/ipid.yaml $workdir/testbed/bin/ipid.yaml
echo "========= Build Testbed Done ========="
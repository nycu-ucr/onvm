#!/bin/bash
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

export CGO_LDFLAGS_ALLOW="-Wl,(--whole-archive|--no-whole-archive)"

cd $HOME
git clone https://github.com/nycu-ucr/l25gc.git
git clone https://github.com/nycu-ucr/gonet.git
git clone https://github.com/nycu-ucr/http2_util.git
git clone https://github.com/nycu-ucr/openapi.git
git clone https://github.com/nycu-ucr/net.git
git clone https://github.com/nycu-ucr/gin.git
git clone https://github.com/nycu-ucr/onvmpoller.git
git clone https://github.com/nycu-ucr/pfcp.git
git clone https://github.com/nycu-ucr/xio-free5gc3.0.5.git

cd $HOME/gonet
git checkout refactor-XIO
cd $HOME/http2_util
git checkout refactor-XIO
cd $HOME/openapi
git checkout refactor-XIO
cd $HOME/net
git checkout refactor-XIO
cd $HOME/onvmpoller
git checkout clean_code
cd $HOME/pfcp
git checkout xio-udp

echo -e "${RED}Remember to checkout the correct branch${NC}"

echo -e "${YELLOW}Build free5GC${NC}"
cd $HOME/l25gc
source ./build_free5GC.sh

cd $HOME/onvm
echo -e "${YELLOW}Install go1.19${NC}"
./install_go.sh

echo -e "${YELLOW}Build ONVM${NC}"
echo "Do you need modify build_testbed? If you need do it now, otherwise press ENTER"
read need
source ./build_testbed.sh

echo -e "${RED}Remember to checkout the onvm-upf to correct branch"
echo -e "And re-compile the onvm${NC}"
cd $HOME/onvm-upf
git checkout mod-upf-c
cd $HOME/onvm-upf/onvm
make
cd $HOME/onvm/onvm-upf/5gc/upf_c_complete
sudo rm -rf ./build; make
cd $HOME/onvm/onvm-upf/5gc/upf_u_complete
sudo rm -rf ./build; make

echo -e "${YELLOW}Build XIO-L25GC${NC}"
cd $HOME/xio-free5gc3.0.5
./fetch_NFs.sh
echo -e "${RED}Remember to checkout the smf and pfcp to correct branch${NC}"

for i in $(seq 1 4)
do
    cd $HOME/xio-free5gc3.0.5
    ./rebuild_NFs.sh
    cd $HOME/onvm
    ./copy_onvmpoller.sh; ./update_onvmpoller.sh;
done

cd $HOME

echo "export ONVMPOLLER_IPID_YAML=$HOME/xio-free5gc3.0.5/onvm_config_yaml/ipid.yaml" >> ~/.bashrc
echo "export ONVMPOLLER_NFIP_YAML=$HOME/xio-free5gc3.0.5/onvm_config_yaml/NFip.yaml" >> ~/.bashrc
echo "export ONVMPOLLER_IPID_TXT=$HOME/xio-free5gc3.0.5/onvm_config_yaml/ipid.txt" >> ~/.bashrc

source ~/.bashrc
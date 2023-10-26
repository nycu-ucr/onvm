#!/bin/bash
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

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
git checkout l25gc+
cd $HOME/net
git checkout refactor-XIO
cd $HOME/onvmpoller
git checkout clean_code
cd $HOME/pfcp
git checkout l25gc+

echo -e "${RED}Remember to checkout the correct branch${NC}"

cd $HOME/onvm
echo -e "${YELLOW}Install go1.19${NC}"
./install_go.sh

echo -e "${YELLOW}Build ONVM${NC}"

source ./build_testbed.sh

echo -e "${RED}Remember to checkout the onvm-upf to correct branch"
echo -e "And re-compile the onvm${NC}"
cd $HOME/onvm-upf
git checkout opensource
cd $HOME/onvm-upf/onvm
make
cd $HOME/onvm/onvm-upf/5gc/upf_c_complete
sudo rm -rf ./build; make
cd $HOME/onvm/onvm-upf/5gc/upf_u_complete
sudo rm -rf ./build; make

echo -e "${YELLOW}Build XIO-L25GC${NC}"
cd $HOME/xio-free5gc3.0.5
./fetch_NFs.sh

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
echo "export CGO_LDFLAGS_ALLOW='-Wl,(--whole-archive|--no-whole-archive)'" >> ~/.bashrc
echo "export ONVM_NF_JSON=$HOME/onvm/NF_json/" >> ~/.bashrc

source ~/.bashrc
#!/bin/bash

NF_LIST="server client onvm_mgr"

for NF in ${NF_LIST}; do
    sudo killall -9 ${NF}
done

tmux kill-session -t l25gc

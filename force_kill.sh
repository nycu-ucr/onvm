#!/bin/bash

NFs="(mgr)|(amf)|(nrf)|(ausf)|(udm)|(udr)|(pcf)|(nssf)|(smf)|(upf)"
simple="(\./server)|(\./client)"
http="(\./http_server)|(\./http_client)"
tp="(\./tp_server)|(\./tp_client)"

ps -aux | egrep "$NFs|$simple|$http|$tp" | awk '{print $2}' | xargs -n 2 sudo kill -9

tmux kill-session -t l25gc

NFs_logger=$(find $HOME/xio-free5gc3.0.5/NFs/ -name "logger.go")
free5GC_NFs_logger=$(find $HOME/l25gc/kernel-free5gc3.0.5/NFs/ -name "logger.go")
pfcp_logger="$HOME/pfcp/logger/logger.go"

for logger in $NFs_logger $pfcp_logger $free5GC_NFs_logger
do
    sed -i s/time\.RFC3339/time\.StampNano/g $logger
done

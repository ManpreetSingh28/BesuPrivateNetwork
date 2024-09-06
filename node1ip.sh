#!/bin/sh

# Fetch Node1 IP dynamically
NODE1_IP=$(getent hosts node1 | awk '{ print $1 }')

echo "Resolved Node1 IP: $NODE1_IP"

# Start Besu with the correct bootnodes configuration
exec /opt/besu/bin/besu \
  --data-path=/var/lib/besu/data \
  --genesis-file=/var/lib/besu/genesis.json \
  --rpc-http-enabled \
  --host-allowlist="*" \
  --rpc-http-host=0.0.0.0 \
  --rpc-http-port=8546 \
  --rpc-http-cors-origins="all" \
  --rpc-http-api=ETH,NET,QBFT \
  --min-gas-price=0 \
  --logging=INFO \
  --bootnodes="enode://283dc08b2cc0552b9f4bd11aeea46537b24c2f8809d02336ae594314469015cb80d550c1e464831809b88944fe403468c861cb11018e00b68a19c47389ad0edf@$NODE1_IP:30303"

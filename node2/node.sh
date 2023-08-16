#!/bin/bash
# Set log file
LOG_FILE="/debug/debug.log"

mkdir -p /debug/node2


# Generate genesis.json file
cat << EOF > /debug/genesis.json
{
  "config": {
    "chainId": 10000,
    "homesteadBlock": 1,
    "eip150Block": 2,
    "eip150Hash": "0x0000000000000000000000000000000000000000000000000000000000000000",
    "eip155Block": 3,
    "eip158Block": 3,
    "byzantiumBlock": 4,
    "clique": {
      "period": 3,
      "epoch": 30000
    }
  },
  "nonce": "0x0",
  "timestamp": "0x5cdec502",
  "extraData": "0x0000000000000000000000000000000000000000000000000000000000000000<node1_address><node2_address>a59bb9d4d6330613381f442bfb30a736347fc2720000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
  "gasLimit": "9000000000000",
  "difficulty": "",
  "mixHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "coinbase": "0x0000000000000000000000000000000000000000",
  "alloc": {},
  "number": "0x0",
  "gasUsed": "0x0",
  "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000"
}
EOF

# Generate node1 account
NODE2_PASSWORD=$(cat /debug/password.txt)
echo $NODE2_PASSWORD > /debug/node2/password.txt
geth account new --datadir /debug/node2 --password /debug/node2/password.txt >> $LOG_FILE 2>&1
NODE2_ADDRESS=$(geth --datadir /debug/node2 account list | head -1 | awk -F'[{}]' '{print $2}')


# Replace node addresses in the genesis.json file
sed -i "s/<node2_address>/$NODE2_ADDRESS/g" /debug/genesis.json

# Initialize node1 and node2 with the genesis.json file
geth --datadir /debug/node2 init /debug/genesis.json >> $LOG_FILE 2>&1

geth --datadir /debug/node2 \
 --syncmode "full" \
 --port 30311 \
 --http \
 --http.addr "0.0.0.0" \
 --http.vhosts=* \
 --http.port 8040 \
 --authrpc.port 8551 \
 --http.api "personal,eth,net,web3,txpool,miner,admin" \
 --bootnodes "enode://9e5de7d01392bc21842118cad2a059faf8a86352d41bd412bbbc04f3e8694604a75bcb6f3566822101887dec6cec904c36121d032faba6bdf73e9e2b9e4eee28@127.0.0.1:30310" \
 --http.corsdomain "\*" \
 --networkid 10000 \
 --unlock "$NODE2_ADDRESS" \
 --password "/debug/password.txt" \
 --allow-insecure-unlock \
 --miner.etherbase "$NODE2_ADDRESS" \
 --mine
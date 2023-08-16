#!/bin/bash
# Set log file
LOG_FILE="/debug/debug.log"

mkdir -p /debug/node1


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
  "extraData": "0x0000000000000000000000000000000000000000000000000000000000000000<node1_address>69f553e4e2b5ad160ab3fbe4723381ffd65a6a6ca59bb9d4d6330613381f442bfb30a736347fc2720000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
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
NODE1_PASSWORD=$(cat /debug/password.txt)
echo $NODE1_PASSWORD > /debug/node1/password.txt
geth account new --datadir /debug/node1 --password /debug/node1/password.txt >> $LOG_FILE 2>&1
NODE1_ADDRESS=$(geth --datadir /debug/node1 account list | head -1 | awk -F'[{}]' '{print $2}')


# Replace node addresses in the genesis.json file
sed -i "s/<node1_address>/$NODE1_ADDRESS/g" /debug/genesis.json

# Initialize node1 and node2 with the genesis.json file
geth --datadir /debug/node1 init /debug/genesis.json >> $LOG_FILE 2>&1

geth --datadir /debug/node1 \
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
 --unlock "$NODE1_ADDRESS" \
 --password "/debug/password.txt" \
 --allow-insecure-unlock \
 --miner.etherbase "$NODE1_ADDRESS" \
 --mine
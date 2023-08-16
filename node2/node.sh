#!/bin/bash

geth --datadir "/debug/node2" init /app/node2/genesis.json

geth --datadir /debug/node2 \
 --syncmode "full" \
 --port 30312 \
 --http \
 --http.addr "0.0.0.0" \
 --http.vhosts=* \
 --http.port 8041 \
 --authrpc.port 8552 \
 --http.api "personal,eth,net,web3,txpool,miner,admin" \
 --bootnodes "enode://9e5de7d01392bc21842118cad2a059faf8a86352d41bd412bbbc04f3e8694604a75bcb6f3566822101887dec6cec904c36121d032faba6bdf73e9e2b9e4eee28@127.0.0.1:30310" \
 --http.corsdomain "\*" \
 --networkid 10000 \
 --unlock "0x69F553e4e2b5ad160Ab3FBE4723381ffD65A6A6C" \
 --password "/app/node2/password.txt" \
 --allow-insecure-unlock \
 --miner.etherbase "0x69F553e4e2b5ad160Ab3FBE4723381ffD65A6A6C" \
 --mine
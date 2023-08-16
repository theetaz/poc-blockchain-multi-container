#!/bin/bash
mkdir -p /debug/node1
mkdir -p /debug/node1/data
mkdir -p /debug/node1/data/keystore

keydata='{"address":"11acb7500e281fc6c881c6067005233e8dc10708","crypto":{"cipher":"aes-128-ctr","ciphertext":"74cc4e0fac1fd45fa74c7658f848af9fbfbf79e7df492f58b2d9e89471de7f16","cipherparams":{"iv":"4b7557e278a09da2776e914651e07dff"},"kdf":"scrypt","kdfparams":{"dklen":32,"n":262144,"p":1,"r":8,"salt":"22fa427aecdbf4d547cf5e4bc4fec2ba7fddc7f886e89a3d5af676ec1d9ad724"},"mac":"a111542ef016906eca38851665a0f4eb69d09cb8b876f6f2277d6c30713ad68b"},"id":"f57dd095-eefa-4166-9880-c3eb1366ac91","version":3}'
echo $keydata > /debug/node1/data/keystore/UTC--2023-08-14T10-53-41.771220000Z--11acb7500e281fc6c881c6067005233e8dc10708



geth --datadir "/debug/node1" init /debug/genesis.json

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
 --unlock "0x11aCb7500E281Fc6C881C6067005233E8dc10708" \
 --password "/debug/password.txt" \
 --allow-insecure-unlock \
 --miner.etherbase "0x11aCb7500E281Fc6C881C6067005233E8dc10708" \
 --mine
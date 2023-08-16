geth --datadir "/debug/node1" init /debug/genesis.json

echo "Contents of genesis.json"
cat /debug/genesis.json

echo "Contents of passwpord.txt"
cat /debug/password.txt

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
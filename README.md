# docker-aerospike-server

docker build -t aerospike-server .

docker run --name aerospike --network host -v /etc/aerospike/aerospike.conf:/etc/aerospike/aerospike.conf -tid aerospike-server
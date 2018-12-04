#!/bin/bash
#
# Start a Docker container which runs the four consensus nodes. If it is
# already running, it will be destroyed first.
#
TAG_NAME="2.9.2"
CONTAINER_NAME="neo-privnet"
CONTAINER=$(docker ps -aqf name=$CONTAINER_NAME)

if [ -n "$CONTAINER" ]; then
	echo "Stopping container named $CONTAINER_NAME"
	docker stop $CONTAINER_NAME 1>/dev/null
	echo "Removing container named $CONTAINER_NAME"
	docker rm $CONTAINER_NAME 1>/dev/null
fi

echo "Starting container..."
docker run -d \
  --name $CONTAINER_NAME \
  -p 20333-20336:20333-20336/tcp \
  -p 30333-30336:30333-30336/tcp \
  -v neo-2_9_2-blockchain-1:/opt/node1/neo-cli/Chain \
  -v neo-2_9_2-blockchain-2:/opt/node2/neo-cli/Chain \
  -v neo-2_9_2-blockchain-3:/opt/node3/neo-cli/Chain \
  -v neo-2_9_2-blockchain-4:/opt/node4/neo-cli/Chain \
  --mount type=bind,source=/opt/chain.acc,target=/opt/node1/neo-cli/chain.acc,readonly \
  --mount type=bind,source=/opt/chain.acc,target=/opt/node2/neo-cli/chain.acc,readonly \
  --mount type=bind,source=/opt/chain.acc,target=/opt/node3/neo-cli/chain.acc,readonly \
  --mount type=bind,source=/opt/chain.acc,target=/opt/node4/neo-cli/chain.acc,readonly \
  -h $CONTAINER_NAME \
  $CONTAINER_NAME:$TAG_NAME

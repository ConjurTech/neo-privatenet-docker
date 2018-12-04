#!/bin/bash
#
# This script starts four consensus and waits forever
#
screen -dmS node1 dotnet /opt/node1/neo-cli/neo-cli.dll --rpc
screen -dmS node2 dotnet /opt/node2/neo-cli/neo-cli.dll --rpc
screen -dmS node3 dotnet /opt/node3/neo-cli/neo-cli.dll --rpc
screen -dmS node4 dotnet /opt/node4/neo-cli/neo-cli.dll --rpc

sleep infinity

#!/bin/bash

echo "Docker Entrypoint Alice"
echo "Node Key is ${NODE_KEY}"
echo "Node Env is ${NODE_ENV}"
echo "Chain Version is ${CHAIN_VERSION}"

./docker-build-chain-spec.sh

../target/release/datahighway --validator \
  --unsafe-ws-external \
  --unsafe-rpc-external \
  --rpc-cors=all \
  --base-path /tmp/polkadot-chains/alice \
  --keystore-path "/tmp/polkadot-chains/alice/keys" \
  --chain ../src/chain-definition-custom/chain_def_${CHAIN_VERSION}.json \
  --node-key ${NODE_KEY} \
  --alice \
  --name "${NODE_ENV} Validator Alice" \
  --port 30333 \
  --ws-port 9944 \
  --rpc-port 9933 \
  --telemetry-url ws://telemetry.polkadot.io:1024 \
  --execution=native \
  -lruntime=debug

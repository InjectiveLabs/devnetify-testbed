#!/bin/bash

# ulimit -n 120000

docker run -it --rm \
    -e DEVNET_FORCE_PASS_GOV_PROPOSALS=${DEVNET_FORCE_PASS_GOV_PROPOSALS:-true} \
    -p 26657:26657 \
    -p 10337:10337 \
    -v $(pwd)/injective-1:/apps/data/injective-1 \
    injectivelabs/injective-core:v1.16.4 injectived \
    --log-level "info" \
    --home "./injective-1/validators/0" \
    start

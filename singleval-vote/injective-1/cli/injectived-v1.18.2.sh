#!/bin/bash

ulimit -n 120000

docker run -it --rm \
    -p 26657:26657 \
    -p 10337:10337 \
    -v $(pwd)/injective-1/validators/0:/apps/data/injective-1 \
    injectivelabs/injective-core:v1.18.2 injectived \
    --log-level "info" \
    --home "./injective-1" \
    start

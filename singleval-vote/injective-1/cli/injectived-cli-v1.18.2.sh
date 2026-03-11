#!/bin/bash

ulimit -n 120000

docker run --rm \
    --add-host=host.docker.internal:host-gateway \
    -v $(pwd)/injective-1:/apps/data/injective-1 \
    -v $(pwd)/proposals:/apps/data/proposals \
    injectivelabs/injective-core:v1.18.2 injectived \
    --home "./injective-1" \
    ${*:-"query"}

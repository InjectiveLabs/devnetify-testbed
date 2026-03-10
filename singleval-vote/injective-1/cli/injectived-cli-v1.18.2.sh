#!/bin/bash

ulimit -n 120000

docker run -it --rm \
    -v $(pwd)/injective-1:/apps/data/injective-1 \
    injectivelabs/injective-core:v1.18.2 injectived \
    --home "./injective-1" \
    ${*:-"query"}

#!/bin/bash

ulimit -n 120000

docker run --rm \
    --add-host=host.docker.internal:host-gateway \
    -v $(pwd)/injective-1:/apps/data/injective-1 \
    -v $(pwd)/proposals:/apps/data/proposals \
    public.ecr.aws/l9h3g6c6/injective-core:v1.16.2-devnetify.3 injectived \
    --home "./injective-1" \
    ${*:-"query"}

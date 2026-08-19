#!/bin/bash

UPGRADE_HANDLER_VERSION=${UPGRADE_HANDLER_VERSION:-"v1.20.4"}

INJECTIVED="docker run -it --rm \
    -v $(pwd)/injective-1:/apps/data/injective-1 \
    injectivelabs/injective-core:v1.20.3 injectived"

$INJECTIVED devnetify \
    --home ./injective-1/validators/0 \
    -y -O ./injective-1/custom_overrides.yaml \
    -V ./injective-1/validators \
    -K ./injective-1/instances/0/accounts.json \
    -u ${UPGRADE_HANDLER_VERSION} \
    injective-1

#!/bin/bash

UPGRADE_HANDLER_VERSION=${UPGRADE_HANDLER_VERSION:-"v1.16.4"}

INJECTIVED="docker run -it --rm \
    -e DEVNET_FORCE_PASS_GOV_PROPOSALS=${DEVNET_FORCE_PASS_GOV_PROPOSALS:-true} \
    -v $(pwd)/injective-888:/apps/data/injective-888 \
    injectivelabs/injective-core:v1.16.4 injectived"

$INJECTIVED devnetify \
    --home ./injective-888/validators/0 \
    -y -O ./injective-888/custom_overrides.yaml \
    -V ./injective-888/validators \
    -K ./injective-888/instances/0/accounts.json \
    -u ${UPGRADE_HANDLER_VERSION} \
    injective-888

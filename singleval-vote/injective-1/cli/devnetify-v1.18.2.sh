#!/bin/bash

INJECTIVED="docker run -it --rm \
    -v $(pwd)/injective-1/validators/0:/apps/data/injective-1 \
    -v $(pwd)/injective-1/validators:/apps/data/validators \
    -v $(pwd)/injective-1/instances:/apps/data/instances \
    -v $(pwd)/custom_overrides.yaml:/apps/data/custom_overrides.yaml:ro \
    injectivelabs/injective-core:v1.18.2 injectived"

$INJECTIVED --home "./injective-1" devnetify \
    --skip-confirmation \
    -V /apps/data/validators \
    -K /apps/data/instances/0/accounts.json \
    --custom-overrides ./custom_overrides.yaml \
    injective-1

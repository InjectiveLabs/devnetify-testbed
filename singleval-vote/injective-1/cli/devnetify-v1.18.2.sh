#!/bin/bash

INJECTIVED="docker run -it --rm \
    -v $(pwd)/injective-1:/apps/data/injective-1 \
    -v $(pwd)/custom_overrides.yaml:/apps/data/custom_overrides.yaml:ro \
    injectivelabs/injective-core:v1.18.2 injectived"

$INJECTIVED --home "./injective-1" devnetify --skip-confirmation --custom-overrides ./custom_overrides.yaml injective-1

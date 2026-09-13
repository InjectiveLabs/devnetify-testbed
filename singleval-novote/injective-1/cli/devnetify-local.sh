#!/bin/bash

UPGRADE_HANDLER_VERSION=${UPGRADE_HANDLER_VERSION:-"v1.20.4"}

injectived devnetify \
    --home ./injective-1/validators/0 \
    -y -O ./injective-1/custom_overrides.yaml \
    -V ./injective-1/validators \
    -K ./injective-1/instances/0/accounts.json \
    $([ ! -z "${UPGRADE_HANDLER_VERSION}" ] && echo "-u ${UPGRADE_HANDLER_VERSION}") \
    injective-1

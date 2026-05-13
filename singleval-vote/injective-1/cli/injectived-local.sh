#!/bin/bash

ulimit -n 120000

injectived \
--log-level "info" \
--home "./injective-1/validators/0" \
start

#!/bin/bash

ulimit -n 120000

#injectived --log-level "info" --home "./injective-1/validators/0" start --metrics-enable-metrics --metrics-enable-tracing --metrics-insecure true
injectived --log-level "info" --home "./injective-1/validators/0" start

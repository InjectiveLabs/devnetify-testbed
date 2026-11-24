#!/bin/bash

set -uo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)" || exit 1
COMPOSE_FILE="${SCRIPT_DIR}/../docker-compose.devnetify.yml"

exit_code=0
docker compose -f "${COMPOSE_FILE}" up --abort-on-container-failure || exit_code=$?

down_code=0
docker compose -f "${COMPOSE_FILE}" down || down_code=$?

if [ "${exit_code}" -ne 0 ]; then
    exit "${exit_code}"
fi

exit "${down_code}"

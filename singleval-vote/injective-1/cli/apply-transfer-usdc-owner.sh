#!/bin/bash

set -e

ECHO_ONLY=
CLI=${CLI:-$(dirname $0)/injectived-cli-v1.18.2.sh}
NODE=${NODE:-tcp://host.docker.internal:26657}
PROPOSAL_FILE=${PROPOSAL_FILE:-/apps/data/proposals/transfer_usdc_namespace_owner.json}
TX_OPTS="--keyring-backend=test --from=account0 --chain-id=injective-1 --gas-prices 500000000inj --gas=auto --gas-adjustment=1.5 --broadcast-mode=sync --yes"

fetch_proposal_id() {
    current_proposal_id=$(curl 'http://localhost:10337/cosmos/gov/v1/proposals?proposal_status=0&pagination.limit=1&pagination.reverse=true' | jq -r '.proposals[].id')
    proposal=$((current_proposal_id))
}

post_proposal() {
    $ECHO_ONLY $CLI tx gov submit-proposal \
    $PROPOSAL_FILE \
    $TX_OPTS \
    --node "$NODE"
}

vote() {
    PROPOSAL_ID=$1
    echo $PROPOSAL_ID
    $ECHO_ONLY $CLI tx \
        --node "$NODE" \
        gov vote $PROPOSAL_ID yes $TX_OPTS
}

echo "Posting proposal"

post_proposal

sleep 3

echo "Fetching proposal id"

fetch_proposal_id

echo "Voting for proposal"

vote $proposal

echo "Proposal submitted and voted. Verify ownership transfer with:"
echo "curl -s 'http://localhost:10337/injective/permissions/v1beta1/namespace/erc20:0xa00C59fF5a080D2b954d0c75e46E22a0c371235a' | jq '.namespace'"

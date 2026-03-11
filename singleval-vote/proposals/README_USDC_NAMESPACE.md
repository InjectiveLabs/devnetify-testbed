
**Step 1** proposal is `transfer_usdc_namespace_owner.json`. I changed it so `inj1a5...` gets role-manager rights for both EVERYONE and admin, plus all policy-manager capabilities, while gov is
  revoked only from the admin actor role.

**Step 2** only needs one direct tx, not multiple. The payload is `remove_gov_usdc_namespace_rights.json`. It removes gov from:

* role_managers
* all policy_manager_capabilities

  It also leaves `inj1a5...` as the sole manager for EVERYONE and admin.

## Applying

  Send commands on live mainnet:

```
  DENOM='erc20:0xa00C59fF5a080D2b954d0c75e46E22a0c371235a'
  NODE='https://sentry.tm.injective.network:443'
```

### 1) Submit step-1 gov proposal from any wallet with enough INJ deposit

  ```
  injectived tx gov submit-proposal \
    ./proposals/transfer_usdc_namespace_owner.json \
    --from <proposal_submitter> \
    --chain-id injective-1 \
    --gas auto --gas-adjustment 1.5 \
    --gas-prices 160000000inj \
    --yes \
    --node "$NODE"
```

### 2) Vote yes from staked voting wallets

```
  injectived tx gov vote <proposal_id> yes \
    --from <voter> \
    --chain-id injective-1 \
    --gas auto --gas-adjustment 1.5 \
    --gas-prices 160000000inj \
    --yes \
    --node "$NODE"
```

### 3) After step 1 passes, send the follow-up direct tx as inj1a5

```
  injectived tx permissions update-namespace \
    ./proposals/remove_gov_usdc_namespace_rights.json \
    --from <key_for_inj1a5ydas7ejr7xsagcwd5a6teljm85thguhfp93u> \
    --chain-id injective-1 \
    --gas auto --gas-adjustment 1.5 \
    --gas-prices 160000000inj \
    --yes \
    --node "$NODE"
```

## Verifying

Verify current / step-1 / final state:

### Full namespace

```
  curl -s "https://sentry.lcd.injective.network:443/injective/permissions/v1beta1/namespace/${DENOM}" | jq '.namespace'
```

### Focused view

```
  curl -s "https://sentry.lcd.injective.network:443/injective/permissions/v1beta1/namespace/${DENOM}" \
    | jq '.namespace | {actor_roles, role_managers, policy_manager_capabilities}'
```

**Expected after step 1:**

* actor_roles: only `inj1a5...` has admin
* role_managers: both `gov` and `inj1a5...` still appear
* policy_manager_capabilities: both `gov` and `inj1a5...` still appear

**Expected after step 2:**

* actor_roles: only `inj1a5...`
* role_managers: only `inj1a5...` with `["EVERYONE","admin"]`
* policy_manager_capabilities: only `inj1a5...`

The local helper script is also aligned now at `apply-transfer-usdc-owner.sh`, but for mainnet the commands above are the important part.

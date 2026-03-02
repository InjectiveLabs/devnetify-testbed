# Mainnet Devnetify Testbed (Multi Validator, no voting, no binary swaps)

For legacy setup, with voting required and binary swaps, see [../singleval-vote](../singleval-vote)

Allows to take a network state snapshot, devnetify to run it locally with multi validators (4), and perform an upgrade handler. This allows to test upgrade handler locally for both testnet and mainnet live state.

## Steps to re-build the mainnet from scratch

NOTE:

Docker images always have a version tag, you can build image locally and make a special version tag.
Meanwhile, locally available binaries (injectived), are not tagged, it uses whatever binary is available.

Requirements: Make sure you have git-lfs installed and pulled the repo with `git lfs pull` to have all local files.

If you already cloned:

```bash
git lfs install
git lfs fetch --all
git lfs checkout # or: git lfs pull
```

If you haven’t cloned yet:

```bash
git lfs install
git clone https://github.com/InjectiveLabs/injective-devnetify-testbed
cd injective-devnetify-testbed
git lfs pull
```

```bash
# after cloning repo don't forget to initialize LFS

git lfs install
git lfs pull
```

STEPS:

0. _(optionally)_ Re-generate target validators dirs and keys using `make gen-4` if target version changes. Uses [chain-stresser](https://github.com/InjectiveLabs/chain-stresser) binary.
1. Download the latest [mainnet state snapshot](https://polkachu.com/tendermint_snapshots/injective) from Polkachu, put archive into `injective-1/` dir.
2. Run `make unpack`, it will decompress and copy data into all 4 validators.
3. Run `make devnetify`, wait for it to finish. Tip: set `UPGRADE_HANDLER_VERSION` and `DOCKER_IMAGE` in [./injective-1/.env](./injective-1/.env) file.
4. Tada! If it exited with 0, you have a multi-validator state with 4 validators, ready to be used for testing.
5. Run `make injectived-start` to start docker compose network of 4 validators, running continuously.
6. Run `make injectived-stop` to stop the docker compose network and clean up.
7. _(optionally)_ Run `make clean` to remove all data and rollback to Step 1. (archive not removed, can do `make unpack` next).

Access the first node using CLI (via Docker container) `./injective-1/cli/injectived-cli-v1.16.4.sh` or via local binary `./injective-1/cli/injectived-cli-local.sh`

## Useful endpoints

Use this to debug any step of devnetify process. All endpoints are pointing to the first node inside compose.

Last proposal

```http
http://localhost:10337/cosmos/gov/v1beta1/proposals?pagination.limit=1&pagination.reverse=true
```

Voting params

```http
http://localhost:10337/cosmos/gov/v1/params/voting
```

Validators set

```http
http://localhost:10337/cosmos/staking/v1beta1/validators
```

## Makefile

There is a handy Makefile to automate the process.

Default environment values:

```bash
CHAIN_ID=1 # set the chain id
VERSION_TO=v1.16.4 # set the version to
DOCKER_IMAGE?=injectivelabs/injective-core:$(VERSION_TO)
```

(meanwhile also need to tweak variables [./injective-1/.env](./injective-1/.env) file, as I tweak the pipeline still)

Targets:

```bash
make devnetify # devnetify the state using docker compose (all 4 validators need to start immediately)
make injectived-start # run (4) injectived nodes with docker compose
make injectived-stop # stop the docker compose network and clean up
make clean # clean up the data and wasm directories
make unpack # unpack the snapshot from the tar.lz4 file
```

There is also a `unpack` target to unpack the snapshot from any `*.tar.lz4` file. Just download the snapshot from Polkachu to the target chain dir and run `make unpack`. Use `CHAIN_ID` to set the valid chain dir prefix, e.g. `CHAIN_ID=1 make unpack`.

# Devnetify Testbed Scripts

## This repo is a demo case for the devnetify process

The flow changed since last version of testbed scripts:

* New default flow is to deventify network into multi-validator (4) setup, no governance vote for upgrade is required, as it happens in-place during devnetify.
* The flow is located inside [multival-novote](multival-novote/) dir.

Alternative flow, to avoid using docker and run node natively:

* [singleval-novote](singleval-novote/)
* It bootstraps and devnitifies the network with a single validator. It is not suitable for any serious testing (app-hash won't be caught, etc).

Previous (Legacy) flow was to devnetify with a single validator and run the upgrade proposal through a governance vote, replacing the binaries after proposal passes. That was not an efficient flow, but handled things in a way that resembeles usual chain operations.

Archive of the legacy flow can be found there: [singleval-vote](singleval-vote/)

## How to run

```bash
# after cloning repo don't forget to initialize LFS

git lfs install
git lfs pull
```


All approaches to devnetify an existing network state are based `injectived devnetify` subcommand, implemented since `v1.16.x` and going forward.

* [multival-novote](multival-novote/) - new flow
* [singleval-novote](singleval-novote/) - new flow, single validator
* [singleval-vote](singleval-vote/) - legacy

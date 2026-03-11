all:

CHAIN_ID?=1
VERSION_FROM?=v1.18.2
VERSION_TO?=1.18.2

devnetify:
	./injective-$(CHAIN_ID)/cli/devnetify-$(VERSION_FROM).sh

apply-upgrade:
	./injective-$(CHAIN_ID)/cli/apply-upgrade-$(VERSION_TO).sh

injectived:
	./injective-$(CHAIN_ID)/cli/injectived-$(VERSION_FROM).sh

injectived-local:
	./injective-$(CHAIN_ID)/cli/injectived-local.sh

injectived-cli:
	./injective-$(CHAIN_ID)/cli/injectived-cli-$(VERSION_FROM).sh

injectived-cli-local:
	./injective-$(CHAIN_ID)/cli/injectived-cli-local.sh

apply-evm-proposal:
	./injective-$(CHAIN_ID)/cli/apply-evm-proposal.sh

clean:
	@rm -rf injective-$(CHAIN_ID)/validators/0/data
	@rm -rf injective-$(CHAIN_ID)/validators/0/wasm

unpack: clean
	lz4 -d injective-$(CHAIN_ID)/*.tar.lz4 --stdout | tar -xf - -C injective-$(CHAIN_ID)/validators/0/

.PHONY: devnetify apply-upgrade injectived injectived-local injectived-cli injectived-cli-local apply-evm-proposal unpack clean

all:

CHAIN_ID?=1
VERSION_TO?=v1.20.4
DOCKER_IMAGE?=injectivelabs/injective-core:$(VERSION_TO)

devnetify:
	./injective-$(CHAIN_ID)/cli/devnetify-$(VERSION_TO).sh

devnetify-local:
	./injective-$(CHAIN_ID)/cli/devnetify-local.sh

injectived:
	./injective-$(CHAIN_ID)/cli/injectived-$(VERSION_TO).sh

injectived-local:
	./injective-$(CHAIN_ID)/cli/injectived-local.sh

injectived-cli:
	./injective-$(CHAIN_ID)/cli/injectived-cli-$(VERSION_TO).sh

injectived-cli-local:
	./injective-$(CHAIN_ID)/cli/injectived-cli-local.sh

gen:
	chain-stresser generate --accounts-num 1 --validators 1 --sentries 0 --instances 1 --prod --evm true --out injective-$(CHAIN_ID)/ --chain-id injective-$(CHAIN_ID) --native
	@cp -r injective-$(CHAIN_ID)/chain-stresser-deploy/* injective-$(CHAIN_ID)/
	@rm -rf injective-$(CHAIN_ID)/chain-stresser-deploy/

clean:
	@rm -rf injective-$(CHAIN_ID)/validators/0/data
	@rm -rf injective-$(CHAIN_ID)/validators/0/wasm

unpack: clean
	lz4 -d injective-$(CHAIN_ID)/*.tar.lz4 --stdout | tar -xf - -C injective-$(CHAIN_ID)/validators/0

.PHONY: devnetify devnetify-local injectived-compose injectived-compose-down injectived-cli injectived-cli-local gen clean unpack

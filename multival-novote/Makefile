all:

CHAIN_ID?=1
VERSION_TO?=v1.17.2
DOCKER_IMAGE?=injectivelabs/injective-core:$(VERSION_TO)

devnetify:
	./injective-$(CHAIN_ID)/cli/devnetify.sh

injectived-start:
	./injective-$(CHAIN_ID)/cli/injectived-start.sh

injectived-stop:
	./injective-$(CHAIN_ID)/cli/injectived-stop.sh

injectived-cli:
	./injective-$(CHAIN_ID)/cli/injectived-cli-$(VERSION_TO).sh

injectived-cli-local:
	./injective-$(CHAIN_ID)/cli/injectived-cli-local.sh

gen-4:
	chain-stresser generate --accounts-num 4 --validators 4 --sentries 0 --instances 1 --prod --evm true --out injective-$(CHAIN_ID)/ --chain-id injective-$(CHAIN_ID) --docker-image $(DOCKER_IMAGE)
	@cp -r injective-$(CHAIN_ID)/chain-stresser-deploy/* injective-$(CHAIN_ID)/
	@rm -rf injective-$(CHAIN_ID)/chain-stresser-deploy/

clean: injectived-stop
	@rm -rf injective-$(CHAIN_ID)/validators/0/data
	@rm -rf injective-$(CHAIN_ID)/validators/0/wasm
	@rm -rf injective-$(CHAIN_ID)/validators/1/data
	@rm -rf injective-$(CHAIN_ID)/validators/1/wasm
	@rm -rf injective-$(CHAIN_ID)/validators/2/data
	@rm -rf injective-$(CHAIN_ID)/validators/2/wasm
	@rm -rf injective-$(CHAIN_ID)/validators/3/data
	@rm -rf injective-$(CHAIN_ID)/validators/3/wasm

unpack: clean
	lz4 -d injective-$(CHAIN_ID)/*.tar.lz4 --stdout | tar -xf - -C injective-$(CHAIN_ID)/validators/0
	cp -r injective-$(CHAIN_ID)/validators/0/data injective-$(CHAIN_ID)/validators/1/
	cp -r injective-$(CHAIN_ID)/validators/0/wasm injective-$(CHAIN_ID)/validators/1/
	cp -r injective-$(CHAIN_ID)/validators/0/data injective-$(CHAIN_ID)/validators/2/
	cp -r injective-$(CHAIN_ID)/validators/0/wasm injective-$(CHAIN_ID)/validators/2/
	cp -r injective-$(CHAIN_ID)/validators/0/data injective-$(CHAIN_ID)/validators/3/
	cp -r injective-$(CHAIN_ID)/validators/0/wasm injective-$(CHAIN_ID)/validators/3/

.PHONY: devnetify injectived-start injectived-stop injectived-cli injectived-cli-local gen-4 clean unpack

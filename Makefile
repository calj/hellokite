VERSION := $(shell cat VERSION)
IMAGE   := gcr.io/helios-devel/hellokite:$(VERSION)

.PHONY: default build push run ci deploy

default: build run

build:
	@echo '> Building "hellokite" docker image...'
	@docker build -t $(IMAGE) .

push: build
	gcloud docker -- push $(IMAGE)

run:
	@echo '> Starting "hellokite" container...'
	@docker run -d $(IMAGE)

ci:
	@fly -t ci set-pipeline -p hellokite -c .kite/pipelines/review.yml -n
	@fly -t ci unpause-pipeline -p hellokite

deploy: push
	@helm install ./.kite/charts/hellokite --set "image.tag=$(VERSION)"

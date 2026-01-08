SHELL := bash
.DEFAULT_GOAL := help

.PHONY: help install bundle-config bundle-install serve build clean doctor og-image purge-bunny

help: ## Show available targets
	@awk 'BEGIN {FS = ":.*##"} /^[a-zA-Z0-9_.-]+:.*##/ {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install: bundle-install ## Install Ruby gems for this repo

bundle-config: ## Configure Bundler to install into vendor/bundle
	@bundle config set --local path vendor/bundle

bundle-install: bundle-config ## Install gems via Bundler
	@bundle install

serve: ## Run local dev server at http://127.0.0.1:4000
	@bundle exec jekyll serve

build: ## Build the site into ./_site (GitHub Pages stack)
	@bundle exec github-pages build --source . --destination ./_site

og-image: ## Generate Open Graph banner image (requires ImageMagick)
	@bash scripts/generate-og-image.sh

purge-bunny: ## Purge Bunny cache (requires BUNNY_PULLZONE_ID and BUNNY_API_KEY)
	@test -n "$$BUNNY_PULLZONE_ID" || (echo "Missing env var: BUNNY_PULLZONE_ID" && exit 1)
	@test -n "$$BUNNY_API_KEY" || (echo "Missing env var: BUNNY_API_KEY" && exit 1)
	@curl -fsS -X POST "https://api.bunny.net/pullzone/$$BUNNY_PULLZONE_ID/purgeCache" \
	  -H "AccessKey: $$BUNNY_API_KEY"

doctor: ## Run Jekyll diagnostics
	@bundle exec jekyll doctor

clean: ## Remove generated build artifacts
	@rm -rf _site .jekyll-cache .jekyll-metadata

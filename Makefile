SHELL := bash
.DEFAULT_GOAL := help

.PHONY: help install bundle-config bundle-install serve build clean doctor og-image

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

doctor: ## Run Jekyll diagnostics
	@bundle exec jekyll doctor

clean: ## Remove generated build artifacts
	@rm -rf _site .jekyll-cache .jekyll-metadata

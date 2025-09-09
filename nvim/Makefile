.DEFAULT_GLOBAL := config-install

NVIM_DIR := $(HOME)/.config/nvim
NVIM_THEME_DIR := $(NVIM_DIR)/colors

# Phony Targets
.PHONY: all nvim-installed config-install get-deps
all: nvim-installed get-deps config-install

get-deps: check-venv
	@pip install -r requirements.txt

nvim-installed:
	@if ! command -v nvim > /dev/null; then \
		echo "Error: could not find nvim"; \
		exit 1; \
	fi

check-venv:
	@if [ -z "$$VIRTUAL_ENV" ] && [ -z "$$CONDA_PREFIX" ]; then \
		echo "Error: Not inside a Python virtual environment"; \
		exit 1; \
	fi

config-install: $(NVIM_THEME_DIR)/chromat.lua $(NVIM_DIR)/init.lua

# Targets:
# TODO: technically the init.lua build should depend on the theme building.
./build:
	@mkdir -p ./build/

$(NVIM_DIR):
	@mkdir -p $(NVIM_DIR)

$(NVIM_DIR)/init.lua: $(NVIM_DIR) build/init.lua
	@cp -v build/init.lua $(NVIM_DIR)

build/init.lua: check-venv ./build
	@python3 gen_config.py

$(NVIM_THEME_DIR):
	@mkdir -p $(NVIM_THEME_DIR)

$(NVIM_THEME_DIR)/chromat.lua: $(NVIM_THEME_DIR) build/chromat.lua
	@cp -v build/chromat.lua $(NVIM_THEME_DIR)

build/chromat.lua: check-venv ./build
	@python3 gen_chromat_theme.py



.DEFAULT_GLOBAL := config-install

ALACRITTY_DIR := $(HOME)/.config/alacritty


# Phony Targets
.PHONY: all alacritty-installed config-install get-deps
all: alacritty-installed get-deps config-install

get-deps: check-venv
	@pip install -r requirements.txt

alacritty-installed:
	@if ! command -v alacritty > /dev/null; then \
		echo "Error: could not find alacritty"; \
		exit 1; \
	fi

check-venv:
	@if [ -z "$$VIRTUAL_ENV" ] && [ -z "$$CONDA_PREFIX" ]; then \
		echo "Error: Not inside a Python virtual environment"; \
		exit 1; \
	fi

config-install: $(ALACRITTY_DIR)/alacritty.toml

# Targets:
./build:
	@mkdir -p ./build/

build/alacritty.toml: check-venv ./build
	@python3 gen_config.py

$(ALACRITTY_DIR):
	@mkdir -p $(ALACRITTY_DIR)

$(ALACRITTY_DIR)/alacritty.toml: $(ALACRITTY_DIR) build/alacritty.toml
	@cp -v build/alacritty.toml $(ALACRITTY_DIR)

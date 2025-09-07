.DEFAULT_GLOBAL := config-install

WAYBAR_DIR := $(HOME)/.config/waybar

# Phony Targets
.PHONY: all waybar-installed config-install get-deps
all: waybar-installed get-deps config-install

get-deps: check-venv
	@pip install -r requirements.txt

waybar-installed:
	@if ! command -v waybar > /dev/null; then \
		echo "Error: could not find waybar"; \
		exit 1; \
	fi

check-venv:
	@if [ -z "$$VIRTUAL_ENV" ] && [ -z "$$CONDA_PREFIX" ]; then \
		echo "Error: Not inside a Python virtual environment"; \
		exit 1; \
	fi

config-install: $(WAYBAR_DIR)/style.css $(WAYBAR_DIR)/config.jsonc

# Targets:
./build:
	@mkdir -p ./build/

build/style.css: check-venv ./build
	@python3 gen_style.py

build/config.jsonc: check-venv ./build
	@python3 gen_config.py

$(WAYBAR_DIR):
	@mkdir -p $(WAYBAR_DIR)

$(WAYBAR_DIR)/style.css: $(WAYBAR_DIR) build/style.css
	@cp -v build/style.css $(WAYBAR_DIR)

$(WAYBAR_DIR)/config.jsonc: $(WAYBAR_DIR) build/config.jsonc
	@cp -v build/config.jsonc $(WAYBAR_DIR)

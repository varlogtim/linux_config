.DEFAULT_GLOBAL := config-install

SWAY_DIR := $(HOME)/.config/sway


# Phony Targets
.PHONY: all sway-installed config-install get-deps
all: sway-installed get-deps config-install

get-deps: check-venv
	@pip install -r requirements.txt

sway-installed:
	@if ! command -v sway > /dev/null; then \
		echo "Error: could not find sway"; \
		exit 1; \
	fi

check-venv:
	@if [ -z "$$VIRTUAL_ENV" ] && [ -z "$$CONDA_PREFIX" ]; then \
		echo "Error: Not inside a Python virtual environment"; \
		exit 1; \
	fi

config-install: $(SWAY_DIR)/config

# Targets:
./build:
	@mkdir -p ./build/

build/config: check-venv ./build
	@python3 gen_config.py

$(SWAY_DIR):
	@mkdir -p $(SWAY_DIR)

$(SWAY_DIR)/config: $(SWAY_DIR) build/config
	@cp -v build/config $(SWAY_DIR)

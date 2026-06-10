.DEFAULT_GLOBAL := config-install

SWAY_DIR := $(HOME)/.config/sway
SCREENSHOT_DIR := $(HOME)/screenshots
FUZZEL_DIR := $(HOME)/.config/fuzzel
FUZZEL_INI := $(FUZZEL_DIR)/fuzzel.ini


# Phony Targets
.PHONY: all sway-installed config-install get-deps
all: sway-installed get-deps config-install

# Need a target for installing fuzzel

$(SCREENSHOT_DIR):
	@mkdir -p $(SCREENSHOT_DIR)

$(FUZZEL_DIR):
	@mkdir -p $(FUZZEL_DIR)

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

config-install: $(SCREENSHOT_DIR) $(FUZZEL_INI) $(SWAY_DIR)/config

# Targets:
./build:
	@mkdir -p ./build/

build/config: check-venv ./build
	@python3 gen_config.py --screenshot-dir $(SCREENSHOT_DIR)

$(SWAY_DIR):
	@mkdir -p $(SWAY_DIR)

$(SWAY_DIR)/config: $(SWAY_DIR) build/config
	make -C icons configure-cursor-theme
	@cp -v build/config $(SWAY_DIR)

$(FUZZEL_INI): $(FUZZEL_DIR) ./fuzzel.ini.template
	@cp -v ./fuzzel.ini.template $(FUZZEL_INI)


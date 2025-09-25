.DEFAULT_GLOBAL := config-install

LSD_DIR := $(HOME)/.config/lsd

# Phony Targets
.PHONY: all lsd-installed config-install get-deps
all: lsd-installed config-install

get-deps:
	sudo pacman -S lsd

lsd-installed:
	@if ! command -v lsd > /dev/null; then \
		echo "Error: could not find lsd"; \
		exit 1; \
	fi

config-install: $(LSD_DIR)/config.yaml $(LSD_DIR)/colors.yaml

# Targets:
$(LSD_DIR):
	@mkdir -p $(LSD_DIR)

$(LSD_DIR)/config.yaml: $(LSD_DIR) config.yaml
	@cp -v ./config.yaml $(LSD_DIR)

$(LSD_DIR)/colors.yaml: $(LSD_DIR) colors.yaml
	@cp -v ./colors.yaml $(LSD_DIR)


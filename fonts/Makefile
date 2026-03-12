# Targets for Hack Nerd Font only
# Latest release: v3.4.0 (as of 2026; check https://github.com/ryanoasis/nerd-fonts/releases/latest if needed)
NERD_VERSION ?= v3.4.0
HACK_ZIP_URL = https://github.com/ryanoasis/nerd-fonts/releases/download/$(NERD_VERSION)/Hack.zip
FONTS_DIR = $(HOME)/.local/share/fonts

.PHONY: install-hack-nerd verify-hack-nerd clean-hack-nerd

# TODO: need check for curl, unzip, fc-cache?

# Targets:
$(FONTS_DIR):
	@mkdir -p $(FONTS_DIR)

install-hack-nerd: $(FONTS_DIR)
	@echo "Downloading Hack Nerd Font from $(HACK_ZIP_URL)..."
	@cd $(FONTS_DIR) && \
		curl -LO --fail --retry 3 --retry-delay 3 "$(HACK_ZIP_URL)" && \
		unzip -o Hack.zip && \
		rm -f Hack.zip LICENSE.md readme.md 2>/dev/null || true
	@fc-cache -fv
	@echo "Hack Nerd Font installed."
	@make verify-hack-nerd

verify-hack-nerd:
	@echo "Verifying Hack Nerd Font installation..."
	@fc-list | grep -i "Hack Nerd" || { \
		echo "Hack Nerd Font NOT found in fc-list."; \
		echo "Try running 'fc-cache -fv' manually or check ~/.local/share/fonts."; \
		exit 1; \
	}
	@echo "Hack Nerd Font found! Variants:"
	@fc-list | grep -i "Hack Nerd" | sort | head -n 5  # show a few examples
	@echo "... (full list via fc-list | grep -i 'Hack Nerd')"

clean-hack-nerd:
	@rm -rf $(FONTS_DIR)/Hack* $(FONTS_DIR)/*.ttf $(FONTS_DIR)/*.otf 2>/dev/null || true
	@echo "Hack Nerd Font files removed from $(FONTS_DIR). Run fc-cache -fv if needed."

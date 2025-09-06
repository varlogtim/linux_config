.PHONY: install

WAYBAR_DIR := ~/.config/waybar

install:
	mkdir -p $(WAYBAR_DIR)
	cp -v config.jsonc $(WAYBAR_DIR)
	cp -v style.css $(WAYBAR_DIR)

.PHONY: get-deps
get-deps:
	sudo pacman -S waybar

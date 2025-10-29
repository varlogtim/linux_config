.DEFAULT_GLOBAL := config-install

PORTAL_DIR := $(HOME)/.config/xdg-desktop-portal

XDG_PORTAL_PACKAGES = xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk pipewire slurp

# Phony Targets
.PHONY: all xdg-portals-installed config-install get-deps
all: xdg-portals-installed get-deps config-install

get-deps:
	pacman -S $(XDG_PORTAL_PACKAGES)

xdg-portals-installed:
	@pacman -Q $(XDG_PORTAL_PACKAGES) >/dev/null 2>&1 \
		|| { echo "Error: Missing required packages."; exit 1; }
	@systemctl --user is-active xdg-desktop-portal >/dev/null 2>&1 \
		|| { echo "Error: xdg-desktop-portal service not running."; exit 1; }
	@systemctl --user is-active xdg-desktop-portal-wlr >/dev/null 2>&1 \
		|| { echo "Error: xdg-desktop-portal-wlr service not running."; exit 1; }
	@systemctl --user is-active xdg-desktop-portal-gtk >/dev/null 2>&1 \
		|| { echo "Error: xdg-desktop-portal-gtk service not running."; exit 1; }
	@systemctl --user is-active pipewire >/dev/null 2>&1 \
		|| { echo "Error: pipewire service not running."; exit 1; }
	@echo "$(XDG_PORTAL_PACKAGES) are installed and running."

config-install: $(PORTAL_DIR)/portals.conf

# Targets:
$(PORTAL_DIR): xdg-portals-installed
	@mkdir -p $(PORTAL_DIR)

$(PORTAL_DIR)/portals.conf: $(PORTAL_DIR) ./portals.conf
	@cp -v portals.conf $(PORTAL_DIR)
	systemctl --user restart xdg-desktop-portal


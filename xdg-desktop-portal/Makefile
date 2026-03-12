.DEFAULT_GLOBAL := config-install

PORTAL_DIR := $(HOME)/.config/xdg-desktop-portal

XDG_PORTAL_PACKAGES = xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk pipewire slurp



# Phony Targets
.PHONY: all xdg-portals-installed config-install get-deps
all: xdg-portals-installed get-deps config-install

get-deps:
	pacman -S $(XDG_PORTAL_PACKAGES)

# TODO: one possibility I just thought of is to have a "requirements" target in another makefile.
# That makefile would detect the OS and install that requirement...
# Or ... I include a different make file depending on the OS?

xdg-portals-installed:
	# XXX this can't actually be a dependent of config install.
	# The services don't actually start until the window manager has initialized the compositor
	# @pacman -Q $(XDG_PORTAL_PACKAGES) >/dev/null 2>&1 \
	# 	|| { echo "Error: Missing required packages."; exit 1; }
	@systemctl --user is-active xdg-desktop-portal >/dev/null 2>&1 \
		|| { echo "Error: xdg-desktop-portal service not running."; exit 1; }
	@systemctl --user is-active xdg-desktop-portal-wlr >/dev/null 2>&1 \
		|| { echo "Error: xdg-desktop-portal-wlr service not running."; exit 1; }
	@systemctl --user is-active xdg-desktop-portal-gtk >/dev/null 2>&1 \
		|| { echo "Error: xdg-desktop-portal-gtk service not running."; exit 1; }
	@systemctl --user is-active pipewire >/dev/null 2>&1 \
		|| { echo "Error: pipewire service not running."; exit 1; }
	@echo "$(XDG_PORTAL_PACKAGES) are installed and running."

config-install: $(PORTAL_DIR)/sway-portals.conf

# Targets:
$(PORTAL_DIR):
	@mkdir -p $(PORTAL_DIR)

# Overrides system level portals config via ${XDG_CURRENT_DESKTOP}-portals.conf
# So, this will currently only affect sway
$(PORTAL_DIR)/sway-portals.conf: $(PORTAL_DIR) ./sway-portals.conf
	@cp -v sway-portals.conf $(PORTAL_DIR)
	systemctl --user restart xdg-desktop-portal


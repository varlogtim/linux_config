# ==================== Adwaita Cursor Theme (Arch + Ubuntu) ====================
# DISTRO is auto-detected but can be overridden (parent Makefile or CLI):
#   make DISTRO=archlinux cursor-theme
DISTRO ?= $(shell \
	if command -v pacman >/dev/null 2>&1; then echo "archlinux"; \
	elif command -v apt-get >/dev/null 2>&1; then echo "ubuntu"; \
	else echo "unknown"; fi)
# =============================================================================


makefile.PHONY: detect-distro ensure-adwaita-cursors \
        archlinux-install-adwaita ubuntu-install-adwaita \
        configure-cursor-theme cursor-theme

detect-distro:
	@echo "→ Detected DISTRO = $(DISTRO)"
	@if [ "$(DISTRO)" = "unknown" ]; then \
		echo "Error: Could not detect distro (no pacman or apt-get found)"; \
		exit 1; \
	fi

ensure-adwaita-cursors: detect-distro
	@if [ ! -f /usr/share/icons/Adwaita/cursors/grab 2>/dev/null ]; then \
		echo "Adwaita cursor theme missing → installing for $(DISTRO)..."; \
		$(MAKE) --no-print-directory $(DISTRO)-install-adwaita; \
	else \
		echo "Adwaita cursor theme is already installed."; \
	fi

archlinux-install-adwaita:
	sudo pacman -S --needed --noconfirm adwaita-icon-theme

ubuntu-install-adwaita:
	sudo apt-get update -qq && sudo apt-get install -y adwaita-icon-theme

configure-cursor-theme: ensure-adwaita-cursors
	@echo "Configuring GTK cursor theme via gsettings..."
	@gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita' || true
	@gsettings set org.gnome.desktop.interface cursor-size 32 || true
	@echo "GTK cursor settings applied (Adwaita, size 32)"

cursor-theme: configure-cursor-theme
	@echo "Cursor theme setup complete."

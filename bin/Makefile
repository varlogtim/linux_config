# Scripts that hotkeys (sway) and waybar call. Installed as symlinks into
# ~/.local/bin — the same place dictator and jug live, which is on PATH as
# sway sees it — so an edit here is live immediately, no reinstall.
.DEFAULT_GOAL := config-install

BIN_DIR := $(HOME)/.local/bin
SCRIPTS := director

.PHONY: config-install check
config-install: $(addprefix $(BIN_DIR)/,$(SCRIPTS))

$(BIN_DIR):
	@mkdir -p $(BIN_DIR)

$(BIN_DIR)/%: % | $(BIN_DIR)
	@ln -sfv $(CURDIR)/$< $@

# `director` is stdlib-only Python (no venv, no pip): this is the "does it even
# parse" check plus the no-OBS code path. py_compile only writes bytecode,
# nothing runs from it, so send that to /dev/null rather than __pycache__/.
check:
	@python3 -m py_compile director -o /dev/null 2>/dev/null \
		|| python3 -c 'import ast,sys; ast.parse(open("director").read())'
	@./director help > /dev/null
	@echo "director: ok"

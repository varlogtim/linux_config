.PHONY: install
install:
	mkdir -p ~/.config/nvim
	cp init.lua ~/.config/nvim/

.PHONY: get-deps
get-deps:
	pip install ruff ruff-lsp
	pip install python-lsp-server[all]
	pip install neovim-remote
	go install golang.org/x/tools/gopls@latest
	npm install -g typescript-language-server eslint prettier pyright

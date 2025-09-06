.PHONY: install
install:
	mkdir -p ~/.config/nvim/colors
	cp init.lua ~/.config/nvim/
	cp chromat.lua ~/.config/nvim/colors/

.PHONY: get-deps
get-deps:
	# TODO: Should look at these requirements
	# I don't like global python, npm, and golang things being installed.
	# Perhaps I should create a story about creating a global versions of these.
	sudo pacman -S pyright
	#pip install python-lsp-server[all]
	#pip install neovim-remote
	#go install golang.org/x/tools/gopls@latest
	#npm install -g typescript-language-server eslint prettier

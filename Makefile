# Perhaps this should be a script, not sure yet
#
# TODO: I am going to have color palettes that I would like to exist
# across multiple configs. Therefore, I should read the color palette
# and populate the configs with those colors.
#
MAKEFLAGS += --no-print-directory


.PHONY: install-hack-nerd-font
install-hack-nerd-font:
	@mkdir -p /tmp/hack-nerd-font
	@curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip \
		-o /tmp/hack-nerd-font/Hack.zip
	@unzip /tmp/hack-nerd-font/Hack.zip -d /tmp/hack-nerd-font
	@mkdir -p ~/.local/share/fonts
	@find /tmp/hack-nerd-font -name "*.ttf" -exec cp {} ~/.local/share/fonts \;
	@fc-cache -fv
	@rm -rf /tmp/hack-nerd-font

install-x11:
	# Dead code?
	ln -v -s $(PWD)/.xinitrc ~/.xinitrc
	ln -v -s $(PWD)/.Xresources ~/.Xresources
	ln -v -s $(PWD)/awesome ~/.config/awesome

install-vim:
	mkdir -v ~/.vim
	ln -v -s $(PWD)/.vimrc ~/.vimrc
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

install-sway:
	echo impl me

.PHONY: config-install
config-install: config-install-nvim config-install-sway config-install-alacritty config-install-waybar

.PHONY: config-install-%
config-install-%:
	$(MAKE) -C $* config-install


base:
	mkdir -v ~/.config
	mkdir -v ~/bin

	# Should split bashrc into multiple files.
	ln -v -s $(PWD)/.bashrc ~/.bashrc


	# SSH keys and AWS stuffs.

	# Git config

	# Conda Env?
	# conda env create -f miniconda3.env.py-3.7.11.yaml

	# Golang stuff.

	# Pacman packages
	# tools/pacman_install.sh

	# Other packages? (nvidia driver stuffs)
	# These should probably be different targets
	
clean:
	echo Please impl me

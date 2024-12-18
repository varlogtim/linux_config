build:
	echo do something
	

install:
	mkdir -v ~/.config
    mkdir -v ~/bin
    mkdir -v ~/.vim
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	# Sym links
	ln -v -s $(PWD)/.bashrc ~/.bashrc
	ln -v -s $(PWD)/.xinitrc ~/.xinitrc
	ln -v -s $(PWD)/.Xresources ~/.Xresources
	ln -v -s $(PWD)/.vimrc ~/.vimrc
	ln -v -s $(PWD)/awesome ~/.config/awesome
	ln -v -s $(PWD)/chromium-flags.config ~/.config/chromium-flags.conf


    # SSH keys and AWS stuffs.

	# Git config
	
	# Conda Env?
    # conda env create -f miniconda3.env.py-3.7.11.yaml
	
    # Golang stuff.

	# Pacman packages
    # tools/pacman_install.sh
	
	# Other packages? (nvidia driver stuffs)
	# These should probably be different targets

	echo $(config_dir)
	echo $(PWD)
	
clean:
	echo Please impl me

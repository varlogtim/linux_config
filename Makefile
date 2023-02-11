build:
	echo do something
	

install:
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
	
	# Pacman packages
	
	# Other packages? (nvidia driver stuffs)
	# These should probably be different targets

	echo $(config_dir)
	echo $(PWD)
	
clean:
	echo Please impl me

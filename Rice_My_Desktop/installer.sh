#!/bin/bash

##
# Color  Variables
##
green='\e[32m'
blue='\e[34m'
clear='\e[0m'

##
# Color Functions
##

ColorGreen(){
	echo -ne $green$1$clear
}
ColorBlue(){
	echo -ne $blue$1$clear
}


banner () {
	echo "####################"
	echo "# $1 #"
	echo "####################"
}


##############################################################


bootstrap() {
	banner "-={ install everything }=-"
	install_deps
	create_dirs
	get_shell_themes
	get_custom_zsh_theme
	get_rust_lang
	get_configs_i3_picom
	install_i3blocks_contrib
	install_asdf_manager
	get_golang_install
	bash source $HOME/.zshrc
	install_golang_tools
	install_asdf_nodejs
	install_ruby_asdf
	
}

create_dirs() {
	banner "organize dirs"
	mkdir -p $HOME/.config/i3/
	mkdir -p $HOME/.config/picom/
	mkdir -p $HOME/.config/polybar/
	banner "done"
}


install_deps() {
	banner "install all deps"
	sudo apt install zsh coreutils terminator dirmngr gpg nmap wireshark gawk curl wget git zsh cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev  libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config xcb-proto libxcb-xrm-dev libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev libxcb-composite0-dev libjsoncpp-dev python3-pip python3-setuptools fzf rofi cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev libxcb-composite0-dev xcb libxcb-ewmh2 libpcap-dev i3 i3-wm i3blocks moka-icon-theme faba-icon-theme -y
	banner "done"
}

get_custom_zsh_theme() {
	wget https://raw.githubusercontent.com/rodpwn/dotfiles/main/Rice_My_Desktop/zsh/rodpwnzsh.zsh-theme
	mv rodpwnzsh.zsh-theme $HOME/.oh-my-zsh/themes
	rm -rf $HOME/.zshrc
	wget https://raw.githubusercontent.com/rodpwn/dotfiles/main/Rice_My_Desktop/zsh/zshrc
	mv zshrc .zshrc
	mv .zshrc $HOME
	bash source $HOME/.zshrc
	
}


install_ppas() {
	banner "install ppas"
	#sudo add-apt-repository ppa:mmstick76/alacritty
	sudo add-apt-repository ppa:kgilmer/speed-ricer
	sudo apt update -y; sudo apt upgrade -y
	sudo apt install alacritty
	banner "done"
}

install_golang_tools() {
	GO111MODULE=on go get -v github.com/projectdiscovery/naabu/v2/cmd/naabu
	GO111MODULE=on go get -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder
	GO111MODULE=on go get -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei
	GO111MODULE=on go get -v github.com/projectdiscovery/httpx/cmd/httpx
	go get -u github.com/tomnomnom/httprobe
	go get -u github.com/tomnomnom/assetfinder
	go get -u github.com/tomnomnom/meg
	go get -u github.com/tomnomnom/hacks/html-tool
	go get -u github.com/tomnomnom/gf
	go get -u github.com/gwen001/github-subdomains
	go install github.com/OJ/gobuster/v3@latest
	nuclei -update-templates
}

create_cypher_volume() {
	USER=$(whoami)
	cd /home/$USER
	ls -lha
	dd if=/dev/zero of=/home/$USER/crypt bs=1M count=30480
	sudo cryptsetup luksFormat /home/$USER/crypt
	sudo cryptsetup luksOpen /home/$USER/crypt temp

	echo "Creating a mount file system"
	sudo mkfs.ext4 -j /dev/mapper/temp
	sudo mkdir /media/files
	sudo mount /dev/mapper/temp /media/files
	sudo mkdir -p /media/files/temp
	sudo chown -R $USER:$USER /media/files/temp
}


install_polybar() {
	git clone https://github.com/jaagr/polybar.git
    cd polybar && ./build.sh
    cp /usr/share/doc/polybar/config ~/.config/polybar/config
}

install_i3blocks_contrib() {
	banner "install i3blocks"
	git clone https://github.com/vivien/i3blocks-contrib.git
    mv i3blocks-contrib i3blocks
	mv i3blocks $HOME/.config/i3/
	banner "done"	
}

perms_ssh() {
	chmod 700 ~/.ssh
	chmod 644 ~/.ssh/authorized_keys
	chmod 644 ~/.ssh/known_hosts
	chmod 644 ~/.ssh/config
	chmod 600 ~/.ssh/id_rsa
	chmod 644 ~/.ssh/id_rsa.pub
}

install_asdf_manager() {
	banner "install asdf"
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf

}

install_asdf_nodejs() {
	banner "install asdf"
	asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
	asdf install nodejs latest
	asdf global nodejs latest
	banner "done"
}

install_ruby_asdf() {
	banner "install ruby"
	asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
	asdf install ruby latest
	asdf global ruby latest
	banner "done"
}

get_configs_i3_picom() {
	banner "get picom and i3 config"
	wget https://raw.githubusercontent.com/rodpwn/dotfiles/main/Rice_My_Desktop/wm/i3/config
	mv config $HOME/.config/i3/

	wget https://raw.githubusercontent.com/rodpwn/dotfiles/main/Rice_My_Desktop/wm/i3/picom.conf
	mv picom.conf $HOME/.config/picom/
	banner "done"
}

get_shell_themes() {
	banner "install oh-my-zsh"
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	"done"
}

get_zsh_config() {
	banner "get .zshrc"
	rm -f $HOME/.zshrc
	https://raw.githubusercontent.com/rodpwn/dotfiles/main/Rice_My_Desktop/zsh/.zshrc
	mv .zshrc $HOME/
	banner "done"
}


get_rust_lang() {
	banner "install rust lang"
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	banner "done"
}

get_golang_install() {
	wget https://go.dev/dl/go1.17.5.linux-amd64.tar.gz
	sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.17.5.linux-amd64.tar.gz
}





#######################################################################################################################
menu() {


	echo -ne "
	        > Choose: 	
		$(ColorGreen '1)') BootStrap
		$(ColorGreen '2)') Cypher volume
		$(ColorGreen '3)') install picom 
		$(ColorGreen '4)') asdf
		$(ColorGreen '5)') install ZSH
		$(ColorGreen '6)') install Langs
		$(ColorGreen '0)') Exit
		$(ColorBlue 'Choose an option:') "
        	read a

        case $a in
	        1) bootstrap ; menu ;;
	        2) create_cypher_volume ; menu ;;
	        #3) picom ; menu ;;
	        #4) asdf ; menu ;;
	        #5) zsh ; menu ;;
		#6) langs ; menu ;;
		0) exit 0 ;;
		*) echo -e $red"Wrong option."$clear; WrongCommand;;
        esac
}


##########################################################################################################################

banner "rodpwn config"
banner "MENU"
menu

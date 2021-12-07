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

install_i3w() {
	banner "deps i3"
	sudo apt install i3 i3-gaps i3-wm i3blocks
	banner "done"
}

install_icon_themes() {  
	banner "install moka theme and faba themes"
	sudo apt install moka-icon-theme faba-icon-theme
	echo "done"
}

install_deps() {
	banner "install all deps"
	sudo apt install coreutils terminator dirmngr gpg nmap wireshark gawk curl wget git zsh cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev  libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python3-xcbgen xcb-proto libxcb-xrm-dev libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev libxcb-composite0-dev libjsoncpp-dev python3-pip python3-setuptools fzf rofi -y
	banner "done"
}


install_ppas() {
	banner "install ppas"
	sudo add-apt-repository ppa:mmstick76/alacritty
	sudo add-apt-repository ppa:kgilmer/speed-ricer
	sudo apt update -y; sudo apt upgrade -y
	sudo apt install alacritty
	banner "done"
}


install_i3blocks() {
	banner "install i3blocks"
	git clone https://github.com/vivien/i3blocks-contrib.git
    mv i3blocks-contrib i3blocks
	mv i3blocks $HOME/.config/i3/
	banner "done"	
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

organize_dirs() {
	banner "organize dirs"
	mkdir -p $HOME/.config/i3/
	mkdir -p $HOME/.config/picom/
	banner "done"
}


get_configs_i3_picom() {
	banner "get config i3"
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


i3() {
	
	banner "> installing i3 configs"
	install_ppas
	organize_dirs
	install_i3w
	install_i3blocks
	banner "done"
}

picom() {
	banner "> config picom and i3"
	get_configs_i3_picom
	banner "done"
	
}

asdf() {
	banner "> asdf"
	install_asdf_manager
	install_asdf_nodejs
	install_ruby_asdf
	banner "done"
}

zsh() {
	get_shell_themes
	get_zsh_config
	banner "done"
}

langs() {
	get_rust_lang
	banner "done"
}



#######################################################################################################################
menu() {


	echo -ne "
	        > Choose: 	
		$(ColorGreen '1)') Install all deps
		$(ColorGreen '2)') install i3
		$(ColorGreen '3)') install picom 
		$(ColorGreen '4)') asdf
		$(ColorGreen '5)') install ZSH
		$(ColorGreen '6)') install Langs
		$(ColorGreen '0)') Exit
		$(ColorBlue 'Choose an option:') "
        	read a

        case $a in
	        1) install_deps ; menu ;;
	        2) i3 ; menu ;;
	        3) picom ; menu ;;
	        4) asdf ; menu ;;
	        5) zsh ; menu ;;
		6) langs ; menu ;;
		0) exit 0 ;;
		*) echo -e $red"Wrong option."$clear; WrongCommand;;
        esac
}


##########################################################################################################################

banner "incogbyte config"
banner "MENU"
menu

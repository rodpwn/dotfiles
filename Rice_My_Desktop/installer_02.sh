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


install_packages_dependencies() {
    sudo apt update; sudo apt upgrade -y; sudo apt install curl wireshark git openvpn keepassx nmap zsh python3-setuptools gcc terminator gpg dirmngr gpg nmap wireshark gawk curl python3-pip python3-setuptools fzf cmake cmake-data build-essential git automake autoconf libreadline-dev libncurses-dev libssl-dev libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev unzip zlib1g-dev -y
}

set_gnome_i3_style () {

    gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys false
    # enable again  gsettings reset org.gnome.shell.extensions.dash-to-dock hot-keys
    gsettings set org.gnome.mutter dynamic-workspaces false
    gsettings set org.gnome.desktop.wm.preferences num-workspaces 8

    gsettings set org.gnome.shell.keybindings switch-to-application-1  []
    gsettings set org.gnome.shell.keybindings switch-to-application-2  []
    gsettings set org.gnome.shell.keybindings switch-to-application-3  []
    gsettings set org.gnome.shell.keybindings switch-to-application-4  []
    gsettings set org.gnome.shell.keybindings switch-to-application-5  []
    gsettings set org.gnome.shell.keybindings switch-to-application-6  []
    gsettings set org.gnome.shell.keybindings switch-to-application-7  []
    gsettings set org.gnome.shell.keybindings switch-to-application-8  []
    gsettings set org.gnome.shell.keybindings switch-to-application-9  []

    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1  "['<Super>1']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2  "['<Super>2']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3  "['<Super>3']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4  "['<Super>4']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5  "['<Super>5']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6  "['<Super>6']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7  "['<Super>7']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8  "['<Super>8']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9  "['<Super>9']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-10 "['<Super>0']"

    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1  "['<Super><Shift>1']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2  "['<Super><Shift>2']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3  "['<Super><Shift>3']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4  "['<Super><Shift>4']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5  "['<Super><Shift>5']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6  "['<Super><Shift>6']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-7  "['<Super><Shift>7']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-8  "['<Super><Shift>8']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-9  "['<Super><Shift>9']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-10 "['<Super><Shift>0']"
}

install_zsh () {
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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


get_rust_lang() {
	banner "install rust lang"
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	banner "done"
}

get_golang_install() {
	wget https://go.dev/dl/go1.17.5.linux-amd64.tar.gz
	sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.17.5.linux-amd64.tar.gz
	rm -f $HOME/go1.17.5.linux-amd64.tar.gz
}


install_all_deps() {
    banner "=-{ installing all deps before bootstrap }=-"
    install_packages_dependencies
    install_zsh
    menu
}

rice_my_desk () {
    get_custom_zsh_theme
}

bootstrap_languages () {
    install_asdf_manager
    install_asdf_nodejs
    install_ruby_asdf
    get_rust_lang
    get_golang_install
}


#######################################################################################################################
menu() {


	echo -ne "
	        > Choose: 	
		$(ColorGreen '1)') install all deps ( always first !)
		$(ColorGreen '2)') Rice Desktop :]
		$(ColorGreen '3)') install languages
		$(ColorGreen '4)') asdf
		$(ColorGreen '5)') install ZSH
		$(ColorGreen '6)') install Langs
		$(ColorGreen '0)') Exit
		$(ColorBlue 'Choose an option:') "
        	read a

        case $a in
	        1) install_all_deps ; menu ;;
	        2) rice_my_desk ; menu ;;
	        3) bootstrap_languages ; menu ;;
	        4) create_cypher_volume; menu ;;
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

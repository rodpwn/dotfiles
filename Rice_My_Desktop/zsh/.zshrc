# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh


ZSH_THEME="rodpwnzsh"

lugins=(git zsh-syntax-highlighting nmap web-search extract python ruby asdf gitfast colorize command-not-found cp)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

####################### exports ##########################
export TERM=xterm-256color
export EDITOR=/usr/bin/vim
export PATH=${PATH}:~/bin:~/.local/bin:~/etc/scripts.
export PATH=${PATH}:/usr/local/go/bin
export GOPATH=~
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME:$HOME
export PATH=$PATH:$GOPATH/bin
export PATH_TO_FX=/opt/openjfx/javafx-sdk-17.0.1/lib
#########################################################


######################## custom alias ##################
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias grep='grep --color=auto'
alias d="sudo docker"
alias biggest="du -h --max-depth=1 | sort -h"
alias :q="exit"
alias j="jobs"
alias burp_v1="java -jar $HOME/Documents/incogbyte/tools/burp_pro_jars/burpsuite_pro_v1.7.37.jar"
alias burp_v2="java -jar $HOME/Documents/incogbyte/tools/burp_pro_jars/burpsuite_pro_v2021.10.2.jar"
alias jadx="$HOME/Documents/rodpwn/tools/mobile/Android/jadx/bin/jadx-gui"
alias adb="$HOME/Android/Sdk/platform-tools/adb"
alias frida_start_android="adb \"/data/local/tmp/frida-server\""
alias keytool="/opt/jdk/jdk-11.0.6/bin/keytool"
alias jarsigner="/opt/jdk/jdk-11.0.6/bin/jarsigner"
alias dd="sudo docker "
alias frida_server_x86="adb shell su -c '/data/local/tmp/frida-server-14.2.5-android-x86'"
alias frida_server_arm="adb shell su -c '/data/local/tmp/frida-server'"
alias gf='$HOMEbin/gf'
alias remove_update='sudo apt update; sudo apt upgrade -y; sudo apt autoremove -y; sudo apt autoclean -y'
############################################################


###################### functions ###########################

#custom functions

log_cat_custom_app() {
        adb logcat | grep -F "`adb shell ps | grep $1  | tr -s [:space:] ' ' | cut -d' ' -f2`"
}


probed_subdomains() {
      cat $1 | httpx -silent -tls-probe -tls-grab -threads 100 -ports 80,443,8080,8081,9090,9091,4001,4000,3000,3001,8843,4444,4443,7777,8888,5000,5001,6000 -H "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36"
}



content_discover() {
        ffuf -mc all -c -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0" -u "$1/FUZZ" -w $HOME/Documents/incogbyte/tools/wordlists/SecLists/Discovery/Web-Content/common.txt -D -e js,php,bak,txt,html,zip,sql,old,gz,log,swp,yaml,yml,config,save,rsa,ppk -ac
}



s3list () {
    aws s3 ls s3://$1 --no-sign-request
}

sqlmap_req () {
        python3 $HOME/Documents/rodpwn/tools/web/exploitation/sqlmap/sqlmap.py --risk=3 --level=5 --random-agent --dbs -r $1
}



sqlmap_get () {
        python3 $HOME/Documents/rodpwn/tools/web/exploitation/sqlmap/sqlmap.py --risk=3 --level=5 --random-agent --dbs -u $1
}



ffufr () {
        echo "ffufr list.txt https://foo";

        ffuf -c -w $1 -u "$2/FUZZ" -recursion
}


ffufe () {
        echo "ffufe https://target.com list.txt php,asp,aspx";

        ffuf -u "$1/FUZZ" -w $2 -recursion -e $3
}


httpx_recon () {
        subfinder -d $1 -sources crtsh -silent | httpx -path /$2/ -status-code -content-length
}

dump_ipa () {
        python3 $HOME/Documents/rodpwn/tools/mobile/iOS/frida-ios-dump/dump.py -H $1 -p $2 $3
}

emails_grep() {
	grep -HnriE "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b" .
}

#############################################################



############### misc #################
. $HOME/.asdf/asdf.sh


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
########################################

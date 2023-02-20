# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

# common functions to inject mutiple files in the bashrc

function sourceRootFileIfExist {
	rootFile="$HOME$1"
	if isVariableSet "$rootFile"
	then
		sourceFile "$rootFile"
	else
		echo "no file name found please, please input a filename"
	fi
}

function sourceFile {
	fileName=$1
	if [ -e "$fileName" ]
	then
	    . "$fileName"
	else
	    echo "file does not exist, is everything correctly cloned? filename: $fileName"
	fi
}

function isVariableSet {
	 if [ -z ${1+x} ]
	 then 
		 # 1 = false, var is unset
		 return 1
	 else
		 # 0 = true, var is set
		 return 0
	 fi
}

#sourcing of files

sourceRootFileIfExist "/.bash_variable"
sourceRootFileIfExist "/.bash_alias"
sourceRootFileIfExist "/.bash_function"

export FLYCTL_INSTALL="/home/bram/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

[ -f "/home/bram/.ghcup/env" ] && source "/home/bram/.ghcup/env" # ghcup-env

alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


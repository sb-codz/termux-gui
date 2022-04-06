#!/bin/bash
## Author  : S.B. (sb-codz)
## Mail    : 
## Github  : sb-codz
# Varsion 0.0.1

## Termux Desktop Start : Setup GUI in Termux
## ANSI Colors (FG & BG)
RED="$(printf '\033[31m')"  GREEN="$(printf '\033[32m')"  ORANGE="$(printf '\033[33m')"  BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')"  CYAN="$(printf '\033[36m')"  WHITE="$(printf '\033[37m')" BLACK="$(printf '\033[30m')"
CHECK_MARK="\033[0;32m\xE2\x9C\x94\033[0m"


## Reset terminal colors
reset_color() {
	printf '\033[37m'
}
## Script Termination
exit_on_signal_SIGINT() {
    { printf "${RED}\n\n%s\n\n" "[!] Program Interrupted." 2>&1; reset_color; }
    exit 0
}
exit_on_signal_SIGTERM() {
    { printf "${RED}\n\n%s\n\n" "[!] Program Terminated." 2>&1; reset_color; }
    exit 0
}
trap exit_on_signal_SIGINT SIGINT
trap exit_on_signal_SIGTERM SIGTERM

DIR=$HOME/termux-gui/codz;

  ## vnc and xfce4 pkg
  _pkgs( xfce4 tigervnc xfce4-terminal xfce-theme-manager xfce4-appfinder xfce4-clipman-plugin xfce4-places-plugin xfce4-notes-plugin xfce4-goodies desktop-file-utils \  
  audacious leafpad pavucontrol-qt hexchat geany xarchiver thunar unzip otter-browser rofi gzip wget parole )
  setup_vnc_xfce_pkg() {
	echo -e ${RED}"\n[*] Installing Termux Desktop..."
	echo -e ${CYAN}"\n[*] Updating Termux Base... \n"
	{ reset_color; pkg autoclean; pkg upgrade -y; }
	echo -e ${CYAN}"\n[*] Enabling Termux X11-repo... \n"
	{ reset_color; pkg install -y x11-repo; }
	echo -e ${CYAN}"\n[*] Installing required programs... \n"
	for package in "${_pkgs[@]}"; do
		{ reset_color; pkg install -y "$package"; }
		_ipkg=$(pkg list-installed $package 2>/dev/null | tail -n 1)
		_checkpkg=${_ipkg%/*}
		if [[ "$_checkpkg" == "$package" ]]; then
			echo -e ${GREEN}"\n[*] Package $package installed successfully.\n"
			continue
		else
			echo -e ${MAGENTA}"\n[!] Error installing $package, Terminating...\n"
			{ reset_color; exit 1; }
		fi
	done
	reset_color
}
  
  vnc_setup() {
  # Desktop environment
  #(~/.vnc/xstartup)
  # xfce4-session &
  # Vncserver Setup
  vncserver
  sleep 1
  killall Xvnc
  rm -rf $HOME/.vnc/localhost:1.pid
  rm -rf $PREFIX/tmp/.X1-lock
  rm -rf $PREFIX/tmp/.X11-unix/X1;
  clear
  }
  #Extanal
  setup_data() {
  termux-setup-storage
  echo "Backup Config data..."
  rm -rf $HOME/.backup
  mkdir $HOME/.backup
  cp $HOME/.config $HOME/.backup
  cp $HOME/.vnc $HOME/.backup
  cd $HOME
  sleep 1
	#  Remove HOME Folders
  echo "Remove data..."
	rm -rf $HOME/.local
	rm -rf $HOME/.themes
	rm -rf $HOME/.icons
	# rm -rf $HOME/.vnc
	sleep 1
	# Remove Bin Files & Folders
  echo "Remove data..."
	rm $PREFIX/bin/desktop
	#rm $PREFIX/bin/vnc-config
	#rm $PREFIX/bin/vnc-autostart-config
	sleep 1
	# Coppy Folders & files
  DIR=$HOME/termux-gui/codz
	echo "Coppy data..."
	echo "$HOME/termux-gui/codz/desk.sh" > $PREFIX/bin/desktop
  sleep 1
  # Make folders
  echo "Make Folders data..."
	mkdir $HOME/Desktop
	mkdir $HOME/Downloads
	mkdir $HOME/Templates
	mkdir $HOME/Public
	mkdir $HOME/Documents
	mkdir $HOME/Video
	mkdir $HOME/.local
	mkdir $HOME/.themes
	mkdir $HOME/.icons
	sleep 1
	#link folder 
	echo "Link storage data..."
  ln -s $HOME/storage/music Music
  sleep 1
  }
  # Permission
  x_permission() {
  echo "Enable Permission data..."
  chmod +x $PREFIX/bin/desktop
  chmod +x $HOME/termux-gui/codz/desk.sh
	chmod +x ~/.vnc/xstartup
	}
	post_msg () {
	echo "Install Is Done. :) \n NOTE\: Dont Remove \" termux-gui\" Folders and Files. \n To Start Desktop Write Comand \" desktop \" Then Hit Entet And Input Options"
	}
	## Install Termux Desktop
install_tg() {
	setup_vnc_xfce_pkg
	vnc_setup
	setup_data
	x_permission
	post_msg
}

## Uninstall Termux Desktop
uninstall_td() {
	# remove pkgs
	echo -e ${RED}"\n[*] Unistalling Termux Desktop..."
	echo -e ${CYAN}"\n[*] Removing Packages..."
	for package in "${_pkgs[@]}"; do
		echo -e ${GREEN}"\n[*] Removing Packages ${ORANGE}$package \n"
		{ reset_color; apt-get remove -y --purge --autoremove $package; }
	done
	echo -e ${RED}"\n[*] Termux Desktop Unistalled Successfully.\n"
}

## Main
if [[ "$1" == "--install" ]]; then
	install_tg
elif [[ "$1" == "--uninstall" ]]; then
	uninstall_tg
else
	{ usage; reset_color; exit 0; }
fi

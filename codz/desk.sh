#!/bin/bash
## Author  : S.B. (sb-codz)
## Mail    : 
## Github  : sb-codz

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

DIR=$HOME/termux_gui/codz;
# [ -e $FSTART ] && echo "$FSTART exist." || echo "$FSTART does not exist."
## 
vnc_start() {
  echo -e ${ORANGE}"
  \\n${CHECK_MARK} Starting....."; 
  echo ${WHITE}""
  vncserver
  #vncserver -listen tcp 
	#vncserver -list
	#termux-open vnc://127.0.0.1:5901
}
## 
vnc_stop () {
  echo -e ${ORANGE}"\\n${CHECK_MARK} Killing....."; 
  killall Xvnc
  rm -rf $HOME/.vnc/localhost:1.pid
  rm -rf $PREFIX/tmp/.X1-lock
  rm -rf $PREFIX/tmp/.X11-unix/X1;
  echo -e ${RED}"\\n${CHECK_MARK} Killd....."; 
}
## 
vnc_rest() { 
# Export Display		
export DISPLAY=":1"		
	if [[ $(pidof Xvnc) ]]; then	
	echo -e ${GREEN}"\\n${CHECK_MARK} Server Running"
	{ vncserver -list; echo; }	
	sleep 1
	vnc_stop
	echo;
	clear
	sleep 1
	vnc_start
	sleep 1
	echo -e ${GREEN}"\\n${CHECK_MARK} VNC Server Restarting Done";
	else echo -e "Termux GUI Desktop Not Running!"; 
	fi

}


## 
vnc_on_of() {
 echo ${GREEN}" Enter 1 To Start Desktop"
 echo ${GREEN}" Enter 2 To Stop Desktop"
 echo ${GREEN}" Enter 3 To Restart Desktop"
 echo ${GREEN}" Enter 0 To Cancel"
 echo "
 "
read -p "Enter: " input_no
##################
if (($input_no  == 1)); then
  echo -e ${GREEN}" Please Wait......"
  sleep 1
  
  ############################
  vnc_start
  echo -e ${GREEN}" ${CHECK_MARK} Done."
  echo -e ${GREEN}" "
elif (($input_no  == 2)); then
  echo -e ${GREEN}" Please Wait......"
  sleep 1
  vnc_stop
  
  ########################
elif (($input_no  == 3)); then
  echo -e ${GREEN}" \e Please Wait......"
  sleep 1
  vnc_rest
else (($input_no  == 0));
clear

echo ${CYAN}"Cancel";
fi
}
############################################
clear
cd $HOME
vnc_on_of




cd $HOME

##   echo "$HOME/desk.sh" > $PREFIX/bin/desk chmod +x $PREFIX/bin/desk

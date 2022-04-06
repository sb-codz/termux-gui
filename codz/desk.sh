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
  # Export Display		
  clear
  export DISPLAY=":1"		
  if [[ $(pidof Xvnc) ]]; then	
  echo -e "${CHECK_MARK} ${RED} Desktop Is Allredy Running";
    { vncserver -list; echo; }	
  else
  echo -e "${CHECK_MARK} ${ORANGE} Starting....."; 
  vncserver
  fi
}
## 
vnc_stop () {
  clear
    if [[ $(pidof Xvnc) ]]; then	
  { vncserver -list; echo; }
  echo -e "${CHECK_MARK} ${ORANGE}  Killing....."; 
  killall Xvnc
  rm -rf $HOME/.vnc/localhost:1.pid
  rm -rf $PREFIX/tmp/.X1-lock
  rm -rf $PREFIX/tmp/.X11-unix/X1;
  echo -e "${CHECK_MARK} ${RED}  Killd.....";
  else
  echo -e "${CHECK_MARK} ${RED} Termux GUI Desktop Not Running";
  fi
}
## 
vnc_rest() { 
	if [[ $(pidof Xvnc) ]]; then	
	echo -e "${CHECK_MARK} ${GREEN}  Server Running"
	{ vncserver -list; echo; }	
	sleep 1
	vnc_stop
	sleep 1
	echo;
	sleep 1
	vnc_start
	sleep 1
	echo -e "${CHECK_MARK}${GREEN}  VNC Server Restarting Done";
	else echo -e "${CHECK_MARK} ${ORANGE} Termux GUI Desktop Not Running!"; 
	fi

}


## 
vnc_on_of() {
  	{ vncserver -list; echo; }	
 echo "${GREEN} Enter 1 To Start Desktop"
 echo "${GREEN} Enter 2 To Stop Desktop"
 echo "${GREEN} Enter 3 To Restart Desktop"
 echo "${GREEN} Enter 0 To Cancel"
 echo "
 "
read -p " Enter: " input_no
  ############################
if (($input_no  == 1)); then
  echo -e "${CHECK_MARK} ${GREEN} Please Wait......"
  sleep 1
  vnc_start
  ############################
elif (($input_no  == 2)); then
  echo -e "${CHECK_MARK} ${GREEN} Please Wait......"
  sleep 1
  vnc_stop
  sleep 1
  ############################
elif (($input_no  == 3)); then
  echo -e "${CHECK_MARK} ${GREEN} Please Wait......"
  sleep 1
  vnc_rest
  sleep 1
else (($input_no  == 0));
clear

echo "${CHECK_MARK} ${CYAN}   Canceld";
fi
}
############################################
clear
cd $HOME

vnc_on_of
cd $HOME


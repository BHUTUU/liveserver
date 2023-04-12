#!/usr/bin/bash
CWD="`pwd`"
OS="`uname -o`"
if [[ ${OS,,} == *'linux'* ]]; then
  export PREFIX="/usr"
fi
#<<<=====Colors====>>>#
S0="\033[1;30m" B0="\033[1;40m"
S1="\033[1;31m" B1="\033[1;41m"
S2="\033[1;32m" B2="\033[1;42m"
S3="\033[1;33m" B3="\033[1;43m"
S4="\033[1;34m" B4="\033[1;44m"
S5="\033[1;35m" B5="\033[1;45m"
S6="\033[1;36m" B6="\033[1;46m"
S7="\033[1;37m" B7="\033[1;47m"
R0="\033[00m"   R1="\033[1;00m"
#<---x--->#
function intteruption() {
  if [[ ${OS,,} == *'android'* ]]; then
    rm -rf $PREFIX/bin/hostit >/dev/null 2>&1
    rm -rf $PREFIX/bin/liveserver >/dev/null 2>&1
  else
    sudo rm -rf /usr/bin/hostit >/dev/null 2>&1
    sudo rm -rf /usr/share/liveserver >/dev/null 2>&1
  fi
  printf "\033[2A\r${S2}[${S1}!${S2}]${S4} Installation intterupted!${S2} Cleaning up....${R0}\n"
}
function Android() {
  if [[ ${OS,,} == *'android'* ]]; then
    rm -rf $PREFIX/bin/hostit &>/dev/null
    rm -rf $PREFIX/share/liveserver &>/dev/null
    if [ -f $CWD/assets/hostit ]; then
      cp -r $CWD/assets/hostit $PREFIX/bin &>/dev/null
    else
      wget "https://raw.githubusercontent.com/BHUTUU/liveserver/main/assets/hostit"
      cp -r $CWD/assets/hostit $PREFIX/bin &>/dev/null
    fi
    chmod +x $PREFIX/bin/hostit
  fi
}
function Linux() {
  if [[ ${OS,,} == *'linux'* ]]; then
    sudo rm -rf /usr/bin/hostit &>/dev/null
    sudo rm -rf /usr/share/liveserver &>/dev/null
    if [ -f $CWD/assets/hostit ]; then
      sudo cp -r $CWD/assets/hostit /usr/bin &>/dev/null
      cp -r $CWD/assets/hostit /usr/bin &>/dev/null
    else
      wget "https://raw.githubusercontent.com/BHUTUU/liveserver/main/assets/hostit"
      sudo cp -r $CWD/assets/hostit /usr/bin/hostit &>/dev/null
      cp -r $CWD/assets/hostit /usr/bin/hostit &>/dev/null
    fi
    chmod +x /usr/bin/hostit
  fi
}
function Windows() {
  if [[ ${OS,,} == 'msys' ]]; then
    cd /c/Program\ Files/Git/usr/bin >/dev/null 2>&1
    rm -rf hostit >/dev/null 2>&1
    cd ../share
    rm -rf liveserver >/dev/null 2>&1
    cd $CWD
    if [ -f $CWD/assets/hostit ]; then
      cp -r $CWD/assets/hostit /c/Program\ Files/Git/usr/bin/ >/dev/null 2>&1
    else
      wget "https://raw.githubusercontent.com/BHUTUU/liveserver/main/assets/hostit" >/dev/null 2>&1
      cp -r hostit /c/Program\ Files/Git/usr/bin >/dev/null 2>&1
    fi
  fi
  chmod +x /c/Prorgram\ Files/Git/usr/bin/hostit >/dev/null 2>&1
}
function Install() {
  if hash hostit &>/dev/null; then
    preversion="`cat $PREFIX/bin/hostit |grep version: | awk '{print $3}'`"
    wevVersion=$(curl -fsSL "https://raw.githubusercontent.com/BHUTUU/liveserver/main/assets/hostit" | grep version: | awk '{print $3}')
    if [ ! -z $preversion ]; then
      printf "${S2}[${S1}*${S2}]${S4} liveserver is already installed in your system${R0}\n"
      printf "${S2}[${S1}+${S2}]${S4} checking for updates${R0}\n"; sleep 2
      if [[ "${preversion}" == "${wevVersion}" ]]; then
        printf "${S2}[${S1}✓${S2}]${S4} Current version is latest${R0}\n"
      else
        printf "${S2}[${S1}!${S2}]${S7} Update available!Run ${S1}'${S4}hostit -u${S1}'${S7} to update!!${R0}\n"
        exit 0
      fi
    fi
  else
    if [[ ${OS,,} == *'android'* ]]; then
      Android
    elif [[ ${OS,,} == *'linux'* ]]; then
      Linux
    elif [[ ${OS,,} == 'msys' ]]; then
      Windows
    else
      printf "${S2}[${S1}!${S2}]${S4} Unsupported Operating System!!${R0}\n"
    fi
  fi
}
Install

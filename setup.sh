#!/data/data/com.termux/files/usr/bin/bash
#DIST=$(uname -m)
#if [[ $DIST != 'aarch64' ]]; then
#printf "\e[32m[\e[31m!\e[32m]\e[31mSorry, but your system is not compatible!!\e[0m\n"
#exit 1
#fi
printf "\e[32mInstalling requirements\e[0m\n"
if ! hash php > /dev/null 2>&1; then
apt install php -y > /dev/null 2>&1
exit 1
fi
printf "\e[33mConfiguring.....\e[0m\n"
cp -r assets/hostit $PREFIX/bin/ > /dev/null 2>&1
echo
printf "\e[32m Just run '\e[41mhostit\e[00m\e[32m' to start the server\e[0m\n"


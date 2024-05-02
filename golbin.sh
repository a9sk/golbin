#!/bin/bash

# install nmap if not already present
nmap_installer(){
    if ! command -v nmap &> /dev/null
    then
        read -p "$(echo -e '[?] Nmap not installed, do you want to install it?'$i' (y/n) ')" ok
		if [[ $ok == "" ]]
		then
			sudo apt-get update
            sudo apt-get install nmap
		else
			case $ok in
				y|Y|yes|Yes|YES)	sudo apt-get update; sudo apt-get install nmap;;
				n|N|no|No|NO)		echo "[*] Nmap is needed" ; echo "[!] Exiting" ; exit ;;
			esac
		fi
    else
        read -p "$(echo -e '[?] Nmap is installed, do you want to update it?'$i' (y/n) ')" up
		if [[ $up == "" ]]
		then
			sudo apt-get update
            sudo apt-get upgrade nmap
		else
			case $up in
				y|Y|yes|Yes|YES)	sudo apt-get update; sudo apt-get upgrade nmap;;
				n|N|no|No|NO)		echo "[!] Might have some problems with old nmap versions" ; sleep 1; echo "[*] Moving on then" ; sleep 1;;
			esac
		fi
    fi
}

seclist_installer(){
    if [ -d "SecLists-master" ]
    then
        echo '[!] SecList already installed'
        sleep 1
        echo '[*] Continue...'
    else
        read -p "$(echo -e '[?] SecList not installed or in a different path, do you want to install it here? (Will take a few minutes, if already installed move it here)'$i' (y/n) ')" ok
		if [[ $ok == "" ]]
		then
			wget -c https://github.com/danielmiessler/SecLists/archive/master.zip -O SecList.zip
            unzip SecList.zip
            rm -f SecList.zip
		else
			case $ok in
				y|Y|yes|Yes|YES)    wget -c https://github.com/danielmiessler/SecLists/archive/master.zip -O SecList.zip; echo '[*] Install unzip to continue'; sudo apt install unzip; echo '[*] Unzipping the whole SecList.zip (might take a few minutes)'; unzip SecList.zip; rm -f SecList.zip ;;
				n|N|no|No|NO)		echo "[*] SecList is needed" ; sleep 1; echo "[!] Exiting" ; sleep 1; exit ;;
			esac
		fi
    fi
}

main() {
    clear
    sleep 1
    echo "    **********************************************"
    echo "    ******             GolBin               ******"
    echo "    **********************************************"
    echo "      "
    echo "      "
    echo "    Golbin v1.0.0 @a9sk"
    echo "      "
    echo "      "
    sleep 1
    nmap_installer
    sleep 1
    clear
    sleep 1
    seclist_installer

}

main

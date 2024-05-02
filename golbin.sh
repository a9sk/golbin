#!/bin/bash

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

    if ! command -v nmap &> /dev/null
    then 
        echo "[!] There was a problem with the nmap installation."
        sleep 1
        echo "[!] Quitting... "
        exit
    else
        echo "[*] Nmap is present"
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

    if [ -d "SecLists-master" ]
    then
        echo "[*] SecList is present"
    else  
        echo "[!] There was a problem with the SecList installation."
        sleep 1
        echo "[!] Quitting... "
        exit
    fi
}

gobuster_installer(){
    if ! command -v gobuster &> /dev/null
    then
        read -p "$(echo -e '[?] Gobuster not installed, do you want to install it? (Might take a few minutes)'$i' (y/n) ')" ok
		if [[ $ok == "" ]]
		then
			sudo apt-get install gobuster
		else
			case $ok in
				y|Y|yes|Yes|YES)    echo '[*] Installing Gobuster, might take some time'; sudo apt-get install gobuster ;;
				n|N|no|No|NO)		echo "[*] Gobuster is needed" ; sleep 1; echo "[!] Exiting" ; sleep 1; exit ;;
			esac
		fi  
    else
        read -p "$(echo -e '[?] Gobuster is installed, do you want to update it?'$i' (y/n) ')" up
		if [[ $up == "" ]]
		then
            sudo apt install gobuster
		else
			case $up in
				y|Y|yes|Yes|YES)	sudo apt-get update; sudo apt install gobuster;;
				n|N|no|No|NO)		echo "[!] Might have some problems with old Gobuster versions" ; sleep 1; echo "[*] Moving on then" ; sleep 1;;
			esac
		fi
    fi

    if ! command -v gobuster &> /dev/null
    then 
        echo "[!] There was a problem with the Gobuster installation."
        sleep 1
        echo "[!] Quitting... "
        exit
    else
        echo "[*] Gobuster is present"
    fi
}

main() {
    clear
    sleep 1
    echo "                                                    ,      ,         ";
    echo "                                                   /(.-\"\"-.)\        ";
    echo "                                               |\  \/      \/  /|    ";
    echo "                .__ ___.   .__                 | \ / =.  .= \ / |    ";
    echo "    ____   ____ |  |\_ |__ |__| ____           \( \   o\/o   / )/    ";
    echo "   / ___\ /  _ \|  | | __ \|  |/    \           \_, '-/  \-' ,_/     ";
    echo "  / /_/  >  <_> )  |_| \_\ \  |   |  \            /   \__/   \       ";
    echo "  \___  / \____/|____/___  /__|___|  /            \ \__/\__/ /       ";
    echo " /_____/                 \/        \/           ___\ \|--|/ /___     ";
    echo -e "                                              /\`    \\      /    \`\   ";
    echo "                                             /       '----'       \  ";
    echo "      "
    echo "      "
    echo "    Golbin v1.0.0 @a9sk"
    echo "      "
    echo "      "
    sleep 1
    nmap_installer
    sleep 1
    seclist_installer
    sleep 1
    gobuster_installer

}

main

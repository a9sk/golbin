#!/bin/bash

banner(){
    sleep 0.1
    echo "                                                    ,      ,         ";
    sleep 0.1
    echo "                                                   /(.-\"\"-.)\        ";
    sleep 0.1
    echo "                                               |\  \/      \/  /|    ";
    sleep 0.1
    echo "                .__ ___.   .__                 | \ / =.  .= \ / |    ";
    sleep 0.1
    echo "    ____   ____ |  |\_ |__ |__| ____           \( \   o\/o   / )/    ";
    sleep 0.1
    echo "   / ___\ /  _ \|  | | __ \|  |/    \           \_, '-/  \-' ,_/     ";
    sleep 0.1
    echo "  / /_/  >  <_> )  |_| \_\ \  |   |  \            /   \__/   \       ";
    sleep 0.1
    echo "  \___  / \____/|____/___  /__|___|  /            \ \__/\__/ /       ";
    sleep 0.1
    echo " /_____/                 \/        \/           ___\ \|--|/ /___     ";
    sleep 0.1
    echo -e "                                              /\`    \\      /    \`\   ";
    sleep 0.1
    echo "                                             /       '----'       \  ";
    sleep 0.3
    echo "      "
    echo "      "
    echo "    Golbin v1.0.0 @a9sk"
    echo "      "
    echo "      "
    sleep 1
}
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
                *)                  echo "[*] Invalid input" ; echo "[!] Exiting" ; exit ;;
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
				n|N|no|No|NO|*)		echo "[!] Might have some problems with old nmap versions" ; sleep 1; echo "[*] Moving on then" ; sleep 1;;
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
    SCRIPT_PATH="$(dirname "$(realpath "$0")")"
    pwd
    if [ -d "$SCRIPT_PATH/SecLists-master" ]
    then
        echo '[!] SecList already installed'
        sleep 1
        echo '[*] Continue...'
    else
        read -p "$(echo -e '[?] SecList not installed or in a different path, do you want to install it here? (Will take a few minutes, if already installed move it here)'$i' (y/n) ')" ok
		if [[ $ok == "" ]]
		then
			wget -c https://github.com/danielmiessler/SecLists/archive/master.zip -O SecList.zip
            unzip "$SCRIPT_PATH/SecList.zip" -d "$SCRIPT_PATH"
            rm -f "$SCRIPT_PATH/SecList.zip"
		else
			case $ok in
				y|Y|yes|Yes|YES)    wget -c https://github.com/danielmiessler/SecLists/archive/master.zip -O SecList.zip; echo '[*] Install unzip to continue'; sudo apt install unzip; echo '[*] Unzipping the whole SecList.zip (might take a few minutes)'; unzip "$SCRIPT_PATH/SecList.zip"  -d "$SCRIPT_PATH"; rm -f "$SCRIPT_PATH/SecList.zip" ;;
				n|N|no|No|NO)		echo "[*] SecList is needed" ; sleep 1; echo "[!] Exiting" ; sleep 1; exit ;;
                *)                  echo "[*] Invalid input entered" ; sleep 1; echo "[!] Exiting" ; sleep 1; exit ;;
			esac
		fi
    fi

    if [ -d "$SCRIPT_PATH/SecLists-master" ]
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
                *)                  echo "[*] Invalid input entered" ; sleep 1; echo "[!] Exiting" ; sleep 1; exit ;;
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
				n|N|no|No|NO|*)		echo "[!] Might have some problems with old Gobuster versions" ; sleep 1; echo "[*] Moving on then" ; sleep 1;;
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

help(){
    sleep 0.1
    echo " ";
    echo "Golbin 1.0.0 (Git v1.0.0 packaged as 1.0.0-1)                            ";
    echo "@a9sk                                                                    ";
    echo "See https://github.com/a9sk/golbin for more information.                 ";
    echo "                                                                         ";
    echo "Usage: golbin                                                            ";
    echo "                                                                         ";
    echo "                                                                         ";
    echo "Miscellaneous:                                                           ";
    echo "        h, help                 display this help and ask for new input  ";
    echo "        e, exit                 exit from the program                    ";
    echo " ";
    sleep 0.1
}

main() {
    clear
    banner
    SCRIPT_PATH="$(dirname "$(realpath "$0")")"
    if command -v nmap &> /dev/null && [ -d "$SCRIPT_PATH/SecLists-master" ] && command -v gobuster &> /dev/null
    then
        echo " "
        echo '[*] Ok, lets start, enter help (h) to see what actions you can perform'
        echo " "
    else
        echo " "
        echo "[!] Looks like you are missing something, lets check"
        sleep 1
        nmap_installer
        sleep 1
        seclist_installer
        sleep 1
        gobuster_installer
    fi
    
    while true; do
        sleep 0.1
        read -p "</> " input
        case $input in
            help|h|-h|--help|H|HELP|-H|--HELP) help ;;
            exit|e|-e|--exit|E|EXIT|-E|--EXIT|ex) exit ;;
            *)      echo " "; echo "[!] Invalid command entered, enter help to see valid inputs." ;;
        esac
        sleep 0.1
    done
}

main

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
				y|Y|yes|Yes|YES)	sudo apt-get update; sudo apt-get install nmap; echo "Nmap was installed with success." ;;
				n|N|no|No|NO)		echo "[*] Moving on then" ; echo "[!] Exiting" ; exit ;;
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
				n|N|no|No|NO)		echo "[*] Moving on then" ; echo "[!] Exiting" ; exit ;;
			esac
		fi
    fi
}

main() {
    clear
    
    echo "    **********************************************"
    echo "    ******             GolBin               ******"
    echo "    **********************************************"
    echo "      "
    echo "      "
    echo "    Golbin v1.0.0 @a9sk"
    echo "      "
    echo "      "

    nmap_installer

}

main

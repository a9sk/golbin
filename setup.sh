#!/bin/bash

THIS_SCRIPT_PATH="$(dirname "$(realpath "$0")")"

GOLBIN_PATH="$THIS_SCRIPT_PATH/golbin.sh"

if [ -e "$GOLBIN_PATH" ]; then
    echo "[*] Starting the setup process"
else
    echo "[!] You are running this file from the wrong directory"
    sleep 1
    echo "[!] Make sure to run this file from the directory where is present the file golbin.sh"
    sleep 1
    echo "[!] Exiting..."
    exit
fi


SCRIPT_PATH="$PWD"
SCRIPT_SAVE="/usr/local/bin/golbin"
sleep 1

echo "[*] Verify if the file golbin.sh is runnable"
sleep 1
chmod +x "$GOLBIN_PATH" || {
    echo "[!] Impossible to set golbin.sh as unnable"
    echo '[!] In case of any problem contact @a9sk at 920a9sk765@proton.me'
    sleep 1
    echo "[!] Exiting..."
    exit 1
}

echo "[*] Creating an alias for the golbin.sh script"
alias golbin="$GOLBIN_PATH" >> ~/.bashrc  || {
    echo "[!] Impossible to create the alias"
    echo '[!] In case of any problem contact @a9sk at 920a9sk765@proton.me'
    sleep 1
    echo "[!] Exiting..."
    exit 1
}

# Crea un collegamento simbolico per golbin.sh
echo "[*] Creating a symlink for the golbin.sh script"
ln -s "$GOLBIN_PATH" "$SCRIPT_SAVE" || {
    echo "[!] Impossible to create the symlink"
    echo '[!] In case of any problem contact @a9sk at 920a9sk765@proton.me'
    sleep 1
    echo "[!] Exiting..."
    exit 1
}
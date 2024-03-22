#!/bin/bash

# Check if exactly two arguments are given (file name and command)
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <command> <file>"
    echo "Command can be either 'encrypt' or 'decrypt'."
    exit 1
fi

COMMAND=$1
FILE=$2

# Prompt for the password
echo "Enter password: "
read -s PASSWORD

# Perform encryption or decryption based on the command
case $COMMAND in
encrypt)
    openssl enc -aes-256-cbc -pbkdf2 -salt -in "$FILE" -out "${FILE}.enc" -base64 -pass pass:"$PASSWORD"
    if [ $? -eq 0 ]; then
        echo "File encrypted successfully: ${FILE}.enc"
    else
        echo "Encryption failed."
    fi
    ;;
decrypt)
    openssl enc -aes-256-cbc -pbkdf2 -salt -d -in "$FILE" -out "${FILE%.*}.dec" -base64 -pass pass:"$PASSWORD"
    if [ $? -eq 0 ]; then
        echo "File decrypted successfully: ${FILE%.*}.dec"
    else
        echo "Decryption failed."
    fi
    ;;
*)
    echo "Invalid command. Use 'encrypt' or 'decrypt'."
    exit 1
    ;;
esac

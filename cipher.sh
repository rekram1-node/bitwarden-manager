#!/bin/bash

# Check if at least two arguments are provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 {encrypt|decrypt|encrypt-num|decrypt-num} value"
    exit 1
fi

command=$1
value=$2

case $command in
encrypt)
    echo -n $value | tr '[A-Za-z]' '[N-ZA-Mn-za-m]' | base64
    ;;
decrypt)
    echo -n $value | base64 --decode | tr '[A-Za-z]' '[N-ZA-Mn-za-m]'
    ;;
*)
    echo "Invalid command. Please use 'encrypt' or 'decrypt'."
    exit 2
    ;;
esac

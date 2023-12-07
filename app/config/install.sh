#!/usr/bin/env bash

if [ $# == 0 ]; then
    exit 3
fi

APP_DIR=$(pwd)

if [[ -f "$APP_DIR/.bash_cli" ]]; then
    APP_DIR=$(dirname "$APP_DIR")
fi

if [[ ! -f "$APP_DIR/app/.bash_cli" ]]; then
    >&2 echo -e "\033[31mYou are not within a Bash CLI project\033[39m"
    >&2 echo "Please change your directory to a valid project or run the init command to set one up."
    exit 1
fi

NAME="$1"
FOLDER="${2-"/usr/local/bin"}"

sudo rm -rf /usr/local/bin/dev.sample       
sudo ln -s "$APP_DIR/cli" "$FOLDER/$NAME"
sudo mkdir -p /etc/bash_completion.d/
sudo chown $USER /etc/bash_completion.d/.
sudo echo  "source "$APP_DIR/complete"" >> "/etc/bash_completion.d/$NAME"
sudo echo  "complete -F _bash_cli $NAME" >> "/etc/bash_completion.d/$NAME"

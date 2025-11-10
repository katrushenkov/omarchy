#!/bin/bash

sudo chsh -s /usr/bin/zsh $USER

# zsh history
sudo -u "$name" mkdir -p "/home/$name/.cache/zsh/"


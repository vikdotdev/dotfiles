#!/bin/bash

mkdir -p /home/$USER/yaytemp
cd home/$USER/yaytemp

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

echo "Finished. Deleting temp folder"

cd /home/$USER/
rm -rf yaytemp

echo DONE

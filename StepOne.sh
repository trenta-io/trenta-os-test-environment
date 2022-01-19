#!/bin/bash
# Trenta OS Environment Setup for Ubuntu 18.04, Part I of II
# Written by @KevDoy
# Thank you to Kenny, Srihari and many others

echo "Let's get started"
read -p "Press [Enter] to add Trenta OS components"
# Add PPAs
sudo add-apt-repository ppa:trenta.io/os
sudo apt-get update

# Install Curl, Trenta Boot Screen, Trenta Icons, Rainier Theme, Gnome Shell Extensions, 
sudo apt install  -y \
  curl \
  trenta-bootscreen \
  trenta-icons \
  rainier-theme \
  gnome-shell-extensions \
  trenta-wallpapers

# Uninstall Ubuntu UI extensions
sudo apt-get remove -y \
  gnome-shell-extension-ubuntu-dock

# Set Trenta Icons, Shell, GTK Themes, Gnome Extensions
gsettings set org.gnome.desktop.interface icon-theme 'Trenta'
gsettings set org.gnome.desktop.interface gtk-theme "Rainier"
gsettings set org.gnome.desktop.wm.preferences theme "Rainier"
gnome-shell-extension-tool -e user-theme@gnome-shell-extensions.gcampax.github.com
gsettings set org.gnome.shell.extensions.user-theme name "Rainier"
gsettings set org.gnome.shell enable-hot-corners true

# Remove Amazon App
sudo rm /usr/share/applications/ubuntu-amazon-default.desktop
sudo rm /usr/share/unity-webapps/userscripts/unity-webapps-amazon/Amazon.user.js
sudo rm /usr/share/unity-webapps/userscripts/unity-webapps-amazon/manifest.json

# Remove & Replace Snaps
sudo snap remove canonical-livepatch # BUG!!! error "not installed"
sudo snap remove gnome-characters && sudo apt install gnome-characters
sudo snap remove gnome-logs && sudo apt install gnome-logs
sudo snap remove gnome-calculator && sudo apt install gnome-calculator
sudo snap remove gnome-system-monitor && sudo apt install gnome-system-monitor
sudo apt remove firefox

# Install Apps
sudo apt install -y \
  gpick \
  plank \
  epiphany-browser \
  gnome-games-app \
  gnome-maps

# Set Window Button Position
gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:'

# Remove Ubuntu Wallpaper
sudo rm -r /usr/share/backgrounds

# Add Trenta Wallpaper Files
sudo cp -r /home/user/2020/backgrounds /usr/share/
gsettings set org.gnome.desktop.screensaver picture-uri file:///usr/share/backgrounds/mountains-blur.jpg
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/mountains.jpg

# Install More Gnome Extensions
mkdir ~/.local/share/gnome-shell/extensions #Testing to see if this fixes it
cp -r /home/user/2020/extensions/appfolders-manager@maestroschan.fr ~/.local/share/gnome-shell/extensions/
cp -r /home/user/2020/extensions/hide-activities-button@gnome-shell-extensions.bookmarkd.xyz ~/.local/share/gnome-shell/extensions/
cp -r /home/user/2020/extensions/hide-dash@xenatt.github.com ~/.local/share/gnome-shell/extensions/
cp -r /home/user/2020/extensions/nohotcorner@azuri.free.fr ~/.local/share/gnome-shell/extensions/
cp -r /home/user/2020/extensions/showapplications@apps.com ~/.local/share/gnome-shell/extensions/

# Activate Gnome Extensions
gnome-shell-extension-tool -e appfolders-manager@maestroschan.fr
gnome-shell-extension-tool -e hide-activities-button@gnome-shell-extensions.bookmarkd.xyz
gnome-shell-extension-tool -e hide-dash@xenatt.github.com
gnome-shell-extension-tool -e nohotcorner@azuri.free.fr
gnome-shell-extension-tool -e showapplications@apps.com

# Add plank to startup apps
sudo cp /home/user/2020/apps/plank.desktop /etc/xdg/autostart/plank.desktop

# Add Ubiquity Slideshow
sudo cp -r /home/user/2020/installer/ubiquity-slideshow /usr/share/ # BUG!!! VERIFY WHY THIS ERRORS OUT

# Copy Plank theme to Plank Themes
sudo mkdir /usr/share/plank/themes/rainier
sudo cp /home/user/2020/plank/rainier.theme /usr/share/plank/themes/rainier/dock.theme
sudo cp /home/user/2020/plank/rainier.theme /usr/share/plank/themes/Default/dock.theme

# Copy Plank icons and order to Home configuration
cp -r /home/user/2020/plank/plank ~/.config/

# Rename GPick to Color Picker; Move to Utilities Folder
sudo cp /home/user/2020/apps/gpick.desktop /usr/share/applications/gpick.desktop


# Ctrl Alt Del Set to System Monitor
# gconftool-2 -t str --set /apps/metacity/global_keybindings/run_command_1 "<Control><Alt>Delete" && gconftool-2 -t str --set /apps/metacity/keybinding_commands/command_1 "gnome-system-monitor"	


# Replace Ubuntu Lockscreen Logo with Trenta OS logo		
sudo cp  /home/user/2020/gdm/lockscreen.png  /usr/share/plymouth/ubuntu-logo.png

# Install GDM Theme
sudo cp /home/user/2020/gdm/ubuntu.css /usr/share/gnome-shell/theme/ubuntu.css	

#######Bug: Custom Keyboard commands
#######Bug: Name Plank Files to define order -- test this to see if it works

read -p "Press Enter to reboot. Run post-reboot.sh and arrange Plank icons after reboot"

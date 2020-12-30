#!/bin/sh

# color variables
RE='\033[1;31m'
YE='\033[1;33m'
PU='\033[1;35m'
NC='\033[0m'

echo -e "${YE}Setting up bspwm and zsh config${NC}"

cd ~

# Installing necessary pakages------------------------------------------
echo -e "${YE}Installing necessary pakages...${NC}"
sleep 1
sudo pacman -S --color=always --noconfirm --needed xorg xorg-xinit alacritty bspwm sxhkd xcb-util-wm git base-devel brightnessctl acpi alsa-utils bc xcb-util-cursor xf86-video-intel xf86-video-nouveau exa dunst unzip xdg-utils wireless_tools 2> /dev/null
echo -e "${YE}Done${NC}"

# Installing yay--------------------------------------------------------

echo -en "${PU}Do you want to install ${YE}yay ${PU}(y/n)?${NC}"
read yay

if [ "${yay}" = "y" ] || [ "${yay}" = "" ]; then

    cmd=`whereis yay`
    if [[ $cmd != */* ]]; then
        echo -e "${YE}Installing yay...${NC}"
        sleep 1
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -sic --noconfirm
        cd ~
        echo -e "${YE}Done${NC}"
    fi

    # Installing yay pakages------------------------------------------------
    cmd=`pacman -Qqm`
    if [[ $cmd != *vscodium-bin* ]]; then

        echo -e -n "${PU}Do you want to install ${YE}vs-codium${PU} (y/n)?${NC} "
        read vs
        if [ "${vs}" = "y" ] || [ "${vs}" = "" ]; then
            a="vscodium-bin"
        fi
    fi
    if [[ $cmd != *nerd-fonts-ubuntu-mono* ]]; then
        b="nerd-fonts-ubuntu-mono"
    fi
    if [[ $cmd != *dmenu-josemapt-git* ]]; then
        echo -e -n "${PU}Do you want to install ${YE}dmenu-josemapt-git${PU} (y/n)?${NC} "
        read dm
        if [ "${dm}" = "y" ] || [ "${dm}" = "" ]; then
            c="dmenu-josemapt-git"
        fi
    fi
    if [[ $cmd != *ccat* ]]; then
        d="ccat"
    fi
    if [[ $cmd != *mpv-git* ]]; then
        echo -e -n "${PU}Do you want to install ${YE}mpv-git${PU} (y/n)?${NC} "
        read mpv
        if [ "${mpv}" = "y" ] || [ "${mpv}" = "" ]; then
            e="mpv-git"
        fi
    fi
    pakages="$a $b $c $d $e"
    yay -S --noconfirm $pakages

    echo -e "${YE}Done${NC}"

fi


# polybar----------------------------------------------------------------------------
echo -e -n "${PU}Do you want to install ${YE}lemonbar${PU} (y/n)?${NC} "
read lemonbar

if [ "${lemonbar}" = "y" ] || [ "${lemonbar}" = "" ]; then

    echo -e "${YE}Cloning repository...${NC}"
    git clone https://github.com/drscream/lemonbar-xft.git

    cd lemonbar-xft
    sudo make clean install

    cd ~

    echo -e "${YE}Removing unnecesary files...${NC} "
    sleep 1
    rm -rf lemonbar-xft

    echo -e "${YE}Done${NC}"
fi
#-------------------------------------------------------------------------------------

# Cloning repository and moving files
echo -e "${YE}Cloning repository...${NC}"
git clone https://github.com/josemapt/dotfiles.git

echo -e "${YE}Moving files...${NC}"
sleep 1
rm -r dotfiles/.config/qtile

[[ -d "~/.config/" ]] || mkdir .config 2> /dev/null
[[ -d "~/.local/bin/" ]] || mkdir -p .local/bin 2> /dev/null
[[ -d "~/.config/bspwm" ]] && rm -r ~/.config/bspwm 2> /dev/null
[[ -d "~/.config/sxhkd" ]] && rm -r ~/.config/sxhkd 2> /dev/null

mv -f dotfiles/.config/alacritty .config
mv -f dotfiles/.config/bspwm .config
mv -f dotfiles/.config/sxhkd .config

chmod +x .config/bspwm/*
chmod +x .config/sxhkd/*

mv dotfiles/.local/bin/vol .local/bin/
mv dotfiles/.local/bin/ex .local/bin/

chmod +x .local/bin/*

[[ -d "~/scripts" ]] || mkdir scripts 2> /dev/null

mv dotfiles/scripts/battery.sh scripts
mv dotfiles/scripts/night_light.sh scripts
chmod +x scripts/*


mkdir -p .cache/bash

mv -f dotfiles/.bashrc ~
mv -f dotfiles/.xinitrc ~

sudo mv dotfiles/theme/TTF/ /usr/share/fonts

echo -e "${YE}Done${NC}"

# Creating gtk3 config file
if [ ! -d ~/.config/gtk-3.0 ]; then
    mkdir .config/gtk-3.0
    touch .config/gtk-3.0/settings.ini
    echo "[Settings]" >> .config/gtk-3.0/settings.ini
else
    if [ ! -f ~/.config/gtk-3.0/settings.ini ]; then
        touch .config/gtk-3.0/settings.ini
        echo "[Settings]" >> .config/gtk-3.0/settings.ini
    fi
fi
#--------------------------

#Installing extra pakages
theme_path='~/dotfiles/theme/'

echo -e -n "${PU}Do you want to install the Tela icon theme (y/n)?${NC} "
read a1

if [ "${a1}" = "y" ] || [ "${a1}" = "" ]; then
    
    echo -e "${YE}Installing the Tela icon theme...${NC} "
    
    curl -O "https://raw.githubusercontent.com/josemapt/dotfiles/main/theme/01-Tela.tar.xz"
    
    tar -xf 01-Tela.tar.xz
    rm 01-Tela.tar.xz
    sudo mv Tela /usr/share/icons/
    sudo mv Tela-dark/ /usr/share/icons/

    echo "gtk-icon-theme-name = Tela" >> .config/gtk-3.0/settings.ini

    echo -e "${YE}Done${NC}"
    
fi

echo -e -n "${PU}Do you want to install the Marwaita theme (y/n)?${NC} "
read aa1

if [ "${aa1}" = "y" ] || [ "${aa1}" = "" ]; then
    
    echo -e "${YE}Installing the Marwaita theme...${NC} "

    curl -O "https://raw.githubusercontent.com/josemapt/dotfiles/main/theme/Marwaita.tar.xz"
    
    tar -xf Marwaita.tar.xz
    rm Marwaita.tar.xz
    sudo mv Marwaita /usr/share/themes/
    sudo mv Marwaita\ Dark/ /usr/share/themes/
    sudo mv Marwaita\ Light/ /usr/share/themes/

    echo "gtk-theme-name = Marwaita Dark" >> .config/gtk-3.0/settings.ini

    echo -e "${YE}Done${NC}"
    
fi

echo -e -n "${PU}Do you want to install he Breeze cursor theme (y/n)?${NC} "
read a2

if [ "${a2}" = "" ] || [ "${a2}" = "y" ]; then

    echo -n -e "${YE}Installing the Breeze cursor theme...${NC} "
    
    curl -O "https://raw.githubusercontent.com/josemapt/dotfiles/main/theme/165371-Breeze.tar.gz"
    
    tar -xf 165371-Breeze.tar.gz
    rm 165371-Breeze.tar.gz
    sudo mv Breeze /usr/share/icons

    echo "gtk-cursor-theme-name = Breeze" >> .config/gtk-3.0/settings.ini

    sudo sed -i 's/Adwaita/Breeze/g' /usr/share/icons/default/index.theme
    echo -e "${YE}Done${NC}"

fi

echo -e -n "${PU}Do you want to install he Vimix grub theme (y/n)?${NC} "
read a3

if [ "${a3}" = "" ] || [ "${a3}" = "y" ]; then

    echo -e "${YE}Installing the Vimix grub theme...${NC} "
    
    curl -O "https://raw.githubusercontent.com/josemapt/dotfiles/main/theme/Vimix-1080p.tar.xz"
    
    tar -xf Vimix-1080p.tar.xz
    rm Vimix-1080p.tar.xz
    sudo mv Vimix-1080p/Vimix/ /boot/grub/themes/
    rm -r Vimix-1080p
    
    sudo chmod 777 /etc/default/grub
    echo "GRUB_THEME='/boot/grub/themes/Vimix/theme.txt'" >> /etc/default/grub
    sudo chmod 644 /etc/default/grub

    sudo grub-mkconfig -o /boot/grub/grub.cfg

    echo -e "${YE}Done${NC}"

fi

# Dunst notify icon--------------------------------------------------------------
echo -e -n "${PU}Do you want to download ${YE}<info.png> ${PU}(recommended for Dunst notify icon) (y/n)?${NC} "
read a4
if [ "${a4}" = "" ] || [ "${a4}" = "y" ]; then
    if [[ ! -d ~/multimedia ]]; then
        mkdir ~/multimedia
    fi

    curl -o ~/multimedia/info.png "https://upload.wikimedia.org/wikipedia/commons/e/e4/Infobox_info_icon.svg"

    echo -e "${YE}Done${NC}"
    echo -e -n "${YE}Press ${PU}enter${YE} to test it${NC} "
    read a_test
    dunst &
    notify-send "This is a random notification :)"

fi

# Wallpaper-----------------------------------------------------------------------
echo -e -n "${PU}Do you want to set a wallpaper now (y/n)?${NC} "
read a5
if [ "${a5}" = "" ] || [ "${a5}" = "y" ]; then
    if [[ ! -d ~/multimedia ]]; then
        mkdir ~/multimedia
    fi

    sudo pacman -S --color=always --noconfirm --needed imlib2

    curl -o ~/multimedia/wall1.jpg "https://i.pinimg.com/originals/3b/8a/d2/3b8ad2c7b1be2caf24321c852103598a.jpg"

    git clone https://github.com/himdel/hsetroot.git
    cd hsetroot
    sudo make clean install
    cd ~
    rm -rf hsetroot

    hsetroot -fill ~/multimedia/wall1.jpg

    echo -e "${YE}Done${NC}"

fi

# Cleaning-----------------------------------------------------------------
echo -e "${YE}Removing unnecesary files...${NC} "
sleep 1
rm -fr dotfiles
rm .bash_logout .bash_profile .bash_history

# Reboot-----------------------------------------------------------------
echo ""
echo -e "${YE}Setting up completed. Rebooting now...${NC} "

sleep 1
rm zinstall.sh

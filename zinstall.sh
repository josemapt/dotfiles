#!/bin/sh

# color variables
RE='\033[1;31m'
YE='\033[1;33m'
PU='\033[1;35m'
NC='\033[0m'

echo -e "${YE}Setting up qtile and zsh config${NC}"

# Installing necessary pakages------------------------------------------
echo -e "${YE}Installing necessary pakages...${NC}"
sleep 1
sudo pacman -S --color=always --noconfirm --needed thunar feh git base-devel brightnessctl python-psutil acpi alsa-utils cbatticon network-manager-applet geeqie xcb-util-cursor xf86-video-intel xf86-video-nouveau exa gvfs ntfs-3g dunst scrot redshift bc unzip evince zsh xdg-utils 2> /dev/null
echo -e "${YE}Done${NC}"

# Installing yay--------------------------------------------------------
cmd=`whereis yay`
if [[ $cmd != */* ]]; then
    echo -e "${PU}Installing yay...${NC}"
    sleep 1
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -sic --noconfirm
    cd ~
    echo -e "${YE}Done${NC}"
else
    break
fi

# Installing yay pakages------------------------------------------------
cmd=`pacman -Qqm`
if [[ $cmd != *vscodium-bin* ]]; then

    echo -e -n "${PU}Do you want to install ${YE}vs-codium${PU} (y/n)?${NC} "
    read vs
    if [ "${vs}" = "y" ] || [ "${vs}" = "" ]; then
        a="vscodium-bin"
    else
        break
    fi
fi
if [[ $cmd != *nerd-fonts-ubuntu-mono* ]]; then
    b="nerd-fonts-ubuntu-mono"
fi
if [[ $cmd != *ccat* ]]; then
    c="ccat"
fi
pakages="$a $b $c"
yay -S --noconfirm $pakages

# Cloning repository and moving files
echo -e "${YE}Cloning repository...${NC}"
slep 1
git clone https://github.com/josemapt/dotfiles.git

echo -e "${YE}Relocating files...${NC}"
sleep 1
mv -f dotfiles/.config/qtile/* ~/.config/qtile
mv -f dotfiles/.config/* .config
chmod +x .config/qtile/autostart.sh

# Neovim plugins installation
if [ `pacman -Qqm` != *neovim* ]; then
    echo -e -n "${PU}Do you want to install ${YE}neovim${PU} (y/n)?${NC} "
    read nv1
    if [ "${nv1}" = "y" ] || [ "${nv1}" = "" ]; then
        sudo pacman -S --color=always --noconfirm neovim

        echo -e -n "${PU}Do you want to install some nice neovim plugins (y/n)?${NC} "
        read nv2
        if [ "${nv2}" = "y" ] || [ "${nv2}" = "" ]; then
            curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
                https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            
            nvim -c 'PlugInstall --sync' +qa
        else
            break
        fi
    else
        rm -r .config/nvim/init.vim
    fi
else
    echo -e -n "${PU}Do you want to install some nice neovim plugins (y/n)?${NC} "
    read nv3
    if [ "${nv3}" = "y" ] || [ "${nv3}" = "" ]; then
        if [ -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
            curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
                https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        else
            break
        fi
        nvim -c 'PlugInstall --sync' +qa
    else
        break
    fi
fi

#----------------------------
echo -e "${YE}Moving files...${NC}"
slep 1

mv dotfiles/.local/bin .local
chmod +x .local/bin/*
mv dotfiles/.zsh_config ~
mv dotfiles/scripts ~
chmod +x scripts/*
mv dotfiles/zsh-autosuggestions ~
mv dotfiles/zsh-syntax-highlighting ~
mv dotfiles/.bashrc ~
mv dotfiles/.xinitrc ~
mv dotfiles/.zshrc ~
rm -rf dotfiles
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
    else
        break
    fi
fi
#--------------------------

#Installing extra pakages
echo -e -n "${PU}Do you want to install the Marwaita theme and the Tela icon theme (y/n)?${NC} "
read a1

if [ "${a1}" = "y" ] || [ "${a1}" = "" ]; then
    echo -e -n "${RE}Make sure you have downloaded them from ${PU}https://www.gnome-look.org/p/1239855/ ${RE}(Marwaita) and ${PU}https://www.gnome-look.org/p/1279924/ ${RE}(Tela icon theme) and then press ${PU}enter${NC}"
    read any1
    if [ -f ~/Downloads/01-Tela.tar.xz ] && [ -f ~/Downloads/Marwaita.tar.xz ]; then
        echo -e "${YE}Installing the Marwaita theme and the Tela icon theme...${NC} "
        sleep 1
        cd Downloads/

        tar -xf 01-Tela.tar.xz
        rm 01-Tela.tar.xz
        sudo mv Tela /usr/share/icons/
        sudo mv Tela-dark/ /usr/share/icons/

        tar -xf Marwaita.tar.xz
        rm Marwaita.tar.xz
        sudo mv Marwaita /usr/share/themes/
        sudo mv Marwaita\ Dark/ /usr/share/themes/
        sudo mv Marwaita\ Light/ /usr/share/themes/

        cd ~

        echo "gtk-icon-theme-name = Tela" >> .config/gtk-3.0/settings.ini
        echo "gtk-theme-name = Marwaita Dark" >> .config/gtk-3.0/settings.ini

        echo -e "${YE}Done${NC}"
    else
        echo -e "${RE}Files haven't been found${NC}"
        break
    fi

else
    break
fi

echo ""
echo -e -n "${PU}Do you want to install he Breeze cursor theme (y/n)?${NC} "
read a2

if [ "${a2}" = "" ] || [ "${a2}" = "y" ]; then
    echo -e -n "${RE}Make sure that you have downloaded it from ${PU}https://www.gnome-look.org/p/999927/ ${RE} and then press ${PU}enter${NC}"
    read any2
    
    if [ -f ~/Downloads/165371-Breeze.tar.gz ]; then
        echo -n -e "${PU}Installing the Breeze cursor theme...${NC} "
        sleep 1

        cd Downloads
        tar -xf 165371-Breeze.tar.gz
        rm 165371-Breeze.tar.gz
        sudo mv Breeze /usr/share/icons

        cd ~
        echo "gtk-cursor-theme-name = Breeze" >> .config/gtk-3.0/settings.ini

        sudo sed -i 's/Adwaita/Breeze/g' /usr/share/icons/default/index.theme
        echo -e "${YE}Done${NC}"

    else
        echo -e "${RE}Files haven't been found${NC}"
        break
    fi
else
    break
fi

echo ""
echo -e -n "${PU}Do you want to install he Vimix grub theme (y/n)?${NC} "
read a3

if [ "${a3}" = "" ] || [ "${a3}" = "y" ]; then
    echo -e -n "${RE}Make sure that you have downloaded it from ${PU}https://www.gnome-look.org/p/1009236/ ${RE}and then press ${PU}enter${NC}"
    read any3

    if [ -f ~/Downloads/Vimix-1080p.tar.xz ]; then
        echo -e "${PU}Installing the Vimix grub theme...${NC} "
    
        cd Downloads

        tar -xf Vimix-1080p.tar.xz
        rm Vimix-1080p.tar.xz
        sudo mv Vimix-1080p/Vimix/ /boot/grub/themes/
        rm -r Vimix-1080p

        cd ~

        sudo chmod 777 /etc/default/grub
        echo "GRUB_THEME='/boot/grub/themes/Vimix/theme.txt'" >> /etc/default/grub
        sudo chmod 644 /etc/default/grub

        sudo grub-mkconfig -o /boot/grub/grub.cfg

        echo -e "${YE}Done${NC}"
    
    else
        echo -e "${RE}Files haven't been found${NC}"
        break
    fi

else
    break
fi

# Dunst notify icon--------------------------------------------------------------
echo ""
echo -e -n "${PU}Do you want to download ${YE}<info.png> ${PU}(recommended for Dunst notify icon) (y/n)?${NC} "
read a4
if [ "${a4}" = "" ] || [ "${a5}" = "y" ]; then
    if [[ ! -d ~/images ]]; then
        mkdir ~/images
    fi

    curl -o ~/images/info.png https://upload.wikimedia.org/wikipedia/commons/e/e4/Infobox_info_icon.svg

    echo -e "${YE}Done${NC}"
    echo -e -n "${YE}Press ${PU}enter${YE} to test it${NC} "
    read aTest
    dunst &
    notify-send "This is a random notification :)"
else
    break
fi

# Wallpaper-----------------------------------------------------------------------
echo ""
echo -e -n "${PU}Do you want to set a wallpaper now (y/n)?${NC} "
read a5
if [ "${a5}" = "" ] || [ "${a5}" = "y" ]; then
    if [[ ! -d ~/images ]]; then
        mkdir ~/images
    fi

    curl -o ~/images/wall1.jpg https://i.pinimg.com/originals/3b/8a/d2/3b8ad2c7b1be2caf24321c852103598a.jpg

    feh --bg-scale ~/images/wall1.jpg

    echo -e "${YE}Done${NC}"
else
    break
fi

# Reboot-----------------------------------------------------------------
echo ""
echo -e "${YE}Setting up completed. Reboot is need${NC} "

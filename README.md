# dotfiles


# Clone repository and make a clean installation:
Warning!!! You can have some issues with the curl command if you are not running it from a clean arch installation
```
curl -O https://raw.githubusercontent.com/josemapt/dotfiles/main/zinstall.sh; chmod +x zinstall.sh; ./zinstall.sh; rm zinstall.sh

```

<br>
<hr>
<br>

<img src="https://repository-images.githubusercontent.com/320825726/85ecb200-3c89-11eb-94e8-efedf91e4b9a">

***Quick Links***
  - [Qtile](https://github.com/josemapt/dotfiles/tree/main/.config/qtile)
  - [Neovim](https://github.com/josemapt/dotfiles/tree/main/.config/nvim)
  
  

# Base pakages:

```
base base-devel linux linux-firmware neovim intel-ucode networkmanager
```


# Pakages to download first:
```
sudo pacman -S xorg xorg-server xorg-xinit qtile firefox alacritty
```
Then start qtile and copy the rest.

# Rest of pakages:
```
sudo pacman -S thunar feh dmenu git brightnessctl python-psutil acpi alsa-utils cbatticon network-manager-applet geeqie xcb-util-cursor xf86-video-intel xf86-video-nouveau exa gvfs ntfs-3g dunst scrot redshift bc unzip evince zsh xdg-utils
```

# Installing yay.
```
git clone https://aur.archlinux.org/yay.git

cd yay

makepkg -si
```

# Whith yay:
```
yay -S vscodium-bin nerd-fonts-ubuntu-mono ccat
```

<br>
<hr>
<br>


# Setting up zsh
First, install zsh with
```
sudo pacman -S zsh
```
To change the default shell run
```
# User default shell
chsh -s /bin/zsh $(whoami)

# Superuser default shell
sudo chsh -s /bin/zsh
```

<br>
<hr>
<br>

# Solving screen tearing problem in firefox:
Type <b>about:config</b> and set <b>layers.acceleration.force-enabled = true</b>

<br>
<hr>
<br>

# Changing GTK theme:
Download any theme in https://www.gnome-look.org/browse/cat/135/ord/rating/ and run:
```
# In this case I am installing the Marwaita theme and the Tela icon theme

cd Downloads/

tar -xf Marwaita.tar.xz
tar -xf 01-Tela.tar.xz

rm Marwaita.tar.xz
rm 01-Tela.tar.xz

sudo mv Tela /usr/share/icons/
sudo mv Tela-dark/ /usr/share/icons/

sudo mv Marwaita\ Dark/ /usr/share/themes/
sudo mv Marwaita\ Light/ /usr/share/themes/
```
Download the <b>Breeze</b> cursor theme in https://www.gnome-look.org/p/999927/ and run:
```
cd Downloads/
tar -xf 165371-Breeze.tar.gz
rm 165371-Breeze.tar.gz
sudo mv Breeze /usr/share/icons
```
Now edit <b>~/.config/gtk-3.0/settings.ini</b> and <b>/usr/share/icons/default/index.theme</b> by adding these lines:
```
# ~/.config/gtk-3.0/settings.ini
[Settings]
gtk-icon-theme-name = Tela
gtk-theme-name = Marwaita Dark
gtk-cursor-theme-name = Breeze

# /usr/share/icons/default/index.theme
[Icon Theme]
Inherits=Breeze
```
And reboot

<br>
<hr>
<br>

# Changing lightdm theme:
Run:
```
sudo pacman -S lightdm-webkit2-greeter
yay -S lightdm-webkit-theme-aether

systemctl enable lightdm
```
And reboot


<br>
<hr>
<br>

# Changing GRUB theme
Download <b>Vimix</b> grub theme from https://www.gnome-look.org/browse/cat/109/ord/rating/ and run:
```
cd Downloads/
tar -xf Vimix-1080p.tar.xz
rm Vimix-1080p.tar.xz
sudo mv Vimix-1080p /boot/grub/themes
```
Then edit <b>/etc/default/grub</b> by adding:
```
GRUB_THEME="/boot/grub/themes/Vimix-1080p/Vimix/theme.txt"
```
And applay changes:
```
sudo su
grub-mkcongif -o /boot/grub/grub.cfg
```
If everything goes right then you'll see:
```
Found theme: /boot/grub/themes/Vimix-1080p/Vimix/theme.txt
```

<br>
<hr>
<br>

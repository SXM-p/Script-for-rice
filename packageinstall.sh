#!/bin/bash

# Packages from official repositories
official_packages=(
    nano
    discord
    obsidian
    cheese
    hyprland
    hyprpaper
    hyprlock
    hypridle
    kitty
    7zip
    bluetui
    brightnessctl
    btop
    dunst
    fastfetch
    fzf
    gtk-engine-murrine
    noto-fonts-cjk
    nwg-look
    papirus-icon-theme
    pavucontrol
    pipewire
    pipewire-alsa
    pipewire-jack
    pipewire-pulse
    polkit-gnome
    python
    python-gobject
    rofi-wayland
    spotify-launcher
    ttf-firacode-nerd
    ttf-font-awesome
    ttf-jetbrains-mono-nerd
    unzip
    waybar
    wireplumber
    xdg-desktop-portal-hyprland
    xdg-utils
    yazi
    zsh
)

# AUR packages
aur_packages=(
    google-chrome
    visual-studio-code-bin
    postman-bin
    legacy-launcher
    bibata-cursor-theme-bin
    galendae-git
    spicetify-cli
)

#Target configs
target_configs=(
	btop
	dunst
	fastfetch
	galendae
	gtk-3.0
	gtk-4.0
	hypr
	kitty
	rofi
	nvim
	wallpapers
	waybar
	yazi
	starship.toml
)

# Install official packages
echo "Installing official packages..."
sudo pacman -Syu --noconfirm "${official_packages[@]}"

# Create a temporary directory for AUR builds
tmpdir=$(mktemp -d)
cd "$tmpdir" || exit 1

# Install AUR packages
for pkg in "${aur_packages[@]}"; do
    echo "Installing AUR package: $pkg"
    git clone "https://aur.archlinux.org/${pkg}.git"
    cd "$pkg" || continue
    makepkg -si --noconfirm
    cd "$tmpdir" || break
done

# Cleanup
echo "Cleaning up..."
rm -rf "$tmpdir"

echo "All packages installed successfully!"

# Configuration
echo "Cloning and copying the configurations"
sudo git clone https://github.com/Andr3xDev/Dotfiles
cd Dotfiles/dots
cp -r "${target_configs[@]}" ~/.config/

echo "Your setup is now ready to use!!!"
echo "Change the keyboard layout from latam to us in hyprland.conf"

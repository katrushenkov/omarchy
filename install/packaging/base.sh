sudo -v

# Install all base packages
mapfile -t packages < <(grep -v '^#' "$OMARCHY_INSTALL/omarchy-base.packages" | grep -v '^$')
sudo pacman -S --noconfirm --needed "${packages[@]}"

mapfile -t packages < <(grep -v '^#' "$OMARCHY_INSTALL/omarchy-aur.packages" | grep -v '^$')
yay -S --noconfirm "${packages[@]}"

rm -rf $HOME/.config/nnn/plugins* >/dev/null
# Install plugins for nnn file manager
sh -c "$(curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs)"


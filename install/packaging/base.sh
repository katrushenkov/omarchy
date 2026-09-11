sudo -v

# Install all base packages
mapfile -t packages < <(grep -v '^#' "$OMARCHY_INSTALL/omarchy-base.packages" | grep -v '^$')

omarchy-pkg-add "${packages[@]}"

# Install plugins for nnn file manager
rm -rf $HOME/.config/nnn/plugins* >/dev/null
sh -c "$(curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs)"
mkdir -p $HOME/.cache/zsh

mapfile -t packages < <(grep -v '^#' "$OMARCHY_INSTALL/omarchy-aur.packages" | grep -v '^$')
yay -S --noconfirm "${packages[@]}"

sudo -v

# Install all base packages
mapfile -t packages < <(grep -v '^#' "$OMARCHY_INSTALL/omarchy-base.packages" | grep -v '^$')

omarchy-pkg-add "${packages[@]}"

mkdir -p $HOME/.cache/zsh

mapfile -t packages < <(grep -v '^#' "$OMARCHY_INSTALL/omarchy-aur.packages" | grep -v '^$')
yay -S --noconfirm "${packages[@]}"

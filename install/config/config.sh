# Copy over Omarchy configs
mkdir -p ~/.config
cp -R ~/.local/share/omarchy/config/* ~/.config/

# Use default bashrc from Omarchy
cp ~/.local/share/omarchy/default/bashrc ~/.bashrc

dotfilesrepo="https://github.com/katrushenkov/dotfiles.git"
aurhelper="yay"
repobranch="master"
export TERM=ansi
export branch="master"
export repodir="$HOME/.local/src"
mkdir -p "$repodir"
chown -R "$USER":wheel "$(dirname "$repodir")"
rm -rf "$repodir/dotfiles"

putgitrepo() {
	# Downloads a gitrepo $1 and places the files in $2 only overwriting conflicts
	[ -z "$3" ] && branch="master" || branch="$repobranch"
	dir=$(mktemp -d)
	[ ! -d "$2" ] && mkdir -p "$2"
	chown "$USER":wheel "$dir" "$2"
	sudo -u "$USER" git -C "$repodir" clone --depth 1 \
		--single-branch --no-tags -q --recursive -b "$branch" \
		--recurse-submodules "$1" "$dir"
	sudo -u "$USER" cp -rfT "$dir" "$2"
}

putgitrepo "$dotfilesrepo" "$HOME" "$repobranch"
rm -rf "$HOME/README.md" "$HOME/LICENSE" "$HOME/FUNDING.yml"
mv -f "$HOME/.git/" "$repodir/dotfiles"

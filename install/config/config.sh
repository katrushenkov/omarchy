# Copy over Omarchy configs
mkdir -p ~/.config
cp -R ~/.local/share/omarchy/config/* ~/.config/

# Use default bashrc from Omarchy
cp ~/.local/share/omarchy/default/bashrc ~/.bashrc

mkdir -p ~/.local/src
dotfilesrepo="https://github.com/katrushenkov/dotfiles.git"
aurhelper="yay"
repobranch="master"
export TERM=ansi
export name="ser"
export branch="master"
	export repodir="/home/$name/.local/src"
	mkdir -p "$repodir"
	chown -R "$name":wheel "$(dirname "$repodir")"
rm -rf "$repodir/dotfiles"

putgitrepo() {
	# Downloads a gitrepo $1 and places the files in $2 only overwriting conflicts
	[ -z "$3" ] && branch="master" || branch="$repobranch"
	dir=$(mktemp -d)
	[ ! -d "$2" ] && mkdir -p "$2"
	chown "$name":wheel "$dir" "$2"
	sudo -u "$name" git -C "$repodir" clone --depth 1 \
		--single-branch --no-tags -q --recursive -b "$branch" \
		--recurse-submodules "$1" "$dir"
	sudo -u "$name" cp -rfT "$dir" "$2"
}

putgitrepo "$dotfilesrepo" "/home/$name" "$repobranch"
rm -rf "/home/$name/README.md" "/home/$name/LICENSE" "/home/$name/FUNDING.yml"
mv -f "/home/$name/.git/" "/home/$name/.local/src/dotfiles"

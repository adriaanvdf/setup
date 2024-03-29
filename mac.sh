#!/bin/bash -e -x

echo "Installing xcode-stuff"
xcode-select --install

# Install Homebrew
if test ! $(which brew); then
    echo "Installing Homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /Users/adriaan/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/adriaan/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
# else
#     echo "Updating Homebrew"
#     brew update
fi

brew tap homebrew/cask-drivers


packages=(
	gh
	go
	iperf3
	kubectl
	kubectx
	minikube
	nmap
	pv
	wget
	)

applications=(
	1password
	brave-browser
	flux
	intellij-idea-ce
	iterm2
	microsoft-office
	microsoft-teams
	miro
	notion
	obsidian
	postman
	raspberry-pi-imager
	rectangle
	slack
	spotify
	sublime-merge
	sublime-text
	zoom
	)

drivers=(
	)

software=(
	"${packages[@]}"
	"${applications[@]}"
	"${drivers[@]}"
	)

# Install software
for i in "${software[@]}"; do
	if brew list $i &>/dev/null; then
		echo "$i already installed"
		echo "Updating $i"
		brew upgrade $i
	else
		echo "Installing $i"
	    brew install $i

	fi
done

brew cleanup

# if type brew &>/dev/null
# then
#   HOMEBREW_PREFIX="$(brew --prefix)"
#   if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
#   then
#     source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
#   else
#     for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
#     do
#       [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
#     done
#   fi
# fi

## SSH
echo "Generate SSH keys"
if ls -al ~/.ssh &>/dev/null; then
	echo "exists"
else
	ssh-keygen -t rsa
fi

## Create symlink shortcuts
echo "Create symlink shortcuts"
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl

## Git setup
echo "Set up git config"
git config --global user.name "adriaanvdf"
git config --global user.email adriaan@vdfeltz.com

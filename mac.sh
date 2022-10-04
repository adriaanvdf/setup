#!/bin/bash -e -x

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


packages=(
	go
	iperf3
	kubectl
	kubectx
	minikube
	nmap
	pv
	ssh
	wget
	xzcat
	)

applications=(
	raspberry-pi-imager
	sublime-merge
	sublime-text
	)

software=(
	"${packages[@]}"
	"${applications[@]}"
	)

# # Install packages
# for package in "${packages[@]}"; do
# 	if test ! $(which $package); then
# 	    echo "Installing $package"
# 	    brew install $package
# 	else
# 	    echo "$package already installed"
# 	#     echo "Updating $package"
# 	#     brew update <>
# 	fi
# done

# # Install packages
# for app in "${applications[@]}"; do
# 	if test ! $(which $app); then
# 	    echo "Installing $app"
# 	    brew install --cask $
# 	    brew cask install --appdir="/Applications" $app

# 	# else
# 	#     echo "Updating $app"
# 	#     brew update <>
# 	fi
# done

# Install software
for i in "${software[@]}"; do
	if brew list $i &>/dev/null; then
		echo "$i already installed"
		# echo "Updating $i"
		# brew update <>
	else
		echo "Installing $i"
	    brew install $i

	fi
done

brew cleanup

# Create symlink shortcuts
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl

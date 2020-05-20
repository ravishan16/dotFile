# dotFile

Ravi's Dotfile Mac setup from scratch

## Install Command Line Tools

```shell
sudo softwareupdate -i -a
xcode-select --install
```

## Create Project Directories

```shell
mkdir -p ~/projects/git
cd ~/projects/git
```

## Git Clone

```
git clone https://github.com/ravishan16/dotfile/
cd dotfile
```

## Install Brew Packages

```
source init.sh
```

## Instal OhMyZsh

```
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

### Plugin

git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

```

### Replace ~/.zshrc

```
mv ~/.zshrc ~/.zshrc.backup
cp ~/projects/git/dotfile/dot/.zshrc ~/.zshrc
```


### Install Python (Miniconda)
```
brew cask install python
 conda init "$(basename "${SHELL}")"
```

# dotfiles

This directory contains the dotfiles for my system.

## Requirements

Install these packages, commands for fedora based distro:

### Zsh

```bash
sudo dnf install zsh
# Set zsh default shell
# chsh -s $(which zsh)
sudo lchsh $USER
```


### Git

```bash
sudo dnf install git
```

### Stow

```bash
sudo dnf instal stow
```

## Instalation

First, checkout the dotfiles repo in $HOME 

```bash
git clone https://github.com/joao-alho/dotfiles.git
cd dotfiles
```

then use GNU stow to create the symlinks

```bash
stow .
```

can also partially set symlinks like this:

```bash
cd .config/
stow -v . -t ~/.config/
```

## The other stuff

### Tmux
Install tmux

### Neovim
Install neovim

Telescope requires [ripgrep](https://github.com/BurntSushi/ripgrep)
```zsh
sudo dnf install ripgrep

## or

# cargo binstall ripgrep
```

### Rust
Install rust and cargo

### Pyton
Install python and poetry

```zsh
curl -sSL https://install.python-poetry.org | python3 -

# Enable poetry auto complete with Oh My Zsh
mkdir $ZSH_CUSTOM/plugins/poetry
poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry

# Edit .zshrc and add poetry to the plugins
```

# dotfiles

This directory contains the dotfiles for my system.

## Requirements

Install these packages, commands for fedora based distro:

### Git

```
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


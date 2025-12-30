# dotfiles

This directory contains the dotfiles for my system.

## Tools

### Terminal
```zsh

# On MacOS
brew install wezterm
```

### Git

```bash
sudo dnf install git
# On MacOS
brew install git
git clone https://github.com/joao-alho/dotfiles.git
cd dotfiles
```

### Stow

```bash
sudo dnf instal stow
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

### Zsh

```bash
sudo dnf install zsh
# Set zsh default shell
# chsh -s $(which zsh)
sudo lchsh $USER
```

### Oh my zsh (deprecated)

```zsh
# Instal ohmyzsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Install autosuggestions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

### Fonts
```zsh
# Install JetBrainsNerdFont 
mkdir -p ~/.local/share/fonts/
cd ~/.local/share/fonts/
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
tar xf JetBrainsMono.tar.xz
rm -f JetBrainsMono.tar.xz
# On Fedora
fc-cache -fv
# On MacOS
cp *.ttf ~/Library/Fonts/
```

### Starship
```zsh
curl -fsSL https://starship.rs/install.sh | zsh
```

### Tmux
```zsh
## on Fedora
sudo dnf install tmux
## on MacOS
brew install tmux
```

### Neovim
```zsh
## on MacOS
brew install neovim
```

Telescope plugin requires [ripgrep](https://github.com/BurntSushi/ripgrep)
```zsh
## On Fedora
sudo dnf install ripgrep
## or on MacOS
brew install ripgrep
```

nvim-dbee uses my custom implementation with Athena Adapter

```zsh
git clone git@github.com:joao-alho/nvim-dbee ~/projects/personal/nvim-dbee/
# todo: add commands to build the plugin
```

### Rust
Install rust and cargo

```zsh
curl https://sh.rustup.rs -sSf | sh
```

### Pyton
Install uv

```zsh
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### Zoxide
Install [ zoxide ](https://github.com/ajeetdsouza/zoxide)

* zoxide requires [fzf]()
```zsh
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
## on Fedora
sudo dnf install fzf
## or on MacOS
brew install fzf
```

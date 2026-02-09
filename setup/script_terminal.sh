#!/bin/bash

# Exit on error
set -e

# Update and upgrade packages
echo "Updating and upgrading packages..."
sudo apt-get update && sudo apt-get upgrade -y

# Install zsh 
if ! command -v zsh >/dev/null 2>&1; then
  echo "Installing zsh..."
  sudo apt-get install -y zsh
else
  echo "zsh already installed."
fi


# Change default shell to zsh for current user
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "Changing default shell to zsh..."
  chsh -s "$(which zsh)"
else
  echo "zsh is already the default shell."
fi

# Install oh-my-zsh 
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "oh-my-zsh already installed."
fi

# Install zsh-autosuggestions 
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
  echo "zsh-autosuggestions already installed."
fi

# Install tmux 
if ! command -v tmux >/dev/null 2>&1; then
  echo "Installing tmux..."
  sudo apt-get install -y tmux
else
  echo "tmux already installed."
fi
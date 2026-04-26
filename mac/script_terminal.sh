#!/bin/bash

set -e

echo "Checking Homebrew..."
if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew already installed."
fi

echo "Updating brew..."
brew update

# Install zsh
if ! command -v zsh >/dev/null 2>&1; then
  echo "Installing zsh..."
  brew install zsh
else
  echo "zsh already installed."
fi

# Change default shell to zsh
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "Changing default shell to zsh..."
  chsh -s "$(which zsh)"
fi

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install plugin
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# Install tmux
if ! command -v tmux >/dev/null 2>&1; then
  echo "Installing tmux..."
  brew install tmux
fi

# Configure tmux
TOUCH_CONF="$HOME/.tmux.conf"
[ ! -f "$TOUCH_CONF" ] && touch "$TOUCH_CONF"

grep -q "set -g base-index 1" "$TOUCH_CONF" || echo "set -g base-index 1" >> "$TOUCH_CONF"
grep -q "set -g pane-base-index 1" "$TOUCH_CONF" || echo "set -g pane-base-index 1" >> "$TOUCH_CONF"

echo "Setup complete."

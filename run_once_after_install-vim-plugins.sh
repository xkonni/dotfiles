#!/bin/sh

# Exit immediately if a command exits with a non-zero status
set -e

echo "Installing Vim plugins with vim-plug..."

# Check if vim is available
if ! command -v vim >/dev/null 2>&1; then
  echo "vim is not installed. Skipping plugin installation."
  exit 0
fi

# Check if vim-plug is installed
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
  echo "vim-plug is not installed. Installing vim-plug first..."
  curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Run PlugInstall in vim
echo "Running :PlugInstall..."
vim +PlugInstall +qall

echo "Vim plugins installed successfully."

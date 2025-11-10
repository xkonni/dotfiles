#!/bin/sh

# Exit immediately if a command exits with a non-zero status
set -e

echo "Running Oh My Zsh install script..."

# Check if ~/.oh-my-zsh directory already exists
if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh My Zsh is already installed. Skipping."
else
  # Run the installer non-interactively
  # --unattended: sets CHSH=no, RUNZSH=no, and exits
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

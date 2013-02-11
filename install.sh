#! /bin/bash

echo "Installing homebrew..."
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

echo "Using homebrew to install sqlite3..."
brew install sqlite3


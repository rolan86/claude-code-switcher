#!/bin/bash
# Remote installation script for claude-switcher
# Usage: curl -fsSL https://raw.githubusercontent.com/rolan86/claude-code-switcher/main/install-remote.sh | bash

set -e

INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="claude-switcher"
REPO_URL="https://raw.githubusercontent.com/rolan86/claude-code-switcher/claude/switch-glm-model-011CUtcp2SMC3AWFwoCKMm7t"

echo "=== Claude Code Switcher - Remote Installation ==="
echo

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is required but not installed."
    echo "Please install Python 3 and try again."
    exit 1
fi

echo "✓ Python 3 found: $(python3 --version)"

# Download the script
echo
echo "Downloading claude-switcher..."
TEMP_FILE=$(mktemp)
if command -v curl &> /dev/null; then
    curl -fsSL "${REPO_URL}/${SCRIPT_NAME}" -o "$TEMP_FILE"
elif command -v wget &> /dev/null; then
    wget -q "${REPO_URL}/${SCRIPT_NAME}" -O "$TEMP_FILE"
else
    echo "Error: Neither curl nor wget found. Please install one of them."
    exit 1
fi

# Detect if we need sudo
if [ -w "$INSTALL_DIR" ]; then
    SUDO=""
else
    SUDO="sudo"
    echo "  (Will use sudo for installation to $INSTALL_DIR)"
fi

# Install
echo "Installing $SCRIPT_NAME to $INSTALL_DIR..."
$SUDO mv "$TEMP_FILE" "$INSTALL_DIR/$SCRIPT_NAME"
$SUDO chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

# Verify
if command -v claude-switcher &> /dev/null; then
    echo
    echo "✓ Installation successful!"
    echo
    echo "Run 'claude-switcher help' to get started."
    echo
    echo "Quick start:"
    echo "  1. Add a profile:  claude-switcher profile add claude"
    echo "  2. Launch session: claude-switcher start claude"
else
    echo
    echo "⚠ Installation completed but $SCRIPT_NAME is not in PATH"
    echo "You may need to add $INSTALL_DIR to your PATH"
    echo
    echo "Add this to your ~/.zshrc (or ~/.bash_profile):"
    echo "  export PATH=\"$INSTALL_DIR:\$PATH\""
fi

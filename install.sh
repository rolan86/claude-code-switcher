#!/bin/bash
# Installation script for claude-switcher

set -e

INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="claude-switcher"

echo "=== Claude Code Switcher Installation ==="
echo

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is required but not installed."
    echo "Please install Python 3 and try again."
    exit 1
fi

echo "✓ Python 3 found: $(python3 --version)"

# Detect if we need sudo
if [ -w "$INSTALL_DIR" ]; then
    SUDO=""
else
    SUDO="sudo"
    echo "  (Will use sudo for installation to $INSTALL_DIR)"
fi

# Copy script to install directory
echo
echo "Installing $SCRIPT_NAME to $INSTALL_DIR..."
$SUDO cp "$SCRIPT_NAME" "$INSTALL_DIR/$SCRIPT_NAME"
$SUDO chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

# Verify installation
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
fi

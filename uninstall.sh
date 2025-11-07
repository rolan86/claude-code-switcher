#!/bin/bash
# Uninstallation script for claude-switcher

set -e

INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="claude-switcher"
CONFIG_DIR="$HOME/.claude-switcher"

echo "=== Claude Code Switcher Uninstallation ==="
echo

# Detect if we need sudo
if [ -w "$INSTALL_DIR" ]; then
    SUDO=""
else
    SUDO="sudo"
    echo "  (Will use sudo for removal from $INSTALL_DIR)"
fi

# Ask for confirmation
echo "This will remove:"
echo "  - $INSTALL_DIR/$SCRIPT_NAME (the executable)"
echo

read -p "Do you also want to remove your profiles and settings? (y/n): " -n 1 -r
echo
REMOVE_CONFIG=$REPLY

# Remove executable
if [ -f "$INSTALL_DIR/$SCRIPT_NAME" ]; then
    echo "Removing $INSTALL_DIR/$SCRIPT_NAME..."
    $SUDO rm "$INSTALL_DIR/$SCRIPT_NAME"
    echo "✓ Executable removed"
else
    echo "⚠ Executable not found at $INSTALL_DIR/$SCRIPT_NAME"
fi

# Remove config directory if requested
if [[ $REMOVE_CONFIG =~ ^[Yy]$ ]]; then
    if [ -d "$CONFIG_DIR" ]; then
        echo
        echo "Removing configuration directory $CONFIG_DIR..."
        echo "  (Contains your profiles and API keys)"
        rm -rf "$CONFIG_DIR"
        echo "✓ Configuration removed"
    else
        echo "⚠ Configuration directory not found"
    fi
else
    echo
    echo "✓ Keeping your profiles at $CONFIG_DIR"
    echo "  (You can manually delete this directory later if needed)"
fi

echo
echo "✓ Uninstallation complete!"
echo

# Verify removal
if command -v claude-switcher &> /dev/null; then
    echo "⚠ Warning: 'claude-switcher' is still found in PATH"
    echo "  Location: $(which claude-switcher)"
    echo "  You may need to close and reopen your terminal"
else
    echo "✓ Verified: claude-switcher is no longer in PATH"
fi

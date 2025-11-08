# Claude Code Switcher v2.1

A powerful CLI tool to manage multiple model profiles and launch isolated Claude Code sessions. Perfect for switching between Claude and GLM models without breaking active sessions.

**New in v2.1:** Profile groups (launch multiple profiles at once) and update checker!

**New in v2.0:** Profile management, aliases, workspace profiles, session tracking, logging, backups, and much more!

## The Problem

When using Claude Code with multiple simultaneous sessions, changing the global configuration (e.g., switching from Claude to GLM) breaks all existing sessions. This happens because all sessions read from the same config file.

## The Solution

`claude-switcher` solves this by:
- Storing multiple model profiles (Claude, GLM, custom models)
- Launching each session with isolated environment variables
- Allowing multiple sessions with different models to run simultaneously
- No manual config file editing required

## Features

### Core Features
✨ **Profile Management** - Store and manage multiple API configurations
🚀 **Session Isolation** - Run Claude and GLM sessions simultaneously
🔧 **Easy Switching** - One command to launch with any profile
🔐 **Secure** - Credentials stored locally in `~/.claude-switcher/`
🌍 **Cross-Platform** - Works on macOS and Linux

### New in v2.1
👥 **Profile Groups** - Launch multiple profiles simultaneously
🔄 **Update Checker** - Check for new versions from GitHub

### New in v2.0
🎯 **Profile Aliases** - Create short aliases for frequently used profiles
📁 **Workspace Profiles** - Auto-select profiles based on current directory
👁️ **Environment Viewer** - See exactly what env vars will be set
✅ **Profile Validation** - Verify your profiles before launching
📤 **Import/Export** - Share profiles with your team
🔄 **Clone Profiles** - Duplicate profiles for testing
💾 **Backup/Restore** - Never lose your configuration
📊 **Session Tracking** - Monitor and manage active sessions
📝 **Activity Logging** - Track usage and debug issues
📈 **Usage Statistics** - See which profiles you use most

## Installation

### Prerequisites

- Python 3.6+
- Claude Code CLI installed

### Install

**Method 1: Clone & Install (Recommended)**

```bash
# Clone this repository
git clone git@github.com:rolan86/claude-code-switcher.git
cd claude-code-switcher

# Run installer
./install.sh

# Verify installation
claude-switcher help
```

**Method 2: Manual Installation**

```bash
# Download the script directly (no git required)
curl -O https://raw.githubusercontent.com/rolan86/claude-code-switcher/main/claude-switcher

# Make it executable and move to PATH
chmod +x claude-switcher
sudo mv claude-switcher /usr/local/bin/

# Verify
claude-switcher help
```

**Troubleshooting Installation**

If you get "command not found" after installation:

1. Check if `/usr/local/bin` is in your PATH:
   ```bash
   echo $PATH | grep /usr/local/bin
   ```

2. If not, add it to your shell profile:
   ```bash
   # For macOS (zsh)
   echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc
   source ~/.zshrc

   # For Linux (bash)
   echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bashrc
   source ~/.bashrc
   ```

3. Verify Python 3 is installed:
   ```bash
   python3 --version
   ```

## Quick Start

### 1. Create Profiles

**For Claude:**

```bash
claude-switcher profile add claude
# Enter your Anthropic API key
# Press Enter for default base URL
# Optionally specify model mappings
```

**For GLM (Z.AI):**

```bash
claude-switcher profile add glm
# Enter your Z.AI API key
# Base URL: https://api.z.ai/api/anthropic
# Sonnet model: GLM-4.6
# Haiku model: GLM-4.5-Air
```

### 2. Launch Sessions

```bash
# Launch with Claude profile (Terminal 1)
claude-switcher start claude

# Launch with GLM profile (Terminal 2) - Claude session keeps working!
claude-switcher start glm

# Launch with default profile
claude-switcher start
```

### 3. Manage Profiles

```bash
# List all profiles
claude-switcher profile list

# Set default profile
claude-switcher profile default glm

# Remove a profile
claude-switcher profile remove old-profile
```

## Usage

### Quick Reference

```bash
# Basic commands
claude-switcher start [profile]          # Launch session
claude-switcher profile list             # List profiles
claude-switcher help                     # Show help
claude-switcher version                  # Show version

# Profile management
claude-switcher profile add <name>       # Add profile
claude-switcher profile remove <name>    # Remove profile
claude-switcher profile clone <src> <dst># Clone profile
claude-switcher profile validate <name>  # Validate profile
claude-switcher profile env <name>       # Show env vars
claude-switcher profile export <name>    # Export to JSON
claude-switcher profile import <file>    # Import from JSON

# Aliases
claude-switcher alias add <alias> <prof> # Create alias
claude-switcher alias list               # List aliases
claude-switcher alias remove <alias>     # Remove alias

# Groups
claude-switcher group create <name> <p...> # Create group
claude-switcher group add <group> <prof> # Add to group
claude-switcher group remove <grp> <prf> # Remove from group
claude-switcher group delete <name>      # Delete group
claude-switcher group list               # List groups
claude-switcher group start <name>       # Launch all in group

# Workspace
claude-switcher workspace init <profile> # Set workspace default
claude-switcher workspace remove         # Remove workspace config

# Sessions
claude-switcher session list             # List active sessions
claude-switcher session kill <pid>       # Kill a session

# Backup & Restore
claude-switcher backup create            # Backup configuration
claude-switcher backup list              # List backups
claude-switcher backup restore <file>    # Restore from backup

# Logs & Stats
claude-switcher logs show [limit]        # Show activity log
claude-switcher logs stats               # Usage statistics
claude-switcher logs clear               # Clear logs

# Update
claude-switcher update check             # Check for new version
```

### Profile Configuration

Profiles are stored in `~/.claude-switcher/profiles.json`:

```json
{
  "profiles": {
    "claude": {
      "api_key": "sk-ant-xxx",
      "base_url": "https://api.anthropic.com",
      "models": {
        "haiku": "claude-3-5-haiku-20241022",
        "sonnet": "claude-sonnet-4-5-20250929",
        "opus": "claude-opus-4-20250514"
      }
    },
    "glm": {
      "api_key": "xxx",
      "base_url": "https://api.z.ai/api/anthropic",
      "models": {
        "haiku": "GLM-4.5-Air",
        "sonnet": "GLM-4.6",
        "opus": "GLM-4.6"
      }
    }
  },
  "default_profile": "claude"
}
```

## How It Works

`claude-switcher` sets environment variables before launching Claude Code:

- `ANTHROPIC_API_KEY` - Your API key
- `ANTHROPIC_BASE_URL` - Custom endpoint (for GLM, etc.)
- `ANTHROPIC_DEFAULT_SONNET_MODEL` - Override Sonnet model
- `ANTHROPIC_DEFAULT_HAIKU_MODEL` - Override Haiku model
- `ANTHROPIC_DEFAULT_OPUS_MODEL` - Override Opus model

Each session gets its own environment, so they don't interfere with each other.

## Examples

### Running Multiple Sessions

```bash
# Terminal 1: Claude Sonnet 4.5
claude-switcher start claude

# Terminal 2: GLM-4.6
claude-switcher start glm

# Terminal 3: Custom profile
claude-switcher start my-custom-model
```

### Using Aliases for Quick Access

```bash
# Create short aliases
claude-switcher alias add c claude
claude-switcher alias add g glm

# Now use them
claude-switcher start c    # Launches Claude profile
claude-switcher start g    # Launches GLM profile

# List all aliases
claude-switcher alias list
```

### Using Profile Groups

```bash
# Create a group for side-by-side comparison
claude-switcher group create comparison claude glm

# Launch all profiles in the group (opens multiple terminals)
claude-switcher group start comparison

# Create a work group
claude-switcher group create work claude-work glm-work custom

# Add another profile to an existing group
claude-switcher group add work test-profile

# Remove a profile from a group
claude-switcher group remove work test-profile

# List all groups
claude-switcher group list
# Output:
# === Profile Groups ===
#
# • comparison
#   Profiles: claude, glm
#   Created: 2025-11-07T15:30:00
#
# • work
#   Profiles: claude-work, glm-work, custom
#   Created: 2025-11-07T15:35:00

# Delete a group
claude-switcher group delete comparison
```

### Workspace-Specific Profiles

```bash
# Set up a project to always use GLM
cd ~/my-glm-project
claude-switcher workspace init glm

# Now starting without specifying a profile uses GLM
claude-switcher start

# Different project, different model
cd ~/my-claude-project
claude-switcher workspace init claude
claude-switcher start    # Uses Claude automatically
```

### Profile Management

```bash
# Clone a profile for testing
claude-switcher profile clone claude claude-experimental

# Validate before using
claude-switcher profile validate claude-experimental

# See what environment variables will be set
claude-switcher profile env claude-experimental

# Export profile to share with team
claude-switcher profile export claude team-claude-profile.json

# Import a profile from teammate
claude-switcher profile import team-profile.json shared-claude
```

### Session Management

```bash
# Launch a session
claude-switcher start glm

# In another terminal, view active sessions
claude-switcher session list
# Output:
# === Active Sessions ===
#
# • PID: 12345
#   Profile: glm
#   Started: 2025-11-07T10:30:00
#   Directory: /home/user/projects/my-app

# Kill a session if needed
claude-switcher session kill 12345
```

### Backup and Restore

```bash
# Create a backup before making changes
claude-switcher backup create
# Output: ✓ Configuration backed up to ~/.claude-switcher/backups/backup_20251107_143000.json

# List all backups
claude-switcher backup list

# Restore from a backup
claude-switcher backup restore ~/.claude-switcher/backups/backup_20251107_143000.json
```

### Logging and Statistics

```bash
# View recent activity
claude-switcher logs show 20

# See usage statistics
claude-switcher logs stats
# Output:
# === Usage Statistics ===
#
# Total sessions: 47
#
# Sessions by profile:
#   glm: 28 (59.6%)
#   claude: 15 (31.9%)
#   custom: 4 (8.5%)

# Clear old logs
claude-switcher logs clear
```

### Checking for Updates

```bash
# Check if a newer version is available
claude-switcher update check
# Output:
# ✓ You're using the latest version (v2.1.0)
#
# Or if an update is available:
# 🎉 New version available!
#    Current: v2.1.0
#    Latest:  v2.2.0
#
#    Release notes: https://github.com/rolan86/claude-code-switcher/releases/latest
#    Update: git pull origin main && ./install.sh
```

### Creating a Custom Profile

```bash
claude-switcher profile add deepseek
# API Key: your-deepseek-key
# Base URL: https://api.deepseek.com/compatible/anthropic
# Models: (specify your model names)
```

### Passing Additional Arguments

```bash
# Launch with specific model override
claude-switcher start glm --model GLM-4.5-Air

# Launch in specific directory
cd ~/my-project && claude-switcher start claude
```

## Troubleshooting

### "claude command not found"

Make sure Claude Code CLI is installed and in your PATH:

```bash
which claude
# Should return: /path/to/claude
```

### Session Still Uses Wrong Model

1. Check your profile configuration: `claude-switcher profile list`
2. Verify environment variables are set: add `echo $ANTHROPIC_BASE_URL` in the session
3. Try removing `~/.claude/settings.json` if it has conflicting settings

### API Authentication Issues

Use `/status` command in Claude Code to check which credentials are active:

```
/status
```

This shows whether you're using API key or subscription authentication.

## Contributing

Contributions welcome! Please open an issue or PR.

## License

MIT License - see [LICENSE](LICENSE)

## Credits

Created to solve the pain of switching between Claude and GLM models in Claude Code.

## Data Storage

Claude Code Switcher stores all its data in `~/.claude-switcher/`:

```
~/.claude-switcher/
├── profiles.json      # Your profile configurations
├── aliases.json       # Profile aliases
├── groups.json        # Profile groups
├── sessions.json      # Active session tracking
├── logs/              # Activity logs
│   └── activity_YYYYMM.log
└── backups/           # Configuration backups
    └── backup_YYYYMMDD_HHMMSS.json
```

Additionally, workspace-specific configurations are stored in `.claude-switcher.json` in each project directory.

### Uninstalling

To completely remove Claude Code Switcher:

```bash
# Run the uninstall script
./uninstall.sh

# Or manually:
sudo rm /usr/local/bin/claude-switcher
rm -rf ~/.claude-switcher/
```

## Changelog

### v2.1.0 (2025-11-07)

**New Features:**
- Profile Groups: Create groups of profiles and launch them simultaneously
  - `group create` - Create a new group
  - `group add/remove` - Manage profiles in groups
  - `group start` - Launch all profiles in a group
  - `group list` - View all configured groups
- Update Checker: Check for new versions from GitHub
  - `update check` - Check if a newer version is available

**Improvements:**
- Enhanced help documentation with group commands
- Better terminal detection for launching multiple sessions
- Version bumped to 2.1.0

### v2.0.0 (2025-11-07)

**Major Features:**
- Profile aliases for quick access
- Workspace-specific profiles
- Profile import/export for team sharing
- Profile cloning and validation
- Environment variable viewer
- Session tracking and management
- Activity logging
- Usage statistics
- Backup and restore functionality
- Enhanced help documentation

**Technical Improvements:**
- Complete code restructuring with manager classes
- Better error handling
- Comprehensive validation

### v1.0.0

- Initial release
- Basic profile management
- Session isolation
- Multi-model support

## Resources

- [Claude Code Documentation](https://docs.claude.com/claude-code)
- [Z.AI GLM Integration Guide](https://docs.z.ai)
- [Anthropic API Reference](https://docs.anthropic.com)

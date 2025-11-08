# Claude Code Switcher v2.2

A powerful CLI tool to manage multiple model profiles and launch isolated Claude Code sessions. Perfect for switching between Claude and GLM models without breaking active sessions.

**New in v2.2:** Profile templates, health checks, and model auto-update!

**Also in v2.1:** Profile groups (launch multiple profiles at once) and automatic update checker!

**Also in v2.0:** Profile management, aliases, workspace profiles, session tracking, logging, backups, and much more!

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

### New in v2.2
📋 **Profile Templates** - Quick setup with pre-configured templates for common providers
🏥 **Health Checks** - Test profile connectivity before launching sessions
🔄 **Model Auto-Update** - Update profiles to latest model versions

### Also in v2.1
🎭 **Profile Groups** - Launch multiple profiles simultaneously with one command
🔔 **Update Checker** - Automatic daily checks for new versions

### Also in v2.0
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

# Templates (NEW in v2.2)
claude-switcher template list                # List all templates
claude-switcher template show <template>     # Show template details
claude-switcher template use <template> <name>  # Create from template

# Models (NEW in v2.2)
claude-switcher models list [--provider]     # List available models
claude-switcher models update <profile>      # Update to latest models
claude-switcher profile test <name>          # Test profile connectivity
claude-switcher profile test --all           # Test all profiles

# Groups (NEW in v2.1)
claude-switcher group add <name> --profiles <p1,p2,...>  # Create group
claude-switcher group launch <name>                      # Launch group
claude-switcher group list                               # List groups
claude-switcher group remove <name>                      # Remove group

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

# Updates (NEW in v2.1)
claude-switcher update check             # Check for new versions
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

### Quick Setup with Templates (NEW in v2.2)

Templates make it easy to get started with popular providers:

```bash
# List available templates
claude-switcher template list
# Output:
# === Available Profile Templates ===
#
# • anthropic
#   Name: Anthropic Claude
#   Description: Official Anthropic API with latest Claude models
#   Base URL: https://api.anthropic.com
#   Models: haiku, sonnet, opus
#
# • zai-glm
#   Name: Z.AI GLM
#   Description: Z.AI GLM models via Anthropic-compatible API
#   Base URL: https://api.z.ai/api/anthropic
#   Models: haiku, sonnet, opus
#
# • deepseek
#   Name: DeepSeek
#   Description: DeepSeek AI models
#   Base URL: https://api.deepseek.com
#   Models: sonnet

# View template details
claude-switcher template show anthropic

# Create a profile from a template - only asks for API key!
claude-switcher template use anthropic my-claude
# Enter your API key: sk-ant-...
# ✓ Profile 'my-claude' created successfully!

# Create GLM profile just as easily
claude-switcher template use zai-glm glm
# Enter your API key: ...
# ✓ Profile 'glm' created successfully!
```

### Health Checks (NEW in v2.2)

Test profiles before launching to catch issues early:

```bash
# Test a single profile
claude-switcher profile test my-claude
# Output:
# === Testing profile: my-claude ===
#
# ✓ API Key: Present (48 characters)
# ✓ Base URL: https://api.anthropic.com
# ✓ Models: 3 configured
#
# ✓ Profile configuration is valid

# Test with verbose mode to check API connectivity
claude-switcher profile test my-claude --verbose
# Also tests actual API connection

# Test all profiles at once
claude-switcher profile test --all
# Output:
# === Testing 3 profile(s) ===
#
# [Tests each profile...]
#
# === Summary ===
# Passed: 2/3
#
# Failed profiles:
#   • old-profile
```

### Model Auto-Update (NEW in v2.2)

Keep your profiles up-to-date with the latest models:

```bash
# List available models
claude-switcher models list
# Output:
# === Available Models (anthropic) ===
#
#   haiku: claude-3-5-haiku-20241022
#   sonnet: claude-sonnet-4-5-20250929
#   opus: claude-opus-4-20250514

# List models for other providers
claude-switcher models list --provider zai
# Output:
# === Available Models (zai) ===
#
#   haiku: GLM-4.5-Air
#   sonnet: GLM-4.6
#   opus: GLM-4.6

# Preview what would change (dry run)
claude-switcher profile update-models my-claude --dry-run
# Shows what models would be updated

# Update profile to latest models
claude-switcher profile update-models my-claude
# Output:
# === Updating models for profile: my-claude ===
#
# Changes made:
#   haiku:
#     Old: claude-3-haiku-20240307
#     New: claude-3-5-haiku-20241022
#   sonnet:
#     Old: claude-3-5-sonnet-20241022
#     New: claude-sonnet-4-5-20250929
#
# ✓ Profile 'my-claude' updated with latest anthropic models

# Update with specific provider
claude-switcher models update glm --provider zai
```

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

### Using Profile Groups (NEW in v2.1)

Profile groups let you launch multiple profiles at once - perfect for workflows that need multiple models running simultaneously.

```bash
# Create a development group with multiple profiles
claude-switcher group add development \
  --profiles claude,glm \
  --desc "Development environment with both models"

# Launch all profiles in the group at once
claude-switcher group launch development
# This opens separate Claude Code sessions for both Claude and GLM

# List all groups
claude-switcher group list
# Output:
# === Profile Groups ===
#
# • development
#   Description: Development environment with both models
#   Profiles: claude, glm
#   Created: 2025-11-08T...

# View active sessions
claude-switcher session list
# Output:
# === Active Sessions ===
#
# • PID: 12345
#   Profile: development:claude
#   Started: 2025-11-08T10:30:00
#   Directory: /home/user/projects/my-app
#
# • PID: 12346
#   Profile: development:glm
#   Started: 2025-11-08T10:30:01
#   Directory: /home/user/projects/my-app

# Remove a group when no longer needed
claude-switcher group remove development
```

**Common use cases for groups:**
- **Multi-model testing**: Compare responses from Claude and GLM side-by-side
- **Project workflows**: Launch all tools needed for a specific project
- **Team environments**: Share group configurations across your team
- **Development contexts**: Different groups for frontend, backend, testing, etc.

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

### Checking for Updates (NEW in v2.1)

Claude Code Switcher automatically checks for updates once per day when you run `claude-switcher start`. You can also manually check for updates:

```bash
# Check for new versions
claude-switcher update check

# If an update is available, you'll see:
# ============================================================
# 🎉 Update Available!
# ============================================================
# Current version: v2.0.0
# Latest version:  v2.1.0
#
# Release URL: https://github.com/rolan86/claude-code-switcher/releases/tag/v2.1.0
#
# Release Notes:
# - Added profile groups for launching multiple profiles at once
# - Added automatic update checker
# ...
#
# To update, run:
#   cd ~/claude-code-switcher
#   git pull origin main
#   ./install.sh
# ============================================================

# If you're up to date:
# ✓ You're running the latest version (v2.1.0)
```

**How it works:**
- Automatic check runs once per day when you use `claude-switcher start`
- Only shows a notification if an update is available
- Manual check with `claude-switcher update check` shows full details
- Checks are lightweight and don't slow down the CLI

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
├── groups.json        # Profile groups (NEW in v2.1)
├── sessions.json      # Active session tracking
├── logs/              # Activity logs
│   └── activity_YYYYMM.log
├── backups/           # Configuration backups
│   └── backup_YYYYMMDD_HHMMSS.json
└── .last_update_check # Last update check timestamp (NEW in v2.1)
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

### v2.2.0 (2025-11-08)

**Major Features:**
- **Profile Templates**: Quick setup with pre-configured templates
  - Built-in templates for Anthropic, Z.AI GLM, and DeepSeek
  - Create profiles with just an API key - no manual configuration
  - `template list`, `template show`, and `template use` commands
  - Reduces onboarding friction for new users
- **Profile Health Checks**: Test profiles before launching
  - Validate API keys, base URLs, and model configurations
  - Optional verbose mode to test actual API connectivity
  - Test individual profiles or all profiles at once
  - Catch configuration issues early
- **Model Auto-Update**: Keep profiles current with latest models
  - List available models for different providers
  - Update profile models to latest versions
  - Dry-run mode to preview changes
  - Supports Anthropic and Z.AI providers

**Technical Improvements:**
- Added TemplateManager class with built-in templates
- Added ProfileHealthChecker class with API connectivity testing
- Added ModelUpdater class with provider-specific model mappings
- Enhanced profile management with test and update-models subcommands
- Improved error handling and validation throughout

**Co-authored-by:** GitHub User (requested co-authorship)

### v2.1.0 (2025-11-08)

**Major Features:**
- **Profile Groups**: Launch multiple profiles simultaneously with one command
  - Create groups with `group add <name> --profiles <p1,p2,...>`
  - Launch all profiles in a group with `group launch <name>`
  - Track group sessions separately
  - Perfect for multi-model testing and workflows
- **Update Checker**: Automatic version checking
  - Checks for updates once per day on `start` command
  - Manual check with `update check` command
  - Shows release notes and update instructions
  - Non-intrusive notifications

**Technical Improvements:**
- Added GroupManager class for group operations
- Added UpdateChecker class with GitHub API integration
- Enhanced session tracking to support group launches
- Improved logging with group session events

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

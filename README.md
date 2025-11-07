# Claude Code Switcher

A lightweight CLI tool to manage multiple model profiles and launch isolated Claude Code sessions. Perfect for switching between Claude and GLM models without breaking active sessions.

## The Problem

When using Claude Code with multiple simultaneous sessions, changing the global configuration (e.g., switching from Claude to GLM) breaks all existing sessions. This happens because all sessions read from the same config file.

## The Solution

`claude-switcher` solves this by:
- Storing multiple model profiles (Claude, GLM, custom models)
- Launching each session with isolated environment variables
- Allowing multiple sessions with different models to run simultaneously
- No manual config file editing required

## Features

✨ **Profile Management** - Store multiple API configurations
🚀 **Session Isolation** - Run Claude and GLM sessions simultaneously
🔧 **Easy Switching** - One command to launch with any profile
🔐 **Secure** - Credentials stored locally in `~/.claude-switcher/`
🌍 **Cross-Platform** - Works on macOS and Linux

## Installation

### Prerequisites

- Python 3.6+
- Claude Code CLI installed

### Install

```bash
# Clone this repository
git clone https://github.com/yourusername/claude-code-switcher.git
cd claude-code-switcher

# Run installer
chmod +x install.sh
./install.sh
```

Or manually:

```bash
# Copy to PATH
sudo cp claude-switcher /usr/local/bin/
sudo chmod +x /usr/local/bin/claude-switcher
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

### Commands

```bash
claude-switcher start [profile] [--args]    # Launch session with profile
claude-switcher profile add <name>          # Add new profile
claude-switcher profile list                # List all profiles
claude-switcher profile remove <name>       # Remove profile
claude-switcher profile default <name>      # Set default profile
claude-switcher help                        # Show help
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

## Resources

- [Claude Code Documentation](https://docs.claude.com/claude-code)
- [Z.AI GLM Integration Guide](https://docs.z.ai)
- [Anthropic API Reference](https://docs.anthropic.com)

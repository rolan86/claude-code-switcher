# Quick Start Guide - v2.0

## 5-Minute Setup

**New in v2.0:** More features below! Aliases, workspace profiles, logging, and more.

### 1. Install (already done!)
```bash
cd claude-code-switcher
./install.sh
```

### 2. Add Your Profiles

**For Claude (Anthropic):**
```bash
claude-switcher profile add claude
# API Key: your-anthropic-key (or skip if using subscription)
# Base URL: [press Enter]
# Models: [press Enter to skip]
```

**For GLM (Z.AI):**
```bash
claude-switcher profile add glm
# API Key: your-zai-key
# Base URL: https://api.z.ai/api/anthropic
# Sonnet model: GLM-4.6
# Haiku model: GLM-4.5-Air
```

### 3. Launch Sessions

```bash
# Terminal 1: Regular Claude
claude

# Terminal 2: GLM (doesn't break Terminal 1!)
claude-switcher start glm

# Terminal 3: Claude again
claude-switcher start claude
```

### 4. Verify It Works

In each terminal, run:
```
/status
```

You should see different configurations in each session!

## Common Commands

```bash
# List profiles
claude-switcher profile list

# Set default
claude-switcher profile default glm

# Remove profile
claude-switcher profile remove old-profile

# Launch with profile
claude-switcher start <profile-name>

# Get help
claude-switcher help
```

## Key Point

- Use `claude` for your default global config (Anthropic)
- Use `claude-switcher start <profile>` for other models (GLM, custom)
- Each session is isolated - they won't interfere!

## New in v2.0 - Quick Tips

```bash
# Create aliases for faster access
claude-switcher alias add c claude
claude-switcher start c  # Much faster!

# Set up workspace profiles (auto-select per project)
cd ~/my-project
claude-switcher workspace init glm
claude-switcher start  # Automatically uses glm!

# View usage statistics
claude-switcher logs stats

# Backup your configuration
claude-switcher backup create

# See all commands
claude-switcher help
```

**See README.md for complete documentation and TESTING_GUIDE.md for testing instructions.**

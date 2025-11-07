# Quick Start Guide

## 5-Minute Setup

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

**See TESTING_GUIDE.md for detailed testing instructions.**

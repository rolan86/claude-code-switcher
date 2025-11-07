# Testing Guide for claude-switcher

## ✅ Automated Tests Passed

The tool has been tested and verified working:
- ✓ Installation successful
- ✓ Profile management (add, list, remove, default)
- ✓ Configuration storage
- ✓ Help commands

## 🧪 Now Test With Your Real Credentials

### Prerequisites

1. **Claude Code CLI installed** - Run `which claude` to verify
2. **Anthropic API key** (optional if you have a claude.ai subscription)
3. **Z.AI/GLM API key** (if you want to test GLM)

### Testing Workflow

#### Test 1: Add Your Claude Profile

```bash
# Add Claude profile
claude-switcher profile add claude

# When prompted:
# - API Key: [Enter your Anthropic API key, or press Enter to skip]
# - Base URL: [Just press Enter for default]
# - Haiku model: [Press Enter to skip or enter: claude-3-5-haiku-20241022]
# - Sonnet model: [Press Enter to skip or enter: claude-sonnet-4-5-20250929]
# - Opus model: [Press Enter to skip]
```

#### Test 2: Add Your GLM Profile

```bash
# Add GLM profile
claude-switcher profile add glm

# When prompted:
# - API Key: [Enter your Z.AI API key]
# - Base URL: https://api.z.ai/api/anthropic
# - Haiku model: GLM-4.5-Air
# - Sonnet model: GLM-4.6
# - Opus model: GLM-4.6
```

#### Test 3: Verify Profiles

```bash
# List all profiles
claude-switcher profile list

# Should show both profiles with their configurations
```

#### Test 4: Launch Regular Claude Session

Open a new terminal (Terminal 1):

```bash
# Launch normal Claude Code (using your global config)
claude

# Inside the session, run:
/status

# Should show your global Anthropic configuration
```

Keep this session running!

#### Test 5: Launch GLM Session (The Big Test!)

Open another terminal (Terminal 2):

```bash
# Launch with GLM profile
claude-switcher start glm

# Inside the session, run:
/status

# Should show:
# - Z.AI endpoint
# - GLM model configuration
```

#### Test 6: Verify Isolation

**In Terminal 1** (regular Claude session):
```
/status
```
Should STILL show Anthropic config (not affected by GLM session!)

**In Terminal 2** (GLM session):
```
/status
```
Should show Z.AI/GLM config

#### Test 7: Launch Another Claude Session

Open a third terminal (Terminal 3):

```bash
# Launch with Claude profile explicitly
claude-switcher start claude

# Or use regular command
claude

# Inside session:
/status

# Should show Anthropic config
```

### Expected Results

At this point you should have:

- **Terminal 1**: Regular Claude session (global config)
- **Terminal 2**: GLM session (using Z.AI)
- **Terminal 3**: Another Claude session

All three should be running simultaneously without interfering with each other!

### Verification Checklist

- [ ] `claude-switcher profile list` shows all profiles
- [ ] Can launch regular `claude` command (uses global config)
- [ ] Can launch `claude-switcher start glm` (uses GLM)
- [ ] Can run both simultaneously
- [ ] `/status` in each session shows correct configuration
- [ ] Switching between sessions doesn't break anything

### Troubleshooting

#### Error: "claude command not found"

Make sure Claude Code CLI is installed:
```bash
# Check if installed
which claude

# If not found, install Claude Code first
```

#### Error: Profile not using correct model

Check environment variables are being set:
```bash
# Before launching, test environment setup
claude-switcher start glm
# Watch the output for environment variable info
```

#### Sessions still interfering

1. Make sure you're using `claude-switcher start <profile>` not just `claude`
2. Check `~/.claude/settings.json` doesn't have hardcoded settings that override env vars
3. Try closing all Claude sessions and starting fresh

### Advanced Testing

#### Test Model Switching Mid-Session

In a session launched with `claude-switcher start glm`:
```
/model
```
Should show GLM models as options

#### Test Default Profile

```bash
# Set GLM as default
claude-switcher profile default glm

# Launch without specifying profile
claude-switcher start

# Should use GLM
```

#### Test Passing Additional Arguments

```bash
# Launch with custom arguments
claude-switcher start claude --help
```

## 📝 Report Issues

If you encounter any issues during testing:

1. Check `~/.claude-switcher/profiles.json` for your configurations
2. Run `/status` in Claude Code sessions to see actual config being used
3. Note any error messages
4. Try the troubleshooting steps above

## ✨ Success Criteria

You'll know it's working when:

1. ✅ You can add and manage multiple profiles
2. ✅ You can launch multiple sessions with different models
3. ✅ Each session maintains its own configuration
4. ✅ Sessions don't interfere with each other
5. ✅ You can mix `claude` and `claude-switcher start` commands

Ready to test? Start with **Test 1** above! 🚀

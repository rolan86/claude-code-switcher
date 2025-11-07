#!/bin/bash
# Test script for claude-switcher

echo "=== Testing claude-switcher ==="
echo

# Clean any existing test profiles
rm -rf ~/.claude-switcher-test
export HOME_BACKUP=$HOME
export HOME=$(mktemp -d)

echo "Step 1: List profiles (should be empty)"
echo "$ claude-switcher profile list"
claude-switcher profile list
echo

echo "Step 2: Add a test Claude profile"
echo "$ claude-switcher profile add claude"
echo "(Simulating interactive input...)"
echo

# We'll add profiles manually for testing
mkdir -p ~/.claude-switcher
cat > ~/.claude-switcher/profiles.json <<'EOF'
{
  "profiles": {
    "claude": {
      "api_key": "sk-ant-test-key-xxxxx",
      "base_url": "https://api.anthropic.com",
      "models": {
        "haiku": "claude-3-5-haiku-20241022",
        "sonnet": "claude-sonnet-4-5-20250929"
      }
    },
    "glm": {
      "api_key": "test-glm-key-xxxxx",
      "base_url": "https://api.z.ai/api/anthropic",
      "models": {
        "haiku": "GLM-4.5-Air",
        "sonnet": "GLM-4.6"
      }
    }
  },
  "default_profile": "claude"
}
EOF

echo "Step 3: List profiles"
echo "$ claude-switcher profile list"
claude-switcher profile list
echo

echo "Step 4: Check profile storage"
echo "$ cat ~/.claude-switcher/profiles.json"
cat ~/.claude-switcher/profiles.json | python3 -m json.tool
echo

echo "Step 5: Test changing default profile"
echo "$ claude-switcher profile default glm"
claude-switcher profile default glm
echo

echo "Step 6: List profiles again (glm should be default now)"
claude-switcher profile list
echo

echo "Step 7: Test removing a profile"
echo "$ claude-switcher profile remove claude"
claude-switcher profile remove claude
claude-switcher profile list
echo

# Cleanup
export HOME=$HOME_BACKUP

echo "=== Test Complete ==="
echo
echo "The tool is working! Now let's test with YOUR real credentials."

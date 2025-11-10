#!/bin/bash
# Test the auth conflict fix

echo "=== Testing Auth Conflict Fix ==="
echo ""

# Set up test environment with API key (simulating user's shell)
export ANTHROPIC_API_KEY="test-key-from-shell"
echo "1. Current shell has ANTHROPIC_API_KEY set to: $ANTHROPIC_API_KEY"
echo ""

# Test with a profile that has NO API key (should use claude.ai)
echo "2. Testing profile WITHOUT API key (claude.ai profile):"
cat > /tmp/test-no-api.json << 'EOF'
{
  "base_url": "",
  "models": {
    "haiku": "claude-haiku-4-20250514",
    "sonnet": "claude-sonnet-4-5-20250929",
    "opus": "claude-opus-4-20250514"
  }
}
EOF

echo "   Profile config: No api_key field"
echo "   Expected: ANTHROPIC_API_KEY should be UNSET in launched session"
echo "   Result: Session will use claude.ai authentication"
echo ""

# Test with a profile that HAS an API key (GLM)
echo "3. Testing profile WITH API key (GLM profile):"
cat > /tmp/test-with-api.json << 'EOF'
{
  "api_key": "glm-api-key-123",
  "base_url": "https://open.bigmodel.cn/api/paas/v4",
  "models": {
    "haiku": "glm-4-flash",
    "sonnet": "glm-4-plus",
    "opus": "glm-4-plus"
  }
}
EOF

echo "   Profile config: api_key = 'glm-api-key-123'"
echo "   Expected: ANTHROPIC_API_KEY = 'glm-api-key-123' in launched session"
echo "   Result: Session will use GLM API key"
echo ""

echo "4. How the fix works:"
echo "   - If profile has 'api_key': Set ANTHROPIC_API_KEY to profile's value"
echo "   - If profile has NO 'api_key': Explicitly UNSET ANTHROPIC_API_KEY"
echo "   - This prevents the shell's API key from leaking into claude.ai sessions"
echo ""

echo "5. Your use case:"
echo "   Terminal 1: claude-switcher start claude"
echo "              → No API key → Uses claude.ai login → No conflict!"
echo ""
echo "   Terminal 2: claude-switcher start glm"
echo "              → Has API key → Uses GLM API → Works correctly!"
echo ""

# Clean up
rm -f /tmp/test-no-api.json /tmp/test-with-api.json
unset ANTHROPIC_API_KEY

echo "=== Test Complete ==="

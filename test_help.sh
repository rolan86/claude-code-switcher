#!/bin/bash
# Test all help messages and command handlers
# This script tests every command to ensure error messages are consistent

SCRIPT="./claude-switcher"

echo "=== Testing Claude Switcher Help Commands ==="
echo ""

# Test main commands
echo "1. Testing main help..."
$SCRIPT help > /dev/null 2>&1 && echo "✓ help works" || echo "✗ help failed"

echo "2. Testing version..."
$SCRIPT version > /dev/null 2>&1 && echo "✓ version works" || echo "✗ version failed"

# Test profile commands with errors
echo ""
echo "3. Testing profile subcommands..."
echo "   - Testing profile without subcommand:"
$SCRIPT profile 2>&1 | grep -q "add|list|remove|default|clone|export|import|validate|env|test|update-models" && echo "   ✓ Shows all subcommands" || echo "   ✗ Missing subcommands in error message"

echo "   - Testing profile with invalid subcommand:"
$SCRIPT profile invalid 2>&1 | head -1

# Test template commands
echo ""
echo "4. Testing template subcommands..."
echo "   - Testing template without subcommand:"
$SCRIPT template 2>&1 | head -2

echo "   - Testing template with invalid subcommand:"
$SCRIPT template invalid 2>&1 | head -1

# Test models commands
echo ""
echo "5. Testing models subcommands..."
echo "   - Testing models without subcommand:"
$SCRIPT models 2>&1 | head -2

echo "   - Testing models with invalid subcommand:"
$SCRIPT models invalid 2>&1 | head -1

# Test alias commands
echo ""
echo "6. Testing alias subcommands..."
echo "   - Testing alias without subcommand:"
$SCRIPT alias 2>&1 | head -2

echo "   - Testing alias with invalid subcommand:"
$SCRIPT alias invalid 2>&1 | head -1

# Test group commands
echo ""
echo "7. Testing group subcommands..."
echo "   - Testing group without subcommand:"
$SCRIPT group 2>&1 | head -2

echo "   - Testing group with invalid subcommand:"
$SCRIPT group invalid 2>&1 | head -1

# Test session commands
echo ""
echo "8. Testing session subcommands..."
echo "   - Testing session without subcommand:"
$SCRIPT session 2>&1 | head -2

echo "   - Testing session with invalid subcommand:"
$SCRIPT session invalid 2>&1 | head -1

# Test workspace commands
echo ""
echo "9. Testing workspace subcommands..."
echo "   - Testing workspace without subcommand:"
$SCRIPT workspace 2>&1 | head -2

echo "   - Testing workspace with invalid subcommand:"
$SCRIPT workspace invalid 2>&1 | head -1

# Test backup commands
echo ""
echo "10. Testing backup subcommands..."
echo "   - Testing backup without subcommand:"
$SCRIPT backup 2>&1 | head -2

echo "   - Testing backup with invalid subcommand:"
$SCRIPT backup invalid 2>&1 | head -1

# Test logs commands
echo ""
echo "11. Testing logs subcommands..."
echo "   - Testing logs without subcommand:"
$SCRIPT logs 2>&1 | head -2

echo "   - Testing logs with invalid subcommand:"
$SCRIPT logs invalid 2>&1 | head -1

# Test update commands
echo ""
echo "12. Testing update subcommands..."
echo "   - Testing update without subcommand:"
$SCRIPT update 2>&1 | head -2

echo "   - Testing update with invalid subcommand:"
$SCRIPT update invalid 2>&1 | head -1

# Test invalid top-level command
echo ""
echo "13. Testing invalid top-level command..."
$SCRIPT remove 2>&1 | head -2

echo ""
echo "=== Testing Complete ==="

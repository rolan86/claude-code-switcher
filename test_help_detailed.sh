#!/bin/bash
# Detailed test to verify all error messages show usage information

SCRIPT="./claude-switcher"

echo "=== Detailed Help Command Testing ==="
echo ""

echo "Testing profile with invalid subcommand:"
$SCRIPT profile invalid 2>&1
echo ""

echo "Testing template with invalid subcommand:"
$SCRIPT template invalid 2>&1
echo ""

echo "Testing models with invalid subcommand:"
$SCRIPT models invalid 2>&1
echo ""

echo "Testing alias with invalid subcommand:"
$SCRIPT alias invalid 2>&1
echo ""

echo "Testing group with invalid subcommand:"
$SCRIPT group invalid 2>&1
echo ""

echo "Testing session with invalid subcommand:"
$SCRIPT session invalid 2>&1
echo ""

echo "Testing workspace with invalid subcommand:"
$SCRIPT workspace invalid 2>&1
echo ""

echo "Testing backup with invalid subcommand:"
$SCRIPT backup invalid 2>&1
echo ""

echo "Testing logs with invalid subcommand:"
$SCRIPT logs invalid 2>&1
echo ""

echo "Testing update with invalid subcommand:"
$SCRIPT update invalid 2>&1
echo ""

echo "=== All Tests Complete ==="

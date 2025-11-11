#!/bin/bash
#
# Install Git Hooks Script
#
# This script installs git hooks that enforce branch protection locally.
# Run once per repository to set up local enforcement.
#
# Usage:
#   cd your-project-root
#   .claude/hooks/install-git-hooks.sh
#

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Git Hooks Installer"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if we're in a git repository
if [ ! -d ".git" ]; then
  echo -e "${RED}❌ ERROR: Not a git repository${NC}"
  echo "Run this script from the root of your git repository."
  exit 1
fi

# Check if hooks directory exists
if [ ! -d ".git/hooks" ]; then
  echo -e "${YELLOW}⚠️  .git/hooks directory not found, creating...${NC}"
  mkdir -p .git/hooks
fi

# Install pre-commit hook
HOOK_SOURCE=".claude/hooks/pre-commit"
HOOK_DEST=".git/hooks/pre-commit"

if [ ! -f "$HOOK_SOURCE" ]; then
  echo -e "${RED}❌ ERROR: Hook source not found: $HOOK_SOURCE${NC}"
  exit 1
fi

# Backup existing hook if present
if [ -f "$HOOK_DEST" ]; then
  echo -e "${YELLOW}⚠️  Existing pre-commit hook found${NC}"
  BACKUP="$HOOK_DEST.backup.$(date +%Y%m%d-%H%M%S)"
  cp "$HOOK_DEST" "$BACKUP"
  echo -e "${GREEN}✓${NC} Backed up to: $BACKUP"
fi

# Copy and make executable
cp "$HOOK_SOURCE" "$HOOK_DEST"
chmod +x "$HOOK_DEST"

echo -e "${GREEN}✓${NC} Installed: pre-commit hook"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installation Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "What this does:"
echo "  • Blocks direct commits to main/master branches"
echo "  • Enforces branch-based development workflow"
echo "  • Provides helpful error messages with next steps"
echo ""
echo "To test:"
echo "  git checkout main"
echo "  git commit --allow-empty -m 'test' # Should be blocked"
echo ""
echo "To bypass (emergency only):"
echo "  git commit --no-verify -m 'emergency fix'"
echo ""
echo -e "${GREEN}Happy coding!${NC}"
echo ""

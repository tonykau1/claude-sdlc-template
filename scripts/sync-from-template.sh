#!/bin/bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

TEMPLATE_REPO="https://github.com/yourorg/claude-sdlc-template.git"

echo -e "${BLUE}🔄 Checking for template updates...${NC}"
echo ""

# Check if we're in a project with the template
if [ ! -f ".claude/TEMPLATE_VERSION.txt" ]; then
    echo -e "${RED}❌ Error: Not in a project with Claude SDLC template${NC}"
    echo "This script should be run from the root of your project directory."
    echo "Looking for: .claude/TEMPLATE_VERSION.txt"
    exit 1
fi

# Check if _template directory exists
if [ ! -d ".claude/_template" ]; then
    echo -e "${RED}❌ Error: Template directory not found${NC}"
    echo "Expected: .claude/_template/"
    exit 1
fi

# Get current version
CURRENT_VERSION=$(cat .claude/TEMPLATE_VERSION.txt)
echo -e "📌 Current template version: ${YELLOW}$CURRENT_VERSION${NC}"

# Fetch latest version from remote
echo "Fetching latest version from template repository..."
LATEST_VERSION=$(curl -s "https://raw.githubusercontent.com/yourorg/claude-sdlc-template/main/VERSION" || echo "unknown")

if [ "$LATEST_VERSION" == "unknown" ]; then
    echo -e "${YELLOW}⚠️  Could not fetch latest version from remote${NC}"
    echo "Proceeding with sync anyway..."
    echo ""
fi

echo -e "📦 Latest template version: ${GREEN}$LATEST_VERSION${NC}"
echo ""

# Check if update is needed
if [ "$CURRENT_VERSION" == "$LATEST_VERSION" ] && [ "$LATEST_VERSION" != "unknown" ]; then
    echo -e "${GREEN}✅ Already on latest template version: $CURRENT_VERSION${NC}"
    echo ""
    echo "Run with --force to sync anyway"
    
    if [ "$1" != "--force" ]; then
        exit 0
    fi
    
    echo -e "${YELLOW}🔨 Forcing sync...${NC}"
    echo ""
fi

# Warn about potential conflicts
echo -e "${YELLOW}⚠️  WARNING: This will update template files in .claude/_template/${NC}"
echo "Your project-specific files in .claude/project/ will NOT be affected."
echo ""
read -p "Continue with sync? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Sync cancelled."
    exit 0
fi

echo ""
echo "Pulling latest changes from template repository..."

# Pull template updates
git subtree pull --prefix .claude/_template "$TEMPLATE_REPO" main --squash

# Update version file if we successfully got the latest version
if [ "$LATEST_VERSION" != "unknown" ]; then
    echo "$LATEST_VERSION" > .claude/TEMPLATE_VERSION.txt
    echo -e "${GREEN}✅ Updated version file to: $LATEST_VERSION${NC}"
fi

echo ""
echo -e "${GREEN}✅ Template sync complete!${NC}"
echo ""

# Show changelog if available
if [ "$LATEST_VERSION" != "unknown" ] && [ "$LATEST_VERSION" != "$CURRENT_VERSION" ]; then
    echo -e "${BLUE}📝 Changelog:${NC}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # Try to fetch and display changelog
    CHANGELOG=$(curl -s "https://raw.githubusercontent.com/yourorg/claude-sdlc-template/main/CHANGELOG.md" || echo "")
    
    if [ -n "$CHANGELOG" ]; then
        # Extract changes between versions (simplified)
        echo "$CHANGELOG" | head -50
    else
        echo "Could not fetch changelog. View it at:"
        echo "https://github.com/yourorg/claude-sdlc-template/blob/main/CHANGELOG.md"
    fi
    
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
fi

echo -e "${YELLOW}📋 Next steps:${NC}"
echo "  1. Review changes in .claude/_template/"
echo "  2. Check if any updates affect your project-specific docs"
echo "  3. Test that everything still works"
echo "  4. Commit the changes:"
echo "     ${GREEN}git add .claude/${NC}"
echo "     ${GREEN}git commit -m \"Update template to v$LATEST_VERSION\"${NC}"
echo ""
echo -e "${YELLOW}💡 Tip:${NC} Compare versions with:"
echo "   ${GREEN}git diff .claude/_template/${NC}"

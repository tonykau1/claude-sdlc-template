#!/bin/bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

FILE_PATH=$1
TEMPLATE_REPO="https://github.com/yourorg/claude-sdlc-template.git"

if [ -z "$FILE_PATH" ]; then
    echo -e "${RED}❌ Error: File path required${NC}"
    echo ""
    echo "Usage: ./contribute-back.sh path/to/file"
    echo ""
    echo "Examples:"
    echo "  ./contribute-back.sh .claude/_template/agents/security.md"
    echo "  ./contribute-back.sh .claude/_template/checklists/pre-commit.md"
    exit 1
fi

# Check if file exists
if [ ! -f "$FILE_PATH" ]; then
    echo -e "${RED}❌ Error: File not found: $FILE_PATH${NC}"
    exit 1
fi

# Check if file is in template directory
if [[ ! $FILE_PATH == .claude/_template/* ]]; then
    echo -e "${RED}❌ Error: Can only contribute files from .claude/_template/${NC}"
    echo ""
    echo "The file you're trying to contribute is not in the template directory."
    echo ""
    echo -e "${YELLOW}💡 Tip:${NC} If you want to contribute project-specific improvements:"
    echo "  1. Extract the universal parts"
    echo "  2. Create/update a file in .claude/_template/"
    echo "  3. Run this script on that template file"
    exit 1
fi

echo -e "${BLUE}🚀 Contributing changes back to template${NC}"
echo ""
echo -e "📄 File: ${GREEN}$FILE_PATH${NC}"
echo ""

# Generate branch name
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
FILENAME=$(basename "$FILE_PATH" .md)
BRANCH_NAME="improvement-$FILENAME-$TIMESTAMP"

echo -e "🌿 Creating branch: ${YELLOW}$BRANCH_NAME${NC}"
echo ""

# Show what will be contributed
echo -e "${YELLOW}📝 Changes to be contributed:${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
git diff .claude/_template/ -- "$FILE_PATH" | head -50
if [ ${PIPESTATUS[0]} -ne 0 ] || [ -z "$(git diff .claude/_template/ -- "$FILE_PATH")" ]; then
    echo -e "${YELLOW}(No uncommitted changes - will push current state)${NC}"
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Confirm
read -p "Continue with contribution? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Contribution cancelled."
    exit 0
fi

echo ""
echo "Pushing to template repository..."

# Push to template repo (creates new branch)
git subtree push --prefix .claude/_template "$TEMPLATE_REPO" "$BRANCH_NAME"

echo ""
echo -e "${GREEN}✅ Successfully pushed to branch: $BRANCH_NAME${NC}"
echo ""
echo -e "${YELLOW}📋 Next steps:${NC}"
echo "  1. Visit: ${BLUE}https://github.com/yourorg/claude-sdlc-template/compare/$BRANCH_NAME${NC}"
echo "  2. Create a Pull Request"
echo "  3. Describe your improvement:"
echo "     - What problem does it solve?"
echo "     - Why is this a good universal pattern?"
echo "     - Any breaking changes?"
echo "  4. Request review from template maintainers"
echo ""
echo -e "${YELLOW}💡 Tip:${NC} Good PR descriptions help others understand:"
echo "  - The context of the change"
echo "  - Real-world use case it addresses"
echo "  - Any alternatives you considered"

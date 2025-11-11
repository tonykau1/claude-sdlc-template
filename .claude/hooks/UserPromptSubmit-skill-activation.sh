#!/bin/bash
#
# Skill Auto-Activation Hook (Bash Wrapper for TypeScript Implementation)
# Triggers: UserPromptSubmit
#
# This hook analyzes user prompts and automatically suggests relevant skills
# based on configuration rules in skill-rules.json.
#
# Installation:
# 1. Ensure this file is executable: chmod +x UserPromptSubmit-skill-activation.sh
# 2. Install dependencies: cd .claude/hooks && npm install
# 3. Configure skill-rules.json with your project's patterns
# 4. Hook will activate automatically on every user prompt
#

set -e

# Get the directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if TypeScript implementation exists
if [ ! -f "$SCRIPT_DIR/skill-activation-prompt.ts" ]; then
  echo "⚠️  skill-activation-prompt.ts not found. Skill auto-activation disabled." >&2
  exit 0
fi

# Check if npx and tsx are available
if ! command -v npx &> /dev/null; then
  echo "⚠️  npx not installed. Install Node.js to enable skill auto-activation." >&2
  exit 0
fi

# Run TypeScript implementation
cd "$SCRIPT_DIR"
cat | npx tsx skill-activation-prompt.ts

exit 0

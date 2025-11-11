#!/bin/bash
#
# Tool Usage Tracker Hook
# Triggers: PostToolUse
#
# This hook tracks file modifications after tool execution to maintain
# context awareness across Claude Code sessions. It helps skills understand
# what files are actively being worked on.
#
# Installation:
# 1. Ensure this file is executable: chmod +x PostToolUse-tracker.sh
# 2. Hook will activate automatically after each tool use
#

set -euo pipefail

# Get the tool that was just used
TOOL_NAME="${TOOL_NAME:-unknown}"
CLAUDE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TRACKER_FILE="$CLAUDE_DIR/.active-files"

# Only track file-modifying tools
case "$TOOL_NAME" in
  Edit|Write|NotebookEdit)
    # Get the file path if available from tool output
    FILE_PATH="${FILE_PATH:-}"

    if [ -n "$FILE_PATH" ]; then
      # Append to tracker file with timestamp
      TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
      echo "$TIMESTAMP|$TOOL_NAME|$FILE_PATH" >> "$TRACKER_FILE"

      # Keep only last 100 entries to prevent file from growing indefinitely
      if [ -f "$TRACKER_FILE" ]; then
        tail -n 100 "$TRACKER_FILE" > "$TRACKER_FILE.tmp"
        mv "$TRACKER_FILE.tmp" "$TRACKER_FILE"
      fi
    fi
    ;;
  *)
    # Don't track other tools
    ;;
esac

exit 0

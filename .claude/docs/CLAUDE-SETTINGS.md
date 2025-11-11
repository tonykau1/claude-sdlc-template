# Claude Code Settings Guide

## Quick Reference

This project uses a **two-file settings system** for Claude Code permissions:

1. **`.claude/settings.json`** - Base permissions (checked into git, shared with team)
2. **`.claude/settings.local.json`** - Local overrides (gitignored, personal settings)

## File Purposes

### settings.json (Shared)
- **Purpose**: Base permissions that all team members should have
- **Git tracked**: YES - this file is committed to the repository
- **Contains**: Broad permissions like `Bash(*)`, `Read(*)`, `WebFetch(*)`
- **When to edit**: When adding project-wide permissions for the whole team

### settings.local.json (Personal)
- **Purpose**: Your personal overrides and additional permissions
- **Git tracked**: NO - this file is in `.gitignore`
- **Contains**: Same structure as settings.json, but for local-only overrides
- **When to edit**: For personal workflow preferences or machine-specific settings

## Permission Priority

If a permission exists in both files:
```
settings.local.json > settings.json
```

Local settings always take precedence over shared settings.

## Common Issues & Solutions

### Issue 1: "Allow and don't ask again" overwrites settings.local.json

**Problem**: When you click "allow and don't ask again" in the permission prompt, Claude Code may overwrite your entire `settings.local.json` file with just that one permission.

**Solution**:
1. Keep a backup of your comprehensive `settings.local.json`
2. After any overwrite, restore from:
   - Your backup copy
   - The example: `.claude/settings.local.json.example`
   - This repository's committed version

**Prevention**:
```bash
# Create a backup before each session
cp .claude/settings.local.json .claude/settings.local.json.backup
```

**Quick restore** if it gets overwritten:
```bash
# Restore from example
cp .claude/settings.local.json.example .claude/settings.local.json

# OR restore from backup
cp .claude/settings.local.json.backup .claude/settings.local.json
```

### Issue 2: Permissions not recognized after changes

**Problem**: You updated settings files but Claude Code still prompts for permissions.

**Solution**:
1. Reload VS Code window: `Cmd+Shift+P` → "Developer: Reload Window"
2. Ensure both `settings.json` AND `settings.local.json` exist
3. Check JSON syntax is valid (no trailing commas, proper quotes)

### Issue 3: Multiple Claude Code instances have different permissions

**Problem**: Running multiple VS Code windows with Claude Code, one has permissions, another doesn't.

**Solution**:
- Both windows read from the **same** `.claude/settings.json` and `.claude/settings.local.json` files
- If one window's Claude overwrites `settings.local.json`, all windows are affected
- Reload all VS Code windows after restoring settings files

## Recommended Setup

### For Individual Developers

Use this approach if you're working alone or want maximum flexibility:

**`.claude/settings.json`** (committed to git):
```json
{
  "permissions": {
    "allow": [
      "Read(*)",
      "Write(*)",
      "Edit(*)",
      "Glob(*)",
      "Grep(*)",
      "Bash(*)",
      "WebFetch(*)",
      "WebSearch(*)",
      "Task(*)",
      "TodoWrite(*)"
    ],
    "deny": [
      "Bash(rm -rf /*)",
      "Bash(sudo:*)",
      "Write(.env)"
    ],
    "defaultMode": "accept"
  }
}
```

**`.claude/settings.local.json`** (gitignored, same content for convenience):
```json
{
  "permissions": {
    "allow": [
      "Read(*)",
      "Write(*)",
      "Edit(*)",
      "Glob(*)",
      "Grep(*)",
      "Bash(*)",
      "WebFetch(*)",
      "WebSearch(*)",
      "Task(*)",
      "TodoWrite(*)"
    ],
    "deny": [
      "Bash(rm -rf /*)",
      "Bash(sudo:*)",
      "Write(.env)"
    ],
    "defaultMode": "accept"
  }
}
```

### For Teams

Use this approach when multiple people work on the project:

**`.claude/settings.json`** (committed to git):
```json
{
  "permissions": {
    "allow": [
      "Read(*)",
      "Glob(*)",
      "Grep(*)",
      "Bash(npm:*)",
      "Bash(git:*)"
    ],
    "deny": [
      "Bash(rm -rf /*)",
      "Bash(sudo:*)",
      "Write(.env)"
    ],
    "defaultMode": "ask"
  }
}
```

**`.claude/settings.local.json`** (each team member customizes):
```json
{
  "permissions": {
    "allow": [
      "Write(*)",
      "Edit(*)",
      "Bash(*)",
      "WebFetch(*)",
      "Task(*)"
    ],
    "defaultMode": "accept"
  }
}
```

## Testing Your Setup

After configuring settings, test that permissions work:

```bash
# Test read permission
claude> "Read the README.md file"

# Test bash permission
claude> "Run npm run build"

# Test WebFetch permission
claude> "Fetch the latest docs from https://example.com"
```

If you get permission prompts for tools in your allow list:
1. Check that BOTH settings files exist
2. Reload VS Code window
3. Verify JSON syntax is valid

## Maintenance

### Regular Backups

Add this to your workflow:

```bash
# Before starting a Claude Code session
cp .claude/settings.local.json .claude/settings.local.json.backup

# After a session (if settings were modified)
diff .claude/settings.local.json .claude/settings.local.json.backup
```

### Keeping Example Up-to-Date

When you update `settings.local.json`, also update the example:

```bash
cp .claude/settings.local.json .claude/settings.local.json.example
git add .claude/settings.local.json.example
git commit -m "docs: update settings example"
```

## Advanced: Hooks

Settings files can also contain hooks (automated scripts that run before/after tool use).

See: `.claude/templates/settings.json.example` for hook examples.

**Warning**: Hooks are powerful but can slow down Claude Code if overused. Start with permissions only.

## Troubleshooting Checklist

- [ ] Both `.claude/settings.json` and `.claude/settings.local.json` exist
- [ ] `.gitignore` includes `.claude/settings.local.json` (line 34)
- [ ] `.gitignore` does NOT include `.claude/settings.json`
- [ ] JSON syntax is valid (use a JSON validator)
- [ ] VS Code window has been reloaded after changes
- [ ] No syntax errors in either settings file

## Further Reading

- Claude Code Permissions Docs: https://docs.claude.com/en/docs/claude-code
- Template Settings Example: `.claude/templates/settings.json.example`
- Migration Guide: `docs/MIGRATION-GUIDE.md`

## Summary

**To prevent frustration:**
1. Keep both `settings.json` and `settings.local.json` with comprehensive permissions
2. Backup `settings.local.json` regularly (it can get overwritten)
3. Reload VS Code after any settings changes
4. Use broad wildcards like `Bash(*)` to avoid frequent prompts
5. Remember: `settings.local.json` is gitignored, `settings.json` is committed

Happy coding with Claude!

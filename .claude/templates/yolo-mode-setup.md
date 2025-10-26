# YOLO Mode Setup for Claude Code

**"YOLO Mode"** configures Claude Code to work more autonomously, reducing permission prompts for common development tasks while still protecting against destructive operations.

## What YOLO Mode Enables

✅ **Automatically allowed:**
- Create files and directories
- Write non-destructive code
- Install dependencies (npm, pip, etc.)
- Run SELECT queries (read-only database operations)
- Run tests and linters
- Fetch from web for research
- Run build commands
- Git operations (except force-push, hard reset)
- Start/stop development servers

❌ **Still requires permission:**
- Delete files or directories
- DROP/DELETE/UPDATE database operations
- Force-push to git
- Hard reset git history
- Modify production environments
- Install system-level packages (sudo)

---

## Configuration Methods

### Method 1: Agent Instructions (Recommended)

Add this to your `.claude/claude.md` file:

```markdown
## Agent Autonomy Settings (YOLO Mode)

**You have permission to work autonomously without asking for approval for:**

### File Operations
- ✅ Create new files and directories
- ✅ Write and edit code files
- ✅ Read any file in the project
- ❌ Delete files (ask first)

### Commands & Dependencies
- ✅ Install dependencies: `npm install`, `pip install`, `bundle install`, etc.
- ✅ Run tests: `npm test`, `pytest`, `cargo test`, etc.
- ✅ Run linters: `eslint`, `prettier`, `ruff`, etc.
- ✅ Run builds: `npm run build`, `cargo build`, etc.
- ✅ Start dev servers: `npm run dev`, etc.
- ❌ System-level installs with `sudo` (ask first)

### Database Operations
- ✅ SELECT queries (read-only)
- ✅ Query schema/metadata: `\d`, `SHOW TABLES`, etc.
- ✅ EXPLAIN queries for performance analysis
- ❌ INSERT, UPDATE, DELETE, DROP (ask first, except in test databases)
- ❌ Schema changes: ALTER TABLE, CREATE/DROP (ask first)

### Git Operations
- ✅ git status, git diff, git log
- ✅ git add, git commit (with proper messages)
- ✅ git push (normal push to feature branches)
- ✅ Create branches
- ❌ git push --force (ask first)
- ❌ git reset --hard (ask first)
- ❌ git push to main/master (ask first)

### Web & Research
- ✅ Fetch documentation, APIs, libraries info
- ✅ Search for solutions to errors
- ✅ Look up best practices
- ✅ Access public APIs for data

### General Workflow
1. **Start working immediately** on tasks - don't ask "should I start?"
2. **Run commands proactively** - install deps, run tests, check builds
3. **Fix errors as you find them** - don't stop to ask if you should fix linter errors
4. **Ask questions only when:**
   - You're about to delete files/data
   - Multiple valid approaches exist (architecture decisions)
   - Requirements are ambiguous
   - You're about to do something destructive
```

### Method 2: Claude Code Hooks (Advanced)

Create `.claude/settings.json` in your project:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "match": "Write",
        "command": "echo 'Auto-approving file write'"
      },
      {
        "match": "Bash",
        "command": "bash -c 'if echo \"$TOOL_INPUT\" | jq -r \".command\" | grep -qE \"^(rm|sudo|DROP|DELETE FROM|git reset --hard|git push.*--force)\"; then echo \"BLOCK: Destructive command requires approval\" && exit 1; fi'"
      }
    ],
    "PostToolUse": [
      {
        "match": "Write",
        "command": "echo 'File written successfully' >> .claude/activity.log"
      },
      {
        "match": "Bash",
        "command": "bash -c 'echo \"$(date): $(echo $TOOL_INPUT | jq -r .command)\" >> .claude/command-log.txt'"
      }
    ]
  }
}
```

**Explanation of hooks:**

1. **PreToolUse on Bash**: Blocks destructive commands automatically
   - Blocks: `rm`, `sudo`, `DROP`, `DELETE FROM`, `git reset --hard`, `git push --force`
   - Returns error to Claude to use a safer alternative

2. **PostToolUse logging**: Tracks all commands for audit trail

---

## Setup Instructions

### Quick Setup (5 minutes)

1. **Copy the Agent Instructions** to your `.claude/claude.md`
   ```bash
   # Append YOLO mode section to your claude.md
   cat .claude/_template/templates/yolo-mode-setup.md >> .claude/claude.md
   ```

2. **Create example .env** to avoid repeated environment questions:
   ```bash
   cp .env.example .env
   echo ".env" >> .gitignore  # Ensure it's gitignored
   ```

3. **Document your database schema** so Claude doesn't need to query it repeatedly:
   ```bash
   # For PostgreSQL
   pg_dump --schema-only $DATABASE_URL > .claude/project/architecture/database-schema.sql

   # Or use the template
   cp .claude/_template/templates/database-schema-template.md \
      .claude/project/architecture/database-schema.md
   ```

4. **Test it out:**
   ```bash
   claude code
   # Try: "Install the lodash package and create a new utils file that uses it"
   # Claude should do both without asking permission
   ```

### Advanced Setup with Hooks (Optional)

1. **Create hooks configuration**:
   ```bash
   # Use the /hooks command in Claude Code
   claude code
   # Then type: /hooks
   ```

2. **Add safety hooks**:
   - PreToolUse hook to block destructive Bash commands
   - PostToolUse hook to log all commands
   - SessionEnd hook to save session summary

3. **Create activity logging**:
   ```bash
   mkdir -p .claude/logs
   echo ".claude/logs/" >> .gitignore
   ```

---

## Example Workflows

### Scenario 1: Add a New Feature

**Before YOLO Mode:**
```
User: "Add a new authentication endpoint"
Claude: "Should I create a new file for the auth routes?"
User: "Yes"
Claude: "Should I install the bcrypt package?"
User: "Yes"
Claude: "Should I run the tests?"
User: "Yes"
```

**With YOLO Mode:**
```
User: "Add a new authentication endpoint"
Claude: *Creates file, installs bcrypt, writes code, runs tests*
Claude: "I've created the auth endpoint. Tests are passing. Ready to review?"
```

### Scenario 2: Fix Linting Errors

**Before YOLO Mode:**
```
User: "Fix the linting errors"
Claude: "I found 15 linting errors. Should I fix them?"
User: "Yes"
```

**With YOLO Mode:**
```
User: "Fix the linting errors"
Claude: *Runs linter, fixes all errors, re-runs linter*
Claude: "Fixed 15 linting errors. All checks passing."
```

### Scenario 3: Database Query

**Before YOLO Mode:**
```
User: "Show me all active users"
Claude: "Should I run: SELECT * FROM users WHERE is_active = true?"
User: "Yes"
```

**With YOLO Mode:**
```
User: "Show me all active users"
Claude: *Runs query, shows results*
Claude: "Here are the 142 active users..."
```

---

## Safety Guardrails

Even in YOLO mode, Claude will still ask before:

### Destructive File Operations
```bash
# ❌ Requires permission
rm -rf src/
git rm important-file.js
```

### Database Mutations
```sql
-- ❌ Requires permission
DELETE FROM users WHERE last_login < '2020-01-01';
DROP TABLE old_data;
UPDATE users SET role = 'admin';
```

### Git Force Operations
```bash
# ❌ Requires permission
git push --force origin main
git reset --hard HEAD~5
git push origin :branch-name  # Delete remote branch
```

### Production Deployments
```bash
# ❌ Requires permission
kubectl apply -f production/
terraform apply
./deploy-to-production.sh
```

---

## Customizing Permissions

Edit the "Agent Autonomy Settings" section in `.claude/claude.md` to match your preferences:

```markdown
## Agent Autonomy Settings (Custom)

**Additional permissions for this project:**
- ✅ Run database migrations automatically (we have rollback scripts)
- ✅ Deploy to staging environment (production still requires approval)
- ✅ Install Chrome extensions for testing (safe local environment)

**Extra restrictions for this project:**
- ❌ Never modify files in `/legacy/` (ask first - very sensitive)
- ❌ Don't install packages without checking bundle size first
- ❌ Always run security scans before committing (npm audit)
```

---

## Monitoring & Logging

### Track Claude's Actions

Create `.claude/settings.json`:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "match": "*",
        "command": "echo \"$(date '+%Y-%m-%d %H:%M:%S') - Tool: $TOOL_NAME\" >> .claude/logs/activity.log"
      }
    ],
    "SessionEnd": [
      {
        "match": "*",
        "command": "echo \"\\n=== Session ended: $(date) ===\\n\" >> .claude/logs/activity.log"
      }
    ]
  }
}
```

### Review Activity Log

```bash
# See what Claude did in the last session
tail -50 .claude/logs/activity.log

# See all Bash commands run
grep "Bash" .claude/logs/activity.log

# See all file writes
grep "Write" .claude/logs/activity.log
```

---

## Troubleshooting

### Claude Still Asking Too Many Questions

**Solution**: Be more explicit in `.claude/claude.md`:

```markdown
## Agent Behavior Override

**IMPORTANT**: Unless the operation is explicitly listed as requiring permission:
1. Do NOT ask "Should I...?"
2. Do NOT ask "Would you like me to...?"
3. Just do it and report what you did
4. The only exception: if you're about to delete data or do something irreversible

Examples:
- ❌ "Should I install the lodash package?"
- ✅ "Installing lodash..." (just do it)
- ❌ "Should I create a new utils file?"
- ✅ "Created utils/helpers.js" (just do it)
```

### Too Much Automation

**Solution**: Add specific restrictions:

```markdown
## Restrictions for This Project

- ❌ Don't install packages over 1MB without asking
- ❌ Don't modify database schema (even in dev) without asking
- ❌ Always show me the test results before committing
```

### Hook Not Triggering

**Debug steps:**
```bash
# 1. Check hook is registered
cat .claude/settings.json

# 2. Test hook manually
echo '{"command":"echo test"}' | jq -r '.command' >> test.log

# 3. Check permissions
chmod +x .claude/hooks/*

# 4. View Claude Code logs
# (Location varies by IDE - check Claude Code docs)
```

---

## Best Practices

### 1. Start Gradually
Don't enable full YOLO mode immediately. Start with:
- Week 1: Auto-approve file writes and reads
- Week 2: Add dependency installation
- Week 3: Add test/lint automation
- Week 4: Full YOLO mode

### 2. Use Project-Specific Settings
Different projects have different risk tolerances:
- **Greenfield projects**: Full YOLO mode is safe
- **Production systems**: More conservative permissions
- **Open source**: Be careful with credentials

### 3. Review Activity Logs
Make it a habit:
```bash
# Weekly review
cat .claude/logs/activity.log | grep "$(date -d '7 days ago' +%Y-%m-%d)"
```

### 4. Document Exceptions
When Claude asks for permission unexpectedly:
- Document why in `.claude/claude.md`
- Either add it to "always allowed" or "always ask" list
- Keep the list up to date

### 5. Use Version Control
Commit your YOLO settings:
```bash
git add .claude/claude.md .claude/settings.json
git commit -m "Configure YOLO mode for autonomous development"
```

---

## Security Considerations

### ⚠️ Important Warnings

1. **Credentials in Environment**
   - Hooks run with your current shell environment
   - They have access to all your env variables
   - Never commit `.claude/settings.local.json` if it contains secrets

2. **Command Injection**
   - Be careful with hooks that use `$TOOL_INPUT`
   - Always validate/sanitize input
   - Use `jq` to safely extract JSON fields

3. **Audit Trail**
   - Enable logging for compliance
   - Keep logs for at least 30 days
   - Review logs for unexpected activity

4. **Shared Projects**
   - Document YOLO mode in README
   - Team members should review the settings
   - Consider less aggressive defaults for shared repos

### Safe Hook Examples

```bash
# ✅ SAFE: Uses jq to extract field
jq -r '.tool_input.command' >> commands.log

# ❌ UNSAFE: Directly evaluates user input
eval "$TOOL_INPUT"

# ✅ SAFE: Validates before running
if [[ "$COMMAND" =~ ^[a-zA-Z0-9\ \-]+$ ]]; then
  echo "$COMMAND" >> log.txt
fi
```

---

## Resources

- [Claude Code Hooks Guide](https://docs.claude.com/en/docs/claude-code/hooks-guide)
- [Claude Code Settings Reference](https://docs.claude.com/en/docs/claude-code/settings)
- [Autonomous Agent Patterns](https://docs.claude.com/en/docs/claude-code/autonomous-patterns)
- [Security Best Practices](https://docs.claude.com/en/docs/claude-code/security)

---

## Template Files

Copy these templates to get started:

- `.claude/settings.json.example` - Example hooks configuration
- `.claude/claude.md` - Add "Agent Autonomy Settings" section
- `.env.example` - Document required environment variables

**Ready to enable YOLO mode? Start with the Quick Setup section above!**

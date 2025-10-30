# Quick Start: Plan-Then-Execute Mode

Get agents working autonomously with no interruptions during execution.

## 30-Second Setup

```bash
# 1. Copy settings
cp .claude/_template/templates/settings.local.json.example .claude/settings.local.json

# 2. Add to your .claude/claude.md (at the top):
```

```markdown
## Development Mode: Plan-Then-Execute

**Workflow**: Plan interactively → I approve → You execute completely → I review

### During Execution (After I Approve Plan)
Work autonomously without asking. You can:
- ✅ Read/write any files
- ✅ Run tests, builds, linters
- ✅ Query databases (SELECT on any, INSERT/UPDATE on dev/test)
- ✅ Make git commits
- ❌ Only stop for: ambiguous requirements, security issues, production access

### Multi-Agent Tasks
Use orchestrator to coordinate specialists. All work autonomously once I approve the plan.
```

## Usage Pattern

```
You: "Build user profile editing feature"

Agent: [Presents comprehensive plan with architecture, files, testing]

You: "Approved" or "Go ahead"

Agent: [Works completely - reads, writes, tests, commits - no interruptions]

Agent: "Complete! Here's what was delivered: [evidence, tests, commits]"

You: [Reviews final deliverable]
```

## What Gets Auto-Approved During Execution

### File Operations
- ✅ Read any file
- ✅ Write any file
- ✅ Edit any file
- ✅ Search codebase (Glob, Grep)

### Testing & Building
- ✅ npm test, pytest, cargo test
- ✅ npm run build, make
- ✅ Linters, formatters
- ✅ Dev servers

### Database (Dev/Test)
- ✅ SELECT queries on any database
- ✅ INSERT/UPDATE on dev_db, test_db
- ✅ Migrations: npm run db:migrate
- ❌ Production databases blocked
- ❌ DROP/DELETE blocked

### Git Operations
- ✅ git status, diff, log
- ✅ git add, commit
- ✅ git push to feature/* branches
- ❌ push to main/master
- ❌ force push

### Dependencies
- ✅ npm install (no arguments - installs from package.json)
- ❌ npm install <new-package> (asks first)

## Common Scenarios

### New Feature
```
You: "Add password reset via email"
Agent: [Plans: email service, tokens, UI, tests]
You: "Approved"
Agent: [Implements everything, tests pass, commits made]
Agent: "Done - here's evidence it works"
```

### Bug Fix
```
You: "Fix the cart total calculation bug"
Agent: [Investigates, identifies issue, proposes fix]
You: "Go for it"
Agent: [Fixes, adds regression test, verifies]
Agent: "Bug fixed - test proves it"
```

### Multi-Domain Feature
```
You: "Build real-time notifications"
Agent: [Orchestrator plans multi-agent approach]
You: "Proceed"
Agent: [DB, Backend, Frontend, DevOps all work]
Agent: "System complete - load tested"
```

## Troubleshooting

**Agent keeps asking during execution?**
Add to .claude/claude.md:
```markdown
IMPORTANT: After plan approval, work autonomously without asking unless:
- Requirements are unclear
- Security concern discovered
- Need production access
```

**Need different permissions?**
Edit `.claude/settings.local.json` - add patterns to allow/deny lists.

**Want agents to install packages freely?**
Remove from ask list:
```json
{
  "ask": [
    // Remove this line to auto-install
    // "Bash(npm install:*)"
  ]
}
```

## Full Documentation

- [Complete Plan-Then-Execute Guide](plan-then-execute-workflow.md)
- [YOLO Mode Setup](yolo-mode-setup.md)
- [settings.local.json.example](settings.local.json.example)

## TL;DR

1. Copy `settings.local.json.example` to `settings.local.json`
2. Add "Plan-Then-Execute" section to your `.claude/claude.md`
3. Say "approved" after seeing a plan
4. Watch agents work without interruption
5. Review completed deliverable with evidence

**That's it!** Maximum velocity, maximum autonomy, maximum safety.

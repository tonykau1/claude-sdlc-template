# Claude Code Hooks

This directory contains hooks that extend Claude Code's functionality with automatic skill activation and context tracking.

## What Are Hooks?

Hooks are scripts that Claude Code executes at specific trigger points during development workflows. They enable:
- **Auto-activation**: Suggest relevant skills based on context
- **Context tracking**: Maintain awareness of active files
- **Workflow enhancement**: Automate repetitive tasks

## Available Hooks

### Essential Hooks

#### 1. UserPromptSubmit-skill-activation.sh
**Trigger**: UserPromptSubmit (before Claude processes your prompt)

**Purpose**: Automatically suggests relevant skills based on:
- Files you're currently editing
- Keywords in your prompt
- Project patterns defined in `skill-rules.json`

**Example**: When you edit a `.ts` file and say "implement authentication", it suggests the relevant skills automatically.

**Configuration**: Edit `skill-rules.json` to customize activation rules.

#### 2. PostToolUse-tracker.sh
**Trigger**: PostToolUse (after Claude uses any tool)

**Purpose**: Tracks file modifications to maintain context about active work across sessions.

**Output**: Creates `.claude/.active-files` with timestamped file modification history.

## Configuration

### skill-rules.json

This file defines when skills should activate:

```json
{
  "skills": [
    {
      "name": "skill-name",
      "path": "skill-name/SKILL.md",
      "type": "domain|guardrail",
      "enforcement": "suggest|block|warn",
      "activation": {
        "keywords": "comma, separated, keywords",
        "filePatterns": [
          "**/*.ts",
          "src/**/*.py"
        ]
      }
    }
  ]
}
```

**Field Definitions**:
- `name`: Skill identifier
- `path`: Path relative to `.claude/skills/`
- `type`:
  - `domain`: Advisory guidance for specific domains
  - `guardrail`: Critical error prevention
- `enforcement`:
  - `suggest`: Inject context reminder (most common)
  - `block`: Prevent execution (use sparingly)
  - `warn`: Advisory only
- `activation.keywords`: Comma-separated keywords in user prompts
- `activation.filePatterns`: Glob patterns for file matching

### Pattern Matching Examples

**Monorepo structure**:
```json
"filePatterns": [
  "packages/*/src/**/*.ts",
  "apps/*/src/**/*.tsx"
]
```

**Single service**:
```json
"filePatterns": [
  "src/**/*.py",
  "tests/**/*.py"
]
```

**Nx workspace**:
```json
"filePatterns": [
  "apps/api/src/**/*.ts",
  "libs/shared/src/**/*.ts"
]
```

## Installation

Hooks are automatically detected if:
1. They exist in `.claude/hooks/`
2. They follow the naming convention: `<Trigger>-<name>.sh`
3. They are executable (`chmod +x`)

### Verification

```bash
# Check hooks are executable
ls -la .claude/hooks/*.sh

# Should show: -rwxr-xr-x (executable permission)

# Validate skill-rules.json
jq . .claude/hooks/skill-rules.json

# Should parse without errors
```

## Creating Custom Hooks

### Available Triggers

1. **UserPromptSubmit**: Before Claude processes user input
2. **PostToolUse**: After any tool execution
3. **PreCommit**: Before git commit (if configured)
4. **Stop**: When user stops a task

### Hook Template

```bash
#!/bin/bash
#
# <Trigger>-<name>.sh
# Brief description
#

set -euo pipefail

# Your logic here

# Exit codes:
# 0 - Success (continue)
# 1 - Error (log but continue)
# 2 - Block (stop execution)

exit 0
```

## Troubleshooting

### Hook Not Activating

1. **Check executable permission**: `chmod +x .claude/hooks/*.sh`
2. **Verify naming**: Must follow `<Trigger>-<name>.sh` pattern
3. **Check logs**: Look for error messages in Claude Code output

### skill-rules.json Errors

1. **Validate JSON**: `jq . .claude/hooks/skill-rules.json`
2. **Check file paths**: Ensure paths match actual skill locations
3. **Test patterns**: Use `grep -E "pattern" files` to verify regex

### Dependencies

- `jq`: Required for JSON parsing
  - macOS: `brew install jq`
  - Linux: `apt-get install jq`
  - Windows: `choco install jq`

## Best Practices

### 1. Keep Hooks Fast
- Hooks run on every trigger - keep execution under 100ms
- Cache expensive operations
- Exit early if conditions not met

### 2. Fail Gracefully
- Don't block workflow unless absolutely necessary
- Log warnings instead of errors when possible
- Provide helpful error messages

### 3. Test Thoroughly
- Test with different prompts and file patterns
- Verify all file patterns work with your structure
- Check hook behavior across different scenarios

### 4. Document Configuration
- Comment complex patterns in skill-rules.json
- Document why specific keywords trigger skills
- Keep activation logic simple and predictable

## Integration with Skills

Hooks work together with skills in `.claude/skills/`:

```
User types prompt
    ↓
UserPromptSubmit hook analyzes prompt
    ↓
Checks skill-rules.json for matches
    ↓
Suggests relevant skills to Claude
    ↓
Claude includes skill context in response
    ↓
PostToolUse tracks any file changes
```

This creates a context-aware development experience where:
- Skills activate automatically when relevant
- Context is maintained across sessions
- Guidance appears exactly when needed

## Examples

### Auto-Activate Backend Guidelines

When editing backend files:
```json
{
  "name": "backend-practices",
  "path": "backend-practices/SKILL.md",
  "activation": {
    "filePatterns": ["src/api/**/*.ts", "src/services/**/*.ts"],
    "keywords": "api, endpoint, service, controller, database"
  }
}
```

### Prevent Common Mistakes

Block operations that violate rules:
```json
{
  "name": "security-checklist",
  "path": "security/SKILL.md",
  "type": "guardrail",
  "enforcement": "block",
  "activation": {
    "keywords": "authentication, password, token, secret"
  }
}
```

### Context-Aware Testing

Suggest testing guidelines when working on tests:
```json
{
  "name": "testing-practices",
  "path": "testing/SKILL.md",
  "activation": {
    "filePatterns": ["**/*.test.ts", "**/*.spec.ts"],
    "keywords": "test, testing, unit test, integration test"
  }
}
```

## Further Reading

- [Skills Directory](../skills/README.md) - Learn about creating skills
- [Claude Code Hooks Documentation](https://github.com/anthropics/claude-code/docs/hooks) - Official documentation
- [Showcase Repository](https://github.com/diet103/claude-code-infrastructure-showcase) - Inspiration and examples

## Contributing

Found a useful hook pattern? Share it:
1. Document the hook thoroughly
2. Include activation rules and examples
3. Submit via contribution guidelines

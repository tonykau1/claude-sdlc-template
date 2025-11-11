---
name: skill-developer
description: Meta-skill for creating and managing Claude Code skills. Use when creating skills, skill templates, skill development, configuring skill activation, or managing skill resources.
---

# Skill Developer Guide

A comprehensive guide for creating effective Claude Code skills that auto-activate based on context and provide domain-specific guidance.

## Purpose

This skill helps you create well-structured, maintainable skills that:
- Auto-activate when relevant to the current task
- Provide clear, actionable guidance
- Stay under 500 lines using progressive disclosure
- Integrate seamlessly with the hook system

## When to Use

Create a skill when you need:
- **Domain-specific guidelines**: Backend patterns, frontend best practices, testing strategies
- **Guardrails**: Prevent common mistakes or enforce critical rules
- **Context-aware assistance**: Guidance that appears automatically when relevant
- **Reusable patterns**: Knowledge that applies across multiple tasks

## Quick Start: Creating Your First Skill

### Step 1: Create Directory Structure

```bash
mkdir -p .claude/skills/your-skill-name/resources
```

### Step 2: Create SKILL.md

```markdown
---
name: your-skill-name
description: Brief description including trigger keywords
---

# Your Skill Name

[Content under 500 lines]

## When to Use
[Clear triggers]

## Guidelines
[Actionable advice]

## Resources
- [Topic 1](resources/topic-1.md)
- [Topic 2](resources/topic-2.md)
```

### Step 3: Configure Activation

Edit `.claude/hooks/skill-rules.json`:

```json
{
  "name": "your-skill-name",
  "path": "your-skill-name/SKILL.md",
  "type": "domain",
  "enforcement": "suggest",
  "activation": {
    "keywords": "relevant, keywords, here",
    "filePatterns": ["**/*.ts", "src/**/*.js"]
  }
}
```

### Step 4: Test Activation

1. Edit a file matching your patterns
2. Use keywords in a prompt
3. Verify skill suggestion appears

## Skill Structure Best Practices

### Progressive Disclosure Pattern

**Main SKILL.md** (under 500 lines):
- Overview and purpose
- Quick start guide
- Core principles
- Links to deeper resources

**resources/** directory (each under 500 lines):
- Detailed topics
- Advanced patterns
- Examples and templates
- Edge cases

**Example Structure**:
```
backend-practices/
├── SKILL.md              # Overview, quick start
└── resources/
    ├── api-design.md     # REST API patterns
    ├── database.md       # Database best practices
    ├── error-handling.md # Error handling patterns
    └── testing.md        # Testing strategies
```

### Frontmatter Format

Always include YAML frontmatter:

```yaml
---
name: skill-identifier (lowercase, hyphenated)
description: Brief description with keywords for activation (max 1024 chars)
---
```

**Description Best Practices**:
- Include trigger keywords users might type
- Describe when this skill is relevant
- Be specific about domain/purpose
- Think: "What would I search for to find this?"

## Skill Types

### Domain Skills
**Purpose**: Advisory guidance for specific domains

**Characteristics**:
- `type: "domain"`
- `enforcement: "suggest"`
- Provides best practices and patterns
- Doesn't block workflow

**Examples**:
- Backend development guidelines
- Frontend component patterns
- Testing strategies
- API design principles

**When to Use**:
- Sharing team knowledge
- Establishing coding patterns
- Onboarding guidance
- Domain expertise

### Guardrail Skills
**Purpose**: Prevent critical errors and enforce rules

**Characteristics**:
- `type: "guardrail"`
- `enforcement: "suggest"` or `"block"` (use block sparingly)
- Catches common mistakes
- Enforces security/compliance rules

**Examples**:
- Security checklists
- Compliance requirements
- Breaking change prevention
- Critical error patterns

**When to Use**:
- Security-critical operations
- Compliance requirements
- Preventing data loss
- Enforcing non-negotiable rules

## Enforcement Levels

### SUGGEST (Recommended)
Injects skill context as a reminder.

**When to Use**: Most situations
- Best practices
- Team patterns
- Performance tips
- Style guidelines

**User Experience**:
- Skill appears in context
- User can ignore if needed
- Non-blocking workflow

### WARN (Rarely Used)
Advisory notification only.

**When to Use**: Low-priority reminders
- Nice-to-have suggestions
- Optional optimizations
- Informational notices

### BLOCK (Use Sparingly)
Prevents tool execution with exit code 2.

**When to Use**: Only for critical situations
- Security violations
- Data loss risks
- Compliance breaches
- Irreversible operations

**Warning**: Blocking can frustrate users. Use only when absolutely necessary.

## Activation Configuration

### File Patterns

Use glob patterns to match files:

```json
"filePatterns": [
  "**/*.ts",              // All TypeScript files
  "src/api/**/*.js",      // API directory only
  "**/*.test.ts",         // Test files
  "packages/*/src/**/*"   // Monorepo pattern
]
```

**Tips**:
- Test patterns with your actual file structure
- Be specific enough to avoid false positives
- Use `**` for recursive matching
- Match file extensions relevant to your domain

### Keywords

Comma-separated phrases users might type:

```json
"keywords": "api, endpoint, rest api, create route, backend, service"
```

**Tips**:
- Include variations (API, api, endpoint, route)
- Think about how users describe tasks
- Include domain-specific terms
- Keep under 1024 characters total
- Test with real prompts

### Activation Logic

Skills activate when:
- ANY file pattern matches recently modified files (last 5 minutes), OR
- ANY keyword appears in the user's prompt (case-insensitive)

**Example Scenarios**:

1. User edits `src/api/users.ts` → Activates backend skills
2. User types "create an API endpoint" → Activates backend skills
3. User edits `components/Button.tsx` → Activates frontend skills
4. User types "add unit test" → Activates testing skills

## Content Guidelines

### Keep It Under 500 Lines

**Why?**
- Context window management
- Faster to scan and reference
- Easier to maintain
- Forces clarity and focus

**How?**
- Move detailed topics to resources/
- Link to additional documentation
- Focus on essential guidance
- Remove redundant explanations

### Write Actionable Content

**Good**:
```markdown
✅ Use async/await for database queries:
- Wrap in try-catch blocks
- Handle errors explicitly
- Return typed results
```

**Bad**:
```markdown
❌ Database queries are important and you should think about
error handling and make sure to write good code that works.
```

### Use Clear Formatting

**Headers**: Create scannable structure
**Lists**: Break down complex topics
**Code blocks**: Show concrete examples
**Tables**: Compare options clearly
**Callouts**: Highlight critical information

### Include Examples

Show, don't just tell:

```markdown
## Error Handling Pattern

✅ Recommended:
\`\`\`typescript
try {
  const result = await db.query(sql);
  return { success: true, data: result };
} catch (error) {
  logger.error('Query failed', { error, sql });
  return { success: false, error: error.message };
}
\`\`\`

❌ Avoid:
\`\`\`typescript
const result = await db.query(sql); // No error handling
return result;
\`\`\`
```

## Testing Your Skill

### Activation Testing

**Test Checklist**:
- [ ] Skill activates with relevant file patterns
- [ ] Skill activates with keyword prompts
- [ ] Skill doesn't activate inappropriately
- [ ] Activation message is clear and helpful
- [ ] skill-rules.json is valid JSON

**Testing Commands**:
```bash
# Validate JSON
jq . .claude/hooks/skill-rules.json

# Test file pattern matching
echo "**/*.ts" | grep -E "src/api/users.ts"

# Check skill file exists
ls -la .claude/skills/your-skill-name/SKILL.md
```

### Content Testing

**Review Questions**:
- [ ] Is the purpose immediately clear?
- [ ] Are examples concrete and helpful?
- [ ] Is content under 500 lines?
- [ ] Are resource links working?
- [ ] Does it answer "when to use this"?
- [ ] Would a new team member understand this?

### Integration Testing

**Test Scenarios**:
1. Start fresh Claude Code session
2. Edit a file matching your patterns
3. Type a prompt with your keywords
4. Verify skill suggestion appears
5. Check that guidance is relevant

## Resource Files

Create detailed resources in `resources/` directory:

### Naming Convention
- Lowercase with hyphens
- Descriptive names
- Match main topic area

**Examples**:
- `api-design-patterns.md`
- `database-optimization.md`
- `error-handling-strategies.md`
- `testing-best-practices.md`

### Resource Structure

```markdown
# Resource Topic

## Overview
Brief introduction to this topic

## Core Concepts
Key ideas and principles

## Patterns
Specific implementation patterns

## Examples
Real-world examples

## Common Pitfalls
What to avoid

## Related Resources
- [Other Resource](other-resource.md)
- [External Link](https://example.com)
```

### Linking from Main Skill

```markdown
## Advanced Topics

For deeper coverage, see:
- [API Design Patterns](resources/api-design-patterns.md)
- [Database Optimization](resources/database-optimization.md)
- [Error Handling](resources/error-handling-strategies.md)
```

## Maintenance

### When to Update Skills

Update when:
- Team adopts new patterns
- Technology changes
- Common mistakes identified
- Feedback received
- New best practices emerge

### Version Control

Skills are code - treat them accordingly:
- Commit changes with clear messages
- Review updates with team
- Document breaking changes
- Keep changelog if appropriate

### Deprecation

When retiring a skill:
1. Add deprecation notice to SKILL.md
2. Update skill-rules.json to disable activation
3. Provide migration path to replacement
4. Keep file for historical reference

## Examples from Practice

### Example 1: Backend Development Skill

**Purpose**: Guide API development with team patterns

**Structure**:
```
backend-practices/
├── SKILL.md              # Core guidelines
└── resources/
    ├── rest-api.md       # REST best practices
    ├── database.md       # Prisma patterns
    ├── auth.md           # Authentication
    └── errors.md         # Error handling
```

**Activation**:
```json
{
  "keywords": "api, endpoint, service, controller, database, backend",
  "filePatterns": ["src/api/**/*.ts", "src/services/**/*.ts"]
}
```

### Example 2: Security Guardrail

**Purpose**: Prevent security vulnerabilities

**Structure**:
```
security-checklist/
├── SKILL.md              # Core security rules
└── resources/
    ├── authentication.md
    ├── data-protection.md
    └── common-vulns.md
```

**Activation**:
```json
{
  "type": "guardrail",
  "enforcement": "suggest",
  "keywords": "password, secret, token, auth, security, encryption",
  "filePatterns": ["src/auth/**/*", "**/*security*"]
}
```

## Resources

### Detailed Topics

- [Activation Patterns](resources/activation-patterns.md) - Advanced activation configurations
- [Content Templates](resources/content-templates.md) - Reusable skill templates
- [Hook Integration](resources/hook-integration.md) - Deep dive on hook system

### External References

- [Claude Code Documentation](https://github.com/anthropics/claude-code)
- [Showcase Repository](https://github.com/diet103/claude-code-infrastructure-showcase)
- [Progressive Disclosure Pattern](https://www.nngroup.com/articles/progressive-disclosure/)

## Quick Reference

### Skill Creation Checklist

- [ ] Create directory: `.claude/skills/skill-name/`
- [ ] Create `SKILL.md` with frontmatter
- [ ] Keep under 500 lines
- [ ] Add to `skill-rules.json`
- [ ] Define activation rules
- [ ] Test with file patterns
- [ ] Test with keywords
- [ ] Validate JSON configuration
- [ ] Create resource files if needed
- [ ] Document in team wiki

### Troubleshooting

**Skill not activating?**
1. Check skill-rules.json syntax
2. Verify file paths are correct
3. Test file pattern matching
4. Confirm hooks are executable
5. Check Claude Code logs

**Skill activating too often?**
1. Make file patterns more specific
2. Reduce keyword list
3. Review activation logic
4. Consider split into multiple skills

**Content too long?**
1. Move details to resources/
2. Remove redundant text
3. Focus on essentials only
4. Link to external docs

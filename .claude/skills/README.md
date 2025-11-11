# Claude Code Skills

This directory contains auto-activating skills that provide domain-specific guidance and best practices.

## What Are Skills?

Skills are context-aware guidelines that automatically activate when relevant. Unlike agents (which you invoke manually for complex tasks), skills work behind the scenes to provide guidance exactly when you need it.

### Skills vs Agents

**Skills** (this directory):
- Auto-activate based on context
- Provide ongoing guidance
- Act as "always-on" knowledge
- Example: "When editing API files, suggest REST best practices"

**Agents** (`.claude/agents/`):
- Manually invoked for specific tasks
- Handle complex multi-step workflows
- Coordinate different aspects of development
- Example: "Run the architect agent to design this system"

**Think of it as**:
- Skills = Your coding guidelines and best practices
- Agents = Your specialized consultants

## Available Skills

### skill-developer
**Purpose**: Meta-skill for creating and managing skills

**Auto-activates when**:
- Creating or editing skills
- Keywords: "create skill", "skill template", "skill development"
- Files: `.claude/skills/**/*.md`

**Use for**: Learning to create effective skills for your team

### sdlc-practices
**Purpose**: SDLC best practices and quality gates

**Auto-activates when**:
- Starting new features
- Keywords: "implement", "build", "create", "feature", "testing"
- Files: Most source code files (`.ts`, `.tsx`, `.py`, `.go`, etc.)

**Use for**: Ensuring production-quality development workflows

## How Skills Work

### Auto-Activation System

1. **User edits a file or types a prompt**
2. **Hook analyzes context**:
   - Checks file patterns against skill rules
   - Looks for keywords in prompt
3. **Relevant skills suggested**:
   - Skills appear in Claude's context
   - Guidance becomes available immediately
4. **Seamless integration**:
   - No manual activation needed
   - Skills "just work" when needed

### Configuration

Skills are configured in `.claude/hooks/skill-rules.json`:

```json
{
  "name": "skill-name",
  "path": "skill-name/SKILL.md",
  "type": "domain|guardrail",
  "enforcement": "suggest",
  "activation": {
    "keywords": "relevant, keywords",
    "filePatterns": ["**/*.ts"]
  }
}
```

## Creating Custom Skills

### Quick Start

1. **Create directory**:
```bash
mkdir -p .claude/skills/my-skill/resources
```

2. **Create SKILL.md**:
```markdown
---
name: my-skill
description: Brief description with trigger keywords
---

# My Skill

[Your guidance here - keep under 500 lines]
```

3. **Add to skill-rules.json**:
```json
{
  "name": "my-skill",
  "path": "my-skill/SKILL.md",
  "type": "domain",
  "enforcement": "suggest",
  "activation": {
    "keywords": "your, trigger, keywords",
    "filePatterns": ["**/*.ext"]
  }
}
```

4. **Test activation**:
- Edit a file matching your pattern
- Use keywords in a prompt
- Verify skill appears

### Skill Structure Best Practices

#### Progressive Disclosure

**Main file** (SKILL.md) - Under 500 lines:
- Overview and purpose
- Core guidelines
- Quick reference
- Links to resources

**Resource files** (resources/) - Each under 500 lines:
- Detailed topics
- Advanced patterns
- Comprehensive examples
- Edge cases

**Example**:
```
backend-practices/
├── SKILL.md              # Overview, core patterns
└── resources/
    ├── api-design.md     # REST API details
    ├── database.md       # Database patterns
    └── testing.md        # Testing strategies
```

#### Why 500 Lines?

- **Context window management**: Keeps files digestible
- **Scanability**: Easy to find relevant info
- **Maintainability**: Simpler to update
- **Focus**: Forces clarity and prioritization

### Skill Types

#### Domain Skills
**Purpose**: Advisory guidance for specific domains

**Characteristics**:
- `type: "domain"`
- `enforcement: "suggest"`
- Provides best practices
- Non-blocking

**Examples**:
- Backend development patterns
- Frontend component guidelines
- Testing strategies
- API design principles

**When to create**:
- Team coding standards
- Domain expertise
- Technology-specific patterns
- Onboarding guidance

#### Guardrail Skills
**Purpose**: Prevent mistakes and enforce rules

**Characteristics**:
- `type: "guardrail"`
- `enforcement: "suggest"` (or `"block"` sparingly)
- Catches errors
- Enforces critical rules

**Examples**:
- Security checklists
- Compliance requirements
- Breaking change prevention
- Data protection rules

**When to create**:
- Security-critical operations
- Compliance requirements
- Common mistake prevention
- Non-negotiable standards

## Using Skills Effectively

### For Your Team

**1. Capture Team Knowledge**
Turn tribal knowledge into skills:
- Code review patterns
- Architecture decisions
- Testing strategies
- Deployment procedures

**2. Onboard New Members**
Skills provide instant context:
- How we structure code
- What patterns we use
- Security requirements
- Quality standards

**3. Maintain Consistency**
Skills ensure everyone follows the same patterns:
- Naming conventions
- File organization
- Error handling
- Testing approach

**4. Evolve Over Time**
Update skills as practices improve:
- New patterns discovered
- Technology changes
- Lessons learned
- Best practices emerge

### For Individual Projects

**1. Project-Specific Patterns**
Create skills for your architecture:
- Module organization
- Data flow patterns
- Integration approaches
- Deployment steps

**2. Technology Stacks**
Skills for your tech choices:
- Framework patterns (React, Vue, etc.)
- Database approaches (Prisma, TypeORM, etc.)
- Testing tools (Jest, Vitest, etc.)
- Build systems

**3. Domain Knowledge**
Capture business logic patterns:
- Domain models
- Business rules
- Validation logic
- Workflow patterns

## Examples from Practice

### Example 1: API Development Skill

**When it helps**:
- Designing REST endpoints
- Implementing controllers
- Structuring responses
- Error handling

**Activation**:
```json
{
  "keywords": "api, endpoint, route, controller, rest",
  "filePatterns": ["src/api/**/*.ts", "src/controllers/**/*.ts"]
}
```

**Content structure**:
```
api-patterns/
├── SKILL.md              # REST basics, quick patterns
└── resources/
    ├── endpoints.md      # Endpoint design
    ├── validation.md     # Input validation
    ├── responses.md      # Response formatting
    └── errors.md         # Error handling
```

### Example 2: Security Guardrail

**When it helps**:
- Handling authentication
- Managing sensitive data
- Input validation
- Preventing common vulnerabilities

**Activation**:
```json
{
  "type": "guardrail",
  "keywords": "password, token, auth, security, sensitive",
  "filePatterns": ["**/auth/**/*", "**/*security*"]
}
```

**Content focus**:
- Input validation requirements
- Authentication patterns
- Data protection rules
- Common vulnerabilities to avoid

### Example 3: Testing Practices

**When it helps**:
- Writing unit tests
- Integration testing
- Test organization
- Mocking strategies

**Activation**:
```json
{
  "keywords": "test, testing, unit test, integration test",
  "filePatterns": ["**/*.test.ts", "**/*.spec.ts", "**/tests/**/*"]
}
```

**Content structure**:
```
testing-practices/
├── SKILL.md              # Testing overview, TDD
└── resources/
    ├── unit-tests.md     # Unit testing patterns
    ├── integration.md    # Integration testing
    ├── mocking.md        # Mocking strategies
    └── e2e.md            # E2E testing
```

## Maintenance

### Updating Skills

**When to update**:
- Team adopts new patterns
- Technology upgrades
- Common mistakes identified
- Feedback from usage
- Best practices evolve

**How to update**:
1. Edit skill file
2. Test activation still works
3. Validate JSON if changed rules
4. Commit with clear message
5. Notify team of changes

### Deprecating Skills

**When to deprecate**:
- Technology retired
- Pattern no longer used
- Merged into another skill
- No longer relevant

**How to deprecate**:
1. Add deprecation notice to SKILL.md
2. Update skill-rules.json to disable
3. Provide migration path
4. Keep file for reference
5. Remove after grace period

## Troubleshooting

### Skill Not Activating

**Check**:
1. Is skill-rules.json valid JSON?
   ```bash
   jq . .claude/hooks/skill-rules.json
   ```

2. Does skill file exist at specified path?
   ```bash
   ls -la .claude/skills/your-skill/SKILL.md
   ```

3. Are hooks executable?
   ```bash
   ls -la .claude/hooks/*.sh
   # Should show: -rwxr-xr-x
   ```

4. Do file patterns match your structure?
   ```bash
   # Test pattern matching
   find . -name "*.ts" # Check if files match pattern
   ```

5. Are keywords case-insensitive matches?
   - Keywords match case-insensitively
   - Partial matches work ("test" matches "testing")

### Skill Activating Too Often

**Solutions**:
1. Make file patterns more specific
2. Reduce keyword list
3. Split into multiple narrower skills
4. Review activation logic

### Performance Issues

**If skills load slowly**:
1. Check file sizes (should be <500 lines)
2. Reduce number of active skills
3. Make file patterns more specific
4. Remove unused skills from rules

## Resources

### Documentation

- [skill-developer SKILL.md](skill-developer/SKILL.md) - Complete guide to creating skills
- [Hooks README](../hooks/README.md) - How the activation system works
- [Showcase Repository](https://github.com/diet103/claude-code-infrastructure-showcase) - More examples

### Templates

- skill-developer provides templates and patterns
- See any existing skill for structure examples
- Copy and adapt for your needs

### Getting Help

**Common questions**:
1. **"How do I know what keywords to use?"**
   - Think: "What would I type to trigger this?"
   - Include variations and synonyms
   - Test with real prompts

2. **"How specific should file patterns be?"**
   - Specific enough to avoid false positives
   - General enough to catch all relevant files
   - Test with your actual file structure

3. **"When should I create a skill vs use an agent?"**
   - **Skill**: Ongoing guidance, auto-activates
   - **Agent**: One-time complex task, manual invoke

4. **"How do I organize complex skills?"**
   - Main file: Essential info only
   - Resources: Detailed topics
   - Each file under 500 lines
   - Clear navigation between files

## Contributing

Skills are living documentation. Improve them:

1. **Share useful patterns** you discover
2. **Update when practices change**
3. **Add examples** from real usage
4. **Remove outdated** information
5. **Simplify complex** explanations

Skills are most valuable when they reflect actual team knowledge and evolve with your practices.

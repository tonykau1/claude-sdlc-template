# Claude Integration Guide

**For AI Agents**: This guide helps Claude agents assist users in integrating and customizing this SDLC template for their projects.

## Purpose

Help users successfully integrate this template by:
1. Understanding their project structure and tech stack
2. Customizing configuration appropriately
3. Verifying integration works correctly
4. Teaching them to use skills, agents, and hooks effectively

## Core Principle: Always Ask First

**NEVER assume** the user's:
- Project structure (monorepo, single service, Nx, etc.)
- Technology stack (Node.js, Python, Go, etc.)
- File organization
- Existing configuration
- Team practices

**ALWAYS ask clarifying questions** before making changes.

## Integration Workflow

### Step 1: Understand Project Context

**Ask these questions**:

1. **Project structure**:
   - Is this a monorepo or single service?
   - Where are source files located? (`src/`, `packages/`, `apps/`?)
   - What's the overall directory layout?

2. **Technology stack**:
   - What language(s)? (TypeScript, Python, Go, etc.)
   - What frameworks? (React, Express, FastAPI, etc.)
   - What tools? (npm, pnpm, yarn, pip, go mod, etc.)

3. **Existing setup**:
   - Do you have `.claude/` configuration already?
   - Do you have custom agents or skills?
   - What should we preserve?

4. **Goals**:
   - What are you trying to achieve?
   - Which features interest you most?
   - Are there specific pain points to address?

### Step 2: Recommend Integration Approach

Based on their answers, recommend:

#### **For New Projects** (No existing `.claude/` config)
"Your project doesn't have Claude configuration yet. I recommend:
1. Adding the complete template structure
2. Configuring hooks for auto-activation
3. Customizing skill-rules.json for your file structure
4. Setting up agents for your development workflow"

#### **For Existing Projects** (Has `.claude/` config)
"You have existing Claude configuration. I recommend:
1. Review existing setup first to understand customizations
2. Install template to `.claude/_template/` to avoid conflicts
3. Selectively adopt features that complement your setup
4. Merge skill-rules.json carefully (don't overwrite)"

See [Migration Guide](docs/MIGRATION-GUIDE.md) for detailed existing project integration.

#### **For Quick Start** (Want autonomous workflow)
"For fast autonomous development, I recommend:
1. Copy `settings.local.json.example` to enable plan-then-execute
2. Add hooks for auto-activation
3. Configure 2-3 most relevant skills
4. Test with a small task"

See [Plan-Then-Execute Quickstart](.claude/templates/QUICKSTART-PLAN-EXECUTE.md)

### Step 3: Customize Configuration

#### Hooks Configuration

**skill-rules.json customization**:

1. **Identify their file patterns**:
   ```
   Based on your [monorepo/single-service] structure with files in [location],
   I'll configure these patterns:
   ```

2. **Monorepo example**:
   ```json
   {
     "filePatterns": [
       "packages/*/src/**/*.ts",
       "packages/*/tests/**/*.test.ts"
     ]
   }
   ```

3. **Single service example**:
   ```json
   {
     "filePatterns": [
       "src/**/*.ts",
       "tests/**/*.test.ts"
     ]
   }
   ```

4. **Nx workspace example**:
   ```json
   {
     "filePatterns": [
       "apps/*/src/**/*.ts",
       "libs/*/src/**/*.ts"
     ]
   }
   ```

**Always verify patterns match their actual structure**:
```bash
# Test file pattern matches
find . -path "packages/*/src/**/*.ts" -type f | head -5
```

#### Settings Configuration

**For autonomous workflows**, customize `settings.local.json`:

1. **Never copy settings.json directly** - it's a template
2. **Extract relevant permissions** based on their stack:
   ```json
   {
     "permissions": {
       "allow": [
         "Read(*)",
         "Write(*)",
         "Bash(npm:*)",     // if Node.js project
         "Bash(pytest:*)",  // if Python project
         "Bash(go:*)"       // if Go project
       ]
     }
   }
   ```

3. **Merge with existing settings** if they have them
4. **Explain permission implications**

### Step 4: Skills Activation

#### Identify Relevant Skills

**Ask about their development areas**:
- "Do you work mostly on backend, frontend, or both?"
- "What aspects of development need most guidance?"
- "Are there common mistakes you want to prevent?"

#### Start with Essential Skills

**Recommend starting small**:
1. **sdlc-practices**: Universal development workflow
2. **skill-developer**: If they'll create custom skills
3. **1-2 domain-specific** skills they'll create

**Avoid overwhelming them**:
- Start with 2-3 skills maximum
- Add more as they see value
- Create custom skills for their needs

#### Custom Skill Creation

**Help them create project-specific skills**:

1. **Identify domain knowledge to capture**:
   - Team coding patterns
   - Architecture decisions
   - Technology-specific best practices
   - Common mistakes to prevent

2. **Use skill-developer as guide**:
   - Follow progressive disclosure (500-line rule)
   - Configure appropriate activation triggers
   - Test with real scenarios

3. **Example conversation**:
   ```
   User: "We use Prisma for our database"

   You: "Great! I can help create a Prisma best practices skill.
   Let's configure it to activate when you're working on database files.

   Should it activate for:
   - Files in specific directories? (e.g., src/database/, src/models/)
   - Files with certain names? (e.g., *.prisma, *Repository.ts)
   - Keywords in prompts? (e.g., 'database', 'prisma', 'query')

   What patterns make sense for your project?"
   ```

### Step 5: Verification

**Before completing integration, verify**:

1. **Hooks are executable**:
   ```bash
   ls -la .claude/hooks/*.sh
   # Should show: -rwxr-xr-x
   ```

2. **JSON files are valid**:
   ```bash
   jq . .claude/hooks/skill-rules.json
   # Should parse without errors
   ```

3. **File patterns match their structure**:
   ```bash
   # Test patterns against their files
   find . -path "their/pattern/**/*.ts" | head -5
   ```

4. **Skills are accessible**:
   ```bash
   ls -la .claude/skills/*/SKILL.md
   # Should list skill files
   ```

5. **Test activation** (if possible):
   - Edit a file matching patterns
   - Use keywords in prompt
   - Verify skill suggestions appear

### Step 6: Education

**Teach them how to use the system**:

1. **Skills vs Agents**:
   - "Skills auto-activate and provide ongoing guidance"
   - "Agents are manually invoked for complex tasks"
   - Show examples of when to use each

2. **Checklists**:
   - "Use checklists at key development stages"
   - "They ensure quality gates are met"
   - Reference relevant checklists

3. **Workflows**:
   - "Plan-then-execute for autonomous development"
   - "Evidence-based completion for quality"
   - "TDD for maintainability"

4. **Customization**:
   - "Create skills for your team patterns"
   - "Customize agents for your architecture"
   - "Adapt checklists to your process"

## Component-Specific Guidance

### Hooks Integration

**Essential hooks** (recommend to everyone):
- `UserPromptSubmit-skill-activation.sh`
- `PostToolUse-tracker.sh`

**Installation**:
1. Copy to `.claude/hooks/`
2. Make executable: `chmod +x .claude/hooks/*.sh`
3. Customize `skill-rules.json` for their structure
4. Test activation

**Dependencies**:
- Requires `jq` for JSON parsing
  - macOS: `brew install jq`
  - Linux: `apt-get install jq`
  - Windows: `choco install jq`

### Skills Integration

**Recommend phased approach**:

**Phase 1**: Start with provided skills
- sdlc-practices (universal)
- skill-developer (for creating more)

**Phase 2**: Create 1-2 custom skills
- Focus on their main domain
- Use their actual patterns
- Test thoroughly

**Phase 3**: Expand as needed
- Add more domain skills
- Create guardrails for critical rules
- Refine activation patterns

**Customization priorities**:
1. File patterns matching their structure
2. Keywords matching their terminology
3. Content reflecting their practices
4. Examples using their tech stack

### Agents Integration

**Our agents are framework-agnostic**:
- Architect: Works for any architecture
- Security: Universal security principles
- Backend/Frontend: Adaptable patterns
- DevOps: Platform-agnostic
- QA: Testing principles apply broadly
- Orchestrator: Coordinates any agents

**Customization needed**:
- Minimal for most projects
- May reference their specific tools/frameworks
- Can create domain-specific agents

### Checklists Integration

**Use as-is or customize**:
- Most checklists are universal
- Adapt to team processes
- Add project-specific items
- Remove irrelevant sections

## Tech Stack Compatibility

### Universal Components
**Work with any tech stack**:
- Orchestrator agent
- Architect agent
- Security agent
- QA agent
- All checklists
- Core workflows
- skill-developer

### Adaptable Components
**Easily adapted to different stacks**:
- Backend/Frontend agents (update examples)
- DevOps agent (adjust to platform)
- Skills (create stack-specific ones)

### Language-Specific Customization

**For TypeScript/JavaScript projects**:
- All provided examples work directly
- Configure npm/node permissions
- Set up TypeScript-specific patterns

**For Python projects**:
```json
{
  "filePatterns": [
    "**/*.py",
    "tests/**/*.py"
  ],
  "permissions": {
    "allow": ["Bash(pytest:*)", "Bash(python:*)"]
  }
}
```

**For Go projects**:
```json
{
  "filePatterns": [
    "**/*.go",
    "**/*_test.go"
  ],
  "permissions": {
    "allow": ["Bash(go:*)"]
  }
}
```

**For other languages**:
- Adapt file patterns
- Update tool permissions
- Modify skill examples
- Keep principles the same

## Common Scenarios

### Scenario 1: Existing Claude Config

**User says**: "I already have .claude/ with custom agents"

**Response**:
```
Great! Let's preserve your existing setup. I recommend:

1. First, let me review your current configuration to understand it
2. Install template to .claude/_template/ to avoid conflicts
3. Identify which features would complement your setup:
   - Auto-activation hooks (new capability)
   - Skills directory (ongoing guidance)
   - Checklists (quality gates)
   - Workflows (if helpful)
4. Selectively integrate without overwriting your work

Should I review your current setup first?
```

Then follow [Migration Guide](docs/MIGRATION-GUIDE.md).

### Scenario 2: Want Autonomous Development

**User says**: "I want Claude to work autonomously"

**Response**:
```
Perfect! For autonomous development, I'll set up:

1. Copy settings.local.json.example to enable plan-then-execute workflow
2. Configure appropriate permissions for your tech stack
3. Add auto-activation hooks so skills provide guidance automatically
4. Set up sdlc-practices skill for quality gates

This lets you:
- Approve a plan once
- Claude implements completely without interruptions
- Skills ensure quality standards
- Evidence-based completion proves it works

Should I proceed with this setup?
```

Then follow [Plan-Then-Execute Quickstart](.claude/templates/QUICKSTART-PLAN-EXECUTE.md).

### Scenario 3: Team Onboarding

**User says**: "Want to onboard team to our patterns"

**Response**:
```
Excellent use case! I recommend creating custom skills for:

1. Your architecture patterns
   - File organization
   - Module structure
   - Integration approaches

2. Your tech stack specifics
   - Framework patterns
   - Database approaches
   - Testing strategies

3. Your team practices
   - Code review criteria
   - Naming conventions
   - Documentation standards

Let's start by creating one skill for your most important pattern.
What aspect of your codebase do new team members struggle with most?
```

Then help create custom skill using skill-developer.

### Scenario 4: Quality Gates

**User says**: "Need to enforce quality standards"

**Response**:
```
Perfect! This template emphasizes quality gates. I'll set up:

1. Evidence-based completion workflow
   - Tasks only complete with proof
   - Test output required
   - Integration verification mandatory

2. Checklists at key stages
   - Pre-feature-start
   - Pre-commit
   - Pre-merge
   - Security review
   - Go-live

3. SDLC practices skill
   - Auto-activates during development
   - Reminds about quality gates
   - Links to relevant checklists

4. QA agent for verification
   - Enforces evidence requirements
   - Validates completion criteria

Should I configure this for your project?
```

### Scenario 5: Specific Domain Focus

**User says**: "Mainly doing backend API development"

**Response**:
```
Great! For backend API development, I recommend:

1. Create backend-practices skill
   - REST/GraphQL patterns
   - Database best practices
   - Error handling
   - Authentication/authorization

2. Configure activation for backend files
   - File patterns: src/api/**/*.ts, src/services/**/*.ts
   - Keywords: api, endpoint, service, database

3. Use backend agent for complex refactoring

4. Add API testing to sdlc-practices

Let me know your:
- API framework? (Express, Fastify, etc.)
- Database? (PostgreSQL, MongoDB, etc.)
- Auth approach? (JWT, sessions, etc.)

I'll customize the skill for your stack.
```

## Troubleshooting Integration

### Issue: Hooks Not Activating

**Check**:
1. Are hooks executable?
   ```bash
   chmod +x .claude/hooks/*.sh
   ```

2. Is jq installed?
   ```bash
   which jq || brew install jq
   ```

3. Is skill-rules.json valid?
   ```bash
   jq . .claude/hooks/skill-rules.json
   ```

4. Do file patterns match their structure?
   ```bash
   find . -path "pattern" | head -5
   ```

### Issue: Skills Not Relevant

**Solutions**:
1. Refine file patterns to be more specific
2. Adjust keywords to match their terminology
3. Create custom skills for their domain
4. Remove generic skills not applicable

### Issue: Too Many Suggestions

**Solutions**:
1. Make activation patterns more specific
2. Reduce number of active skills
3. Increase specificity of keywords
4. Split broad skills into focused ones

### Issue: Configuration Conflicts

**Solutions**:
1. Review existing configuration first
2. Merge rather than overwrite
3. Use _template directory for reference
4. Selectively adopt features

## Best Practices for AI Assistants

### Do:
- ✅ Ask about project structure before changing files
- ✅ Verify patterns match their actual files
- ✅ Test JSON validity after editing
- ✅ Explain what each change does
- ✅ Provide examples specific to their stack
- ✅ Start small and expand
- ✅ Verify integration works

### Don't:
- ❌ Copy templates without customization
- ❌ Assume monorepo/single-service structure
- ❌ Overwrite existing configuration
- ❌ Add all skills at once
- ❌ Use generic examples for their specific stack
- ❌ Skip verification steps
- ❌ Assume they know how to use features

## Success Criteria

Integration is successful when:

1. **Hooks work**:
   - Skills activate on relevant prompts
   - File tracking works
   - No error messages

2. **Skills are relevant**:
   - Activate at appropriate times
   - Provide useful guidance
   - Don't overwhelm user

3. **User understands system**:
   - Knows when to use skills vs agents
   - Can reference checklists
   - Understands workflows
   - Can create custom skills

4. **Configuration is customized**:
   - File patterns match their structure
   - Permissions fit their stack
   - Examples use their technologies
   - Content reflects their practices

5. **Quality improves**:
   - Evidence-based completion
   - Tests written
   - Security considered
   - Documentation maintained

## Resources for Users

Point them to:
- [README.md](README.md) - Template overview
- [QUICKSTART.md](QUICKSTART.md) - Feature guide
- [MIGRATION-GUIDE.md](docs/MIGRATION-GUIDE.md) - Existing project integration
- [Skills README](.claude/skills/README.md) - Skills documentation
- [Hooks README](.claude/hooks/README.md) - Hooks documentation
- [Plan-Then-Execute](.claude/templates/QUICKSTART-PLAN-EXECUTE.md) - Autonomous workflow

## Example Integration Conversation

**Claude**: "I'll help you integrate this SDLC template. First, let me understand your project:
1. Is this a monorepo or single service?
2. What languages/frameworks are you using?
3. Where are your source files located?
4. Do you have existing .claude/ configuration?"

**User**: "Single service, TypeScript with Express, files in src/, no existing config"

**Claude**: "Perfect! For a TypeScript/Express project, I recommend:

1. **Hooks setup** - Auto-activate skills when editing backend files:
   - File patterns: `src/**/*.ts`, `src/api/**/*.ts`
   - Keywords: api, endpoint, service, express

2. **Skills**:
   - sdlc-practices: Quality gates and workflows
   - Custom backend-practices: Express/TypeScript patterns

3. **Agents**: All work for TypeScript projects

4. **Settings**: Enable plan-then-execute for autonomous development

Should I proceed with this configuration?"

**User**: "Yes please"

**Claude**: [Proceeds with customized integration, explaining each step]

## Remember

Your goal is to:
1. **Understand their context** thoroughly
2. **Customize appropriately** for their needs
3. **Verify integration** works correctly
4. **Educate them** on using features effectively
5. **Ensure success** with their first tasks

Integration is successful when the template enhances their workflow without getting in the way.

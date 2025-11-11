# Migration Guide: Integrating SDLC Template into Existing Projects

## Overview

If your project already has `.claude/` configuration with custom agents, settings, or business logic, this guide will help you safely integrate the SDLC template without losing your existing work.

## Quick Assessment

Before starting, check what you have:

```bash
cd your-project

# Check existing structure
ls -la .claude/

# Common existing files:
# - .claude/claude.md          # Main agent file
# - .claude/agents/*.md         # Custom agents
# - .claude/settings.json       # Permissions/hooks
# - .claude/settings.local.json # Local overrides
# - docs/project/               # Project-specific docs (preferred location)
```

## Migration Strategy: Side-by-Side Integration

The safest approach is to install the template alongside your existing config, then gradually migrate.

### Step 1: Backup Your Existing Configuration

```bash
# Create backup
cp -r .claude .claude.backup

# Or create a git commit
git add .claude
git commit -m "backup: preserve existing .claude config before SDLC template integration"
```

### Step 2: Install Template as Subtree (Preserves Your Files)

```bash
# Install template in _template subdirectory (doesn't overwrite your files)
git subtree add --prefix .claude/_template \
  https://github.com/yourorg/claude-sdlc-template.git main --squash
```

Your structure now looks like:
```
.claude/
├── claude.md                    # YOUR existing file - preserved!
├── agents/                      # YOUR existing agents - preserved!
│   └── my-custom-agent.md
├── settings.json                # YOUR existing settings - preserved!
├── _template/                   # NEW: SDLC template (read-only reference)
│   ├── agents/
│   │   ├── orchestrator.md
│   │   ├── architect.md
│   │   └── ...
│   ├── checklists/
│   └── templates/
└── project/                     # YOUR project-specific docs - preserved!
```

### Step 3: Extract Business Logic from Existing Agents

Now let's safely move your business logic out of agent files into project-specific documentation.

#### 3.1: Identify What's Business Logic vs. General Patterns

**Business Logic** (extract and preserve):
- Domain-specific terminology ("our users are called 'merchants'")
- Business rules ("commission is 2.5% for standard, 1.5% for premium")
- Product features ("we support 3 subscription tiers")
- API endpoints specific to your product
- Database schemas unique to your app
- Regulatory requirements (HIPAA, FINRA, etc.)
- Company-specific tools/services

**General Patterns** (can use template versions):
- Generic security best practices
- Standard code quality guidelines
- General testing strategies
- Common architectural patterns

#### 3.2: Create Business Logic Documentation

```bash
# Create organized structure for your business knowledge
mkdir -p docs/project/{business,architecture,features,domain,apis,standards,security,testing,operations}
```

#### 3.3: Extract from Existing Agents

Let's say you have a custom agent with business logic. Here's how to extract it:

**Example - Your existing `.claude/agents/payments-agent.md`:**
```markdown
# Payments Agent

You handle payment processing using Stripe and Helio.

## Business Rules
- Standard users: 2.5% commission
- Premium users: 1.5% commission
- Commission caps at $500 per transaction

## Our Payment Flow
1. User initiates checkout
2. We create Stripe PaymentIntent
3. Helio processes crypto payments
4. Webhook updates order status

## Security
- Follow OWASP guidelines
- Use JWT authentication
- ...general security stuff...
```

**Extract to new structure:**

**`docs/project/business/payment-rules.md`** (business logic):
```markdown
# Payment Business Rules

## Commission Structure
- Standard users: 2.5% commission
- Premium users: 1.5% commission
- Commission caps at $500 per transaction
- Refunds process within 7 business days

## Payment Processors
- Stripe: Credit card subscriptions
- Helio: Crypto payments (SOL, USDC)
- Both require webhook signature verification

## Regulatory Compliance
- PCI DSS Level 1 compliant
- Support chargebacks per Visa/Mastercard rules
```

**`docs/project/architecture/payment-flow.md`** (implementation details):
```markdown
# Payment System Architecture

## Flow Diagram
[Your payment flow diagram]

## Integration Points
- Stripe API v2023-10-16
- Helio Production endpoints
- Webhook URLs: /api/webhooks/stripe, /api/webhooks/helio

## Database Schema
See: `docs/project/architecture/schema/payments-tables.sql`
```

**Reference the SDLC template's payment agent** (if applicable):
```markdown
# Using Payment Agent

For payment implementation, reference:
- General patterns: `.claude/_template/agents/backend.md`
- Security: `.claude/_template/agents/security.md`
- Business rules: `docs/project/business/payment-rules.md`
- Architecture: `docs/project/architecture/payment-flow.md`
```

### Step 4: Update Your Main claude.md

Edit your existing `.claude/claude.md` to reference both your business logic AND the template:

```markdown
# [Your Project Name]

## Project Context
[Your business context - keep this!]

## Reference SDLC Template
This project uses the Claude SDLC Template for best practices.
Template agents and checklists: `.claude/_template/`

## Business-Specific Information

### Domain Knowledge
See: `docs/project/business/` for:
- Payment rules and commission structure
- User tier system (anonymous/authenticated/premium)
- Referral program mechanics
- Regulatory requirements

### Architecture
See: `docs/project/architecture/` for:
- System architecture diagrams
- Database schema
- API specifications
- Payment flow
- Authentication system

### Tech Stack
[Your actual stack]
- Frontend: Next.js 14, React 18, TailwindCSS
- Backend: Next.js API routes, Supabase
- Database: PostgreSQL with pgvector
- Payments: Stripe, Helio
- Hosting: Vercel

## Development Workflow

Use the SDLC template workflow:
1. **Planning**: Use `.claude/_template/checklists/pre-feature-start.md`
2. **Development**: Reference relevant agents from `.claude/_template/agents/`
3. **Completion**: Use `.claude/_template/templates/completion-report-template.md`

### Business-Specific Guidelines
[Your company-specific practices that differ from template]

## Important Files & Locations

### Business Logic (OURS - project-specific)
- `docs/project/business/` - Business rules and domain knowledge
- `docs/project/architecture/` - System design and schemas
- `docs/project/features/` - Feature specifications

### Best Practices (TEMPLATE - universal patterns)
- `.claude/_template/agents/` - Specialized agent patterns
- `.claude/_template/checklists/` - Development checklists
- `.claude/_template/templates/standards/` - Code standards

## Agent Instructions

When working on this project:
1. **First**, read business logic from `docs/project/`
2. **Then**, apply best practices from `.claude/_template/`
3. **Always** consider our specific business rules
4. **Reference** template agents for general patterns
```

### Step 5: Gradually Adopt Template Patterns

You don't have to replace everything at once. Adopt incrementally:

#### Week 1: Start Using Checklists
```bash
# Reference template checklists in your workflow
# Don't need to change any code, just start using them
```

#### Week 2: Use Orchestrator for Complex Tasks
```markdown
# In your .claude/claude.md, add:

## Using Orchestrator
For multi-domain features, use `.claude/_template/agents/orchestrator.md`
to coordinate between specialists.
```

#### Week 3: Adopt Completion Reports
```bash
# Start using evidence-based completion
cp .claude/_template/templates/completion-report-template.md \
   docs/project/templates/completion-report.md
```

#### Week 4+: Migrate Custom Agents (Optional)
Gradually replace custom agents with template versions + business logic docs.

## Migration Patterns

### Pattern 1: Custom Agent → Template Agent + Business Docs

**Before:**
```
.claude/agents/payment-specialist.md  (500 lines of mixed content)
```

**After:**
```
.claude/_template/agents/backend.md   (template patterns)
docs/project/business/payments.md  (your business rules)
docs/project/architecture/payment-system.md (your architecture)
```

### Pattern 2: Settings Migration

**Your existing `.claude/settings.json`:**
```json
{
  "permissions": {
    "allow": ["Bash(npm:*)"]
  }
}
```

**Template's `.claude/_template/templates/settings.local.json.example`:**
```json
{
  "permissions": {
    "allow": [
      "Read(*)", "Write(*)", "Edit(*)",
      "Bash(npm:*)", "Bash(psql:*)"
    ]
  }
}
```

**Merge into your `.claude/settings.local.json`:**
```json
{
  "permissions": {
    "allow": [
      // Your existing permissions
      "Bash(npm:*)",

      // Add template's plan-then-execute permissions
      "Read(*)",
      "Write(*)",
      "Edit(*)",
      "Bash(npm test:*)",
      "Bash(psql -d dev_db:*)"
    ],
    "deny": [
      // Keep your denials + add template safety
      "Bash(rm -rf:*)",
      "Bash(git push --force:*)"
    ]
  }
}
```

### Pattern 3: Keeping Custom Agents Alongside Template

You can keep custom agents that are truly unique:

```
.claude/
├── agents/                       # YOUR custom agents
│   └── crypto-trading-agent.md   # Highly specific to your domain
├── _template/                    # TEMPLATE universal patterns
│   └── agents/
│       ├── orchestrator.md
│       └── ...
└── claude.md                     # References both
```

In your `claude.md`:
```markdown
## Specialized Agents

### Domain-Specific (Project-Specific)
- Crypto Trading: `.claude/agents/crypto-trading-agent.md`
  For Solana token analysis and trading strategies

### Universal Best Practices (Template)
- Orchestrator: `.claude/_template/agents/orchestrator.md`
- Security: `.claude/_template/agents/security.md`
- Backend: `.claude/_template/agents/backend.md`
```

## Common Scenarios

### Scenario 1: "We have detailed API documentation in our agent"

**Extract:**
```bash
# Move API docs to project structure
mkdir -p docs/project/apis
mv your-api-docs.md docs/project/apis/

# Reference in claude.md:
## API Documentation
See: `docs/project/apis/` for endpoint specifications
```

### Scenario 2: "Our agents have company-specific coding standards"

**Extract:**
```bash
mkdir -p docs/project/standards
# Move standards to:
docs/project/standards/
├── code-style.md      # Your linting rules, naming conventions
├── git-workflow.md    # Your branching strategy
├── review-process.md  # Your PR requirements

# Use template standards as baseline:
# Reference `.claude/_template/templates/standards/file-size-discipline.md`
# Add your customizations in `docs/project/standards/`
```

### Scenario 3: "We have custom tools/scripts agents need to know about"

**Document:**
```markdown
# docs/project/tools/custom-tools.md

## Custom Scripts

### Data Analysis
- `npm run analyze-users`: Generate user behavior reports
- `npm run sync-blockchain`: Sync Solana data to DB

### Development Tools
- `npm run generate-types`: Generate TypeScript types from DB schema
- `npm run test-webhooks`: Test payment webhook handling locally

## Agent Instructions
When analyzing data, use `npm run analyze-users`
When working with Solana data, run `npm run sync-blockchain` first
```

## Checklist: Safe Migration

Use this checklist to ensure nothing is lost:

### Pre-Migration
- [ ] Backup `.claude/` directory
- [ ] Create git commit of current state
- [ ] Document what business logic exists in current agents
- [ ] List custom settings/permissions

### During Migration
- [ ] Install template as `.claude/_template/` (preserves your files)
- [ ] Create `docs/project/` structure
- [ ] Extract business logic to `docs/project/business/`
- [ ] Extract architecture to `docs/project/architecture/`
- [ ] Extract domain knowledge to appropriate locations
- [ ] Update `.claude/claude.md` to reference both template and business logic

### Post-Migration
- [ ] Test that agents can still access business information
- [ ] Verify custom permissions still work
- [ ] Confirm no business logic was lost
- [ ] Update team documentation
- [ ] Create ADR documenting the migration

### Validation
- [ ] Ask agent: "What are our payment commission rates?" (should find business docs)
- [ ] Ask agent: "Use the orchestrator for a complex task" (should use template)
- [ ] Ask agent: "What's our tech stack?" (should find your project info)
- [ ] Try plan-then-execute workflow (should work with template settings)

## Best Practices

### 1. Keep Business Logic Discoverable

Use clear, consistent locations:
```
docs/project/
├── business/           # Business rules, domain knowledge
├── architecture/       # System design, schemas, APIs
├── features/          # Feature specifications
├── standards/         # Company-specific standards (if different from template)
└── tools/             # Custom scripts and tools
```

### 2. Reference, Don't Duplicate

In your `.claude/claude.md`:
```markdown
## Security

**General practices**: See `.claude/_template/agents/security.md`
**Our specific requirements**:
- HIPAA compliance checklist: `docs/project/business/hipaa-requirements.md`
- PCI DSS validation: `docs/project/security/pci-compliance.md`
```

### 3. Use Template as Foundation

Think of template as the standard library, your project docs as the application code:
- Template = "how to build secure APIs in general"
- Your docs = "our specific API endpoints and authentication flow"

### 4. Document the Structure

Add to your project's README.md:
```markdown
## Claude Code Configuration

This project uses the Claude SDLC Template with project-specific extensions:

- **Template** (`.claude/_template/`): Universal best practices and patterns
- **Project** (`docs/project/`): Our business logic and domain knowledge
- **Main file** (`.claude/claude.md`): Integration point

When working with Claude Code:
1. Business context comes from `docs/project/`
2. Best practices come from `.claude/_template/`
3. See `.claude/claude.md` for the complete picture
```

## Troubleshooting

### "Agent can't find my business rules"

**Problem**: After migration, agent doesn't reference your business logic.

**Solution**: Update `.claude/claude.md` with explicit instructions:
```markdown
## IMPORTANT: Business Logic Location

All business rules are in `docs/project/business/`
Always read these files before implementing features:
- `docs/project/business/payment-rules.md`
- `docs/project/business/user-tiers.md`
- `docs/project/business/referral-program.md`
```

### "Template overwrote my custom agent"

**Problem**: You accidentally replaced your custom agent with template.

**Solution**: Restore from backup:
```bash
# Restore specific file
cp .claude.backup/agents/my-agent.md .claude/agents/

# Or restore from git
git checkout HEAD~1 -- .claude/agents/my-agent.md

# Then extract business logic following the guide above
```

### "Settings conflict between template and mine"

**Problem**: Template settings override your custom permissions.

**Solution**: Keep your settings in `.claude/settings.local.json` (never committed):
```bash
# Your local settings take precedence
.claude/settings.local.json   # Your custom settings (gitignored)
.claude/_template/...         # Template reference only

# Merge the two manually in your settings.local.json
```

## Example: Complete Migration

Here's a before/after for a real project:

### Before Migration

```
.claude/
├── claude.md                    # 800 lines, mixed content
└── agents/
    ├── payment-handler.md       # Business logic + patterns
    └── crypto-analyzer.md       # Business logic + patterns
```

### After Migration

```
.claude/
├── claude.md                    # 200 lines, clean integration
├── agents/                      # Keep truly unique agents
│   └── crypto-trading-signals.md  # Highly specialized domain logic
├── project/                     # Your business knowledge (NEW)
│   ├── business/
│   │   ├── payment-rules.md
│   │   ├── commission-structure.md
│   │   ├── user-tiers.md
│   │   └── referral-program.md
│   ├── architecture/
│   │   ├── payment-system.md
│   │   ├── blockchain-integration.md
│   │   └── schemas/
│   ├── features/
│   │   └── [feature specs]
│   └── apis/
│       └── [API documentation]
├── settings.local.json          # Your merged settings
└── _template/                   # SDLC template (NEW)
    ├── agents/
    │   ├── orchestrator.md
    │   ├── architect.md
    │   ├── security.md
    │   └── ...
    ├── checklists/
    └── templates/
```

**Benefits after migration:**
- ✅ Business logic preserved and organized
- ✅ Access to template's orchestrator, completion reports, file size discipline
- ✅ Clear separation: business vs. best practices
- ✅ Easy to update template without affecting business docs
- ✅ Team onboarding: "business in project/, patterns in _template/"

## Summary

**Migration = Reorganize, Don't Replace**

1. **Install template as `.claude/_template/`** (side-by-side, non-destructive)
2. **Extract business logic** to `docs/project/`
3. **Update `.claude/claude.md`** to reference both
4. **Gradually adopt** template features (orchestrator, checklists, standards)
5. **Keep what's unique** (truly domain-specific agents if needed)

Your business knowledge is preserved, organized, and enhanced with universal best practices.

## Next Steps

1. Follow this guide step-by-step
2. Create an ADR documenting your migration: `docs/project/architecture/decisions/001-integrate-sdlc-template.md`
3. Update team documentation
4. Start using plan-then-execute workflow!

Need help? See the template's [CONTRIBUTING.md](../CONTRIBUTING.md) for questions.

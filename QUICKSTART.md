# Quick Start Guide

## What You Have

Your Claude SDLC Template is complete and ready to use! Here's what was created:

```
claude-sdlc-template/
├── .claude/
│   ├── agents/                    # 6 specialized AI agent configs
│   │   ├── architect.md           # Architecture decisions & patterns
│   │   ├── backend.md             # API & business logic
│   │   ├── devops.md              # Infrastructure & deployment
│   │   ├── frontend.md            # UI/UX & accessibility
│   │   ├── qa.md                  # Testing strategies
│   │   └── security.md            # Security reviews & threat modeling
│   ├── checklists/                # Development checklists
│   │   ├── pre-feature-start.md   # Before coding
│   │   ├── pre-commit.md          # Before committing
│   │   ├── pre-merge.md           # Before merging PR
│   │   ├── security-review.md     # Security validation
│   │   └── go-live.md             # Production readiness
│   └── templates/                 # Document templates
│       ├── claude.md.template     # Main agent file template
│       ├── adr-template.md        # Architecture Decision Records
│       ├── feature-spec-template.md
│       ├── bug-report-template.md
│       ├── postmortem-template.md
│       └── 001-example-database-choice.md  # Example ADR
├── scripts/
│   ├── init-project.sh            # Initialize new project
│   ├── sync-from-template.sh      # Pull template updates
│   └── contribute-back.sh         # Push improvements back
├── docs/
│   ├── SETUP.md                   # Detailed setup guide
│   └── CONTRIBUTING.md            # Contribution guidelines
├── README.md                      # Main documentation
├── CHANGELOG.md                   # Version history
├── VERSION                        # Current version (0.1.0)
├── LICENSE                        # MIT License
└── .gitignore                     # Git ignore rules
```

## Next Steps

### 1. Test the Template

Create a test project to try it out:

```bash
cd claude-sdlc-template
./scripts/init-project.sh my-test-project
cd my-test-project
```

### 2. Customize for Your Needs

Before using in production:

1. **Update URLs in scripts**
   - Edit `scripts/*.sh`
   - Replace `https://github.com/yourorg/claude-sdlc-template.git` with your actual repo URL

2. **Customize README**
   - Add your organization name
   - Add contact information
   - Update license if needed

3. **Review Agent Configurations**
   - Ensure they match your development philosophy
   - Add any organization-specific patterns

### 3. Push to Git

Initialize as a git repository:

```bash
cd claude-sdlc-template
git init
git add .
git commit -m "Initial commit: Claude SDLC Template v0.1.0"

# Add your remote
git remote add origin https://github.com/yourorg/claude-sdlc-template.git
git push -u origin main
```

### 4. Use in a Real Project

#### Option A: New Project
```bash
./scripts/init-project.sh my-real-project
cd my-real-project

# Customize .claude/claude.md with your project details
# Fill out business requirements
# Start building!
```

#### Option B: Existing Project
```bash
cd my-existing-project

# Add as git subtree
git subtree add --prefix .claude/_template \
  https://github.com/yourorg/claude-sdlc-template.git main --squash

# Create project-specific structure
mkdir -p .claude/project/{architecture,business,features,standards,security,testing,operations}

# Copy and customize main file
cp .claude/_template/templates/claude.md.template .claude/claude.md
```

### 5. Start Claude Code

```bash
claude code

# Claude will read .claude/claude.md and use the agents/checklists as needed
```

## Key Features to Explore

### 1. Architecture Decision Records (ADRs)
Document significant decisions:
```bash
cp .claude/_template/templates/adr-template.md \
   .claude/project/architecture/decisions/001-my-decision.md
```

See the example: `.claude/_template/templates/001-example-database-choice.md`

### 2. Specialized Agents
Reference agents for specific concerns:
- "Can you review this feature using the security agent guidelines?"
- "Let's do an architecture review following the architect agent patterns"
- "Check this component against the frontend agent's accessibility checklist"

### 3. Development Checklists
Use before major milestones:
- Before starting: `.claude/_template/checklists/pre-feature-start.md`
- Before committing: `.claude/_template/checklists/pre-commit.md`
- Before merging: `.claude/_template/checklists/pre-merge.md`
- Before launching: `.claude/_template/checklists/go-live.md`

### 4. Feature Specifications
Document features thoroughly:
```bash
mkdir .claude/project/features/user-authentication
cp .claude/_template/templates/feature-spec-template.md \
   .claude/project/features/user-authentication/spec.md
```

## Tips for Success

1. **Read the documentation first**
   - Start with `README.md`
   - Then `docs/SETUP.md`
   - Reference agents as needed

2. **Customize before using**
   - Update repository URLs in scripts
   - Adjust agents to match your philosophy
   - Add organization-specific patterns

3. **Keep template updated**
   - Run `./scripts/sync-from-template.sh` monthly
   - Contribute improvements back
   - Watch for new versions

4. **Document as you go**
   - Create ADRs for significant decisions
   - Keep feature specs up to date
   - Update checklists based on learnings

5. **Interactive development**
   - Ask Claude questions before assuming
   - Reference specific agents/checklists
   - Build iteratively with frequent commits

## Common Questions

**Q: Do I have to use all the agents?**
A: No! Use what's relevant. They're there when you need them.

**Q: Can I modify the templates?**
A: Yes for your projects. Keep universal improvements separate to contribute back.

**Q: How do I keep multiple projects in sync?**
A: Use `./scripts/sync-from-template.sh` in each project to pull updates.

**Q: What if I want to add my own agents?**
A: Add them to `.claude/project/agents/` - project-specific agents stay local.

**Q: Is this only for Claude Code?**
A: Primarily, but any AI agent that can read context will benefit.

## Getting Help

- **Issues:** Check the GitHub issues
- **Documentation:** See `docs/SETUP.md`
- **Examples:** Look at the template files
- **Community:** [Add your community link]

## What's Next?

1. ✅ Template created
2. ✅ Files written
3. → Customize for your organization
4. → Push to your git repository
5. → Test with a sample project
6. → Roll out to your team
7. → Iterate and improve!

---

**Ready to build better software with AI assistance!** 🚀

For detailed setup instructions, see `docs/SETUP.md`

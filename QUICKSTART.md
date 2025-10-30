# Quick Start Guide

## What You Have

Your Claude SDLC Template is complete and ready to use! Here's what was created:

```
claude-sdlc-template/
├── .claude/
│   ├── agents/                    # 7 specialized AI agent configs
│   │   ├── orchestrator.md        # Multi-agent coordinator
│   │   ├── architect.md           # Architecture decisions & patterns
│   │   ├── backend.md             # API & business logic
│   │   ├── devops.md              # Infrastructure & deployment
│   │   ├── frontend.md            # UI/UX & accessibility
│   │   ├── qa.md                  # Testing & quality gates
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
│       ├── agent-template.md      # Create custom agents
│       ├── completion-report-template.md  # Evidence-based completion
│       ├── feature-spec-template.md
│       ├── bug-report-template.md
│       ├── postmortem-template.md
│       ├── yolo-mode-setup.md     # YOLO mode configuration
│       ├── plan-then-execute-workflow.md  # Autonomous workflow
│       ├── QUICKSTART-PLAN-EXECUTE.md     # 30-second setup
│       ├── settings.local.json.example    # Permissions config
│       ├── standards/
│       │   └── file-size-discipline.md    # Code maintainability
│       └── 001-example-database-choice.md
├── scripts/
│   ├── init-project.sh            # Initialize new project
│   ├── sync-from-template.sh      # Pull template updates
│   └── contribute-back.sh         # Push improvements back
├── docs/
│   ├── SETUP.md                   # Detailed setup guide
│   └── CONTRIBUTING.md            # Contribution guidelines
├── README.md                      # Main documentation
├── CHANGELOG.md                   # Version history
├── VERSION                        # Current version (0.2.0)
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

### 1. Plan-Then-Execute Workflow
Maximum velocity with autonomous execution:
```bash
# Quick setup (30 seconds)
cp .claude/_template/templates/settings.local.json.example .claude/settings.local.json

# Add to your .claude/claude.md:
## Development Mode: Plan-Then-Execute
Work autonomously after plan approval - no interruptions!
```

See: `.claude/_template/templates/QUICKSTART-PLAN-EXECUTE.md`

**How it works:**
1. You: "Build feature X"
2. Agent: [Presents comprehensive plan]
3. You: "Approved"
4. Agent: [Executes completely without asking - reads, writes, tests, commits]
5. Agent: "Done! Here's the evidence it works"

### 2. Orchestrator Agent
Coordinate multiple specialists for complex tasks:
- Automatically routes work to appropriate agents
- Manages multi-domain features (DB + API + UI)
- Ensures quality gates before completion
- "Build a real-time notification system" → orchestrator coordinates all agents

### 3. File Size Discipline
Keep code maintainable with automated checks:
- 200 LOC target, 250 LOC maximum per file
- Automatic refactoring triggers (150/180/200 LOC)
- Prevents bloated, unmaintainable code
- Built into all agents and checklists

See: `.claude/_template/templates/standards/file-size-discipline.md`

### 4. Evidence-Based Completion
Agents must prove functionality works:
- Test output showing functionality
- LOC counts for all modified files
- Screenshots or examples
- Integration verification
- No more "task complete" without proof!

See: `.claude/_template/templates/completion-report-template.md`

### 5. Architecture Decision Records (ADRs)
Document significant decisions:
```bash
cp .claude/_template/templates/adr-template.md \
   .claude/project/architecture/decisions/001-my-decision.md
```

### 6. Specialized Agents
All agents include:
- Reading protocols (prevent LLM hallucinations)
- Completion verification requirements
- File size discipline
- Evidence-based reporting

Use them:
- "Review this with the security agent"
- "Architect, design the notification system"
- "Orchestrator, coordinate this multi-domain feature"

### 7. Development Checklists
Validation at key milestones:
- Before starting: `.claude/_template/checklists/pre-feature-start.md`
- Before committing: `.claude/_template/checklists/pre-commit.md`
- Before merging: `.claude/_template/checklists/pre-merge.md`
- Before launching: `.claude/_template/checklists/go-live.md`

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

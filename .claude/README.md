# Claude SDLC Template - Configuration Directory

This directory contains all Claude Code configuration, agents, skills, hooks, and documentation. Everything you need to bring this template to other projects is contained here.

## 🎯 Portability

**To use this template in another project:**

```bash
# Copy the entire .claude/ directory to your project
cp -r /path/to/template/.claude /path/to/your-project/

# Install hook dependencies (one-time)
cd /path/to/your-project/.claude/hooks
npm install

# Customize for your project
vim .claude/CLAUDE.md              # Update project details
vim .claude/skills/skill-rules.json # Adjust file patterns
vim .claude/settings.local.json     # Add local permissions
```

That's it! Everything you need is self-contained in this directory.

---

## 📁 Directory Structure

```
.claude/
├── README.md                    # This file
├── CLAUDE.md                    # Main agent instructions (customize this!)
├── QUICK-START.md              # Quick setup guide
├── settings.json               # Shared permissions and hooks
├── settings.local.json.example # Template for local settings
│
├── agents/                     # Specialized agent prompts
│   ├── orchestrator.md         # Task coordination
│   ├── architect.md            # System design
│   ├── qa.md                   # Testing & quality
│   ├── backend.md              # Backend development
│   ├── frontend.md             # Frontend development
│   ├── devops.md               # Infrastructure & deployment
│   └── security.md             # Security review
│
├── skills/                     # Auto-activating skills
│   ├── skill-rules.json        # Skill activation configuration
│   ├── skill-developer/        # Meta-skill for creating skills
│   ├── sdlc-practices/         # SDLC best practices
│   └── README.md               # Skills documentation
│
├── hooks/                      # Automation hooks
│   ├── skill-activation-prompt.ts        # TypeScript hook
│   ├── UserPromptSubmit-skill-activation.sh
│   ├── PostToolUse-tracker.sh
│   ├── package.json            # Hook dependencies
│   └── README.md               # Hooks documentation
│
├── checklists/                 # Quality gate checklists
│   ├── pre-feature-start.md
│   ├── pre-commit.md
│   └── completion-report.md
│
├── templates/                  # Document templates
│   ├── adr-template.md         # Architecture decision records
│   ├── feature-spec-template.md
│   └── completion-report-template.md
│
├── project/                    # YOUR project-specific docs
│   ├── architecture/
│   ├── business/
│   ├── features/
│   ├── standards/
│   └── security/
│
└── docs/                       # Template documentation
    ├── QUICKSTART.md           # Getting started guide
    ├── SETUP.md                # Detailed setup
    ├── MIGRATION-GUIDE.md      # For existing projects
    ├── SHOWCASE-INTEGRATION.md # Auto-activation guide
    ├── WHATS-NEW.md            # Feature overview
    ├── CLAUDE-SETTINGS.md      # Settings troubleshooting
    └── CONTRIBUTING.md         # Contribution guide
```

---

## 🚀 Quick Start

### 1. First Time Setup

```bash
cd .claude/hooks
npm install
chmod +x *.sh
```

### 2. Customize for Your Project

Edit these files:
- `CLAUDE.md` - Update project name, tech stack, team info
- `skills/skill-rules.json` - Adjust file patterns to match your structure
- `project/` - Add your business logic and domain knowledge

### 3. Start Using

Just use Claude Code normally. Skills will auto-activate based on your prompts and files!

---

## 📚 Core Features

### 1. Auto-Activating Skills

Skills appear automatically when you need them:
- Keywords in prompts trigger relevant skills
- File types activate domain-specific guidance
- Quality gates enforced automatically

**Example:**
```
You: "I want to implement authentication"
Claude: 🎯 Activating: security-review, backend-dev-guidelines
```

### 2. Specialized Agents

Manually invoke for complex tasks:
- `/orchestrator` - Coordinate multi-domain tasks
- `/architect` - Design system architecture
- `/qa` - Testing and quality assurance
- `/security` - Security review

### 3. Quality Checklists

Comprehensive checklists for:
- Pre-feature development
- Pre-commit verification
- Completion evidence

### 4. Template Library

Reusable templates:
- Architecture Decision Records (ADRs)
- Feature specifications
- Completion reports
- Technical designs

---

## ⚙️ Configuration Files

### CLAUDE.md
Main instructions for Claude. **Customize this file** with:
- Your project name and description
- Tech stack details
- Team structure
- Workflow preferences
- Links to your project docs

### settings.json (Shared)
Permissions and hooks shared across the team:
- Committed to git
- Contains base permissions
- Configures hooks

### settings.local.json (Personal)
Your personal overrides:
- NOT committed to git (in .gitignore)
- Local-only permissions
- Machine-specific settings

**Copy from example:**
```bash
cp settings.local.json.example settings.local.json
```

---

## 🔧 Customization Guide

### Adding Project-Specific Skills

1. **Create skill directory:**
```bash
mkdir -p .claude/skills/my-domain/resources
```

2. **Create SKILL.md:**
```markdown
# My Domain Skill

## What This Skill Does
Domain-specific guidance for my project area

## When to Use
- Working on X feature
- Implementing Y pattern
- Debugging Z issues

## Best Practices
[Your team's practices]
```

3. **Add to skill-rules.json:**
```json
{
  "my-domain": {
    "type": "domain",
    "enforcement": "suggest",
    "priority": "high",
    "description": "My domain knowledge",
    "promptTriggers": {
      "keywords": ["my", "domain", "keywords"]
    },
    "fileTriggers": {
      "pathPatterns": ["src/my-domain/**/*.ts"]
    }
  }
}
```

### Adjusting File Patterns

Edit `skills/skill-rules.json` to match your project structure:

```json
{
  "backend-dev-guidelines": {
    "fileTriggers": {
      "pathPatterns": [
        "api/**/*.ts",           // ← Change to your paths
        "services/**/*.ts",
        "your-backend/**/*.ts"
      ]
    }
  }
}
```

### Creating Custom Agents

1. Create file: `agents/my-agent.md`
2. Add agent prompt and instructions
3. Reference from CLAUDE.md if needed

---

## 📖 Documentation

All documentation is in `.claude/docs/`:

**Getting Started:**
- `QUICKSTART.md` - Fast setup guide
- `SETUP.md` - Detailed installation

**Features:**
- `WHATS-NEW.md` - Feature overview
- `SHOWCASE-INTEGRATION.md` - Auto-activation details

**Guides:**
- `MIGRATION-GUIDE.md` - For existing projects
- `CLAUDE-SETTINGS.md` - Settings troubleshooting
- `CONTRIBUTING.md` - How to contribute

**In-Directory READMEs:**
- `agents/README.md` - Agent system docs
- `skills/README.md` - Skills system docs
- `hooks/README.md` - Hooks system docs
- `checklists/README.md` - Checklist docs

---

## 🔍 What's What

### Agents vs Skills

**Agents** (Manual invocation for complex tasks):
- Orchestrate multi-step workflows
- Coordinate between specialists
- Handle complex, planned tasks
- Example: "Use /orchestrator to refactor this module"

**Skills** (Auto-activation for ongoing guidance):
- Appear when needed
- Provide contextual best practices
- Enforce quality gates
- Example: Editing .tsx → frontend-dev-guidelines activates

### Hooks (Automation Layer)

**What they do:**
- Run at specific points in workflow
- Analyze context and suggest skills
- Track file changes
- Enable automation

**Types:**
- `UserPromptSubmit` - When you type a prompt
- `PostToolUse` - After tool execution
- `Stop` - When stopping Claude

---

## 🛠️ Troubleshooting

### Skills Not Activating

```bash
# 1. Check dependencies installed
cd .claude/hooks
npm install

# 2. Verify hooks are executable
chmod +x *.sh

# 3. Check settings.json has hooks configured
cat settings.json | grep -A 5 "hooks"
```

### Permissions Issues

See `docs/CLAUDE-SETTINGS.md` for comprehensive troubleshooting.

**Quick fix:**
```bash
# Ensure both settings files exist
ls -la settings.json settings.local.json

# Copy example if needed
cp settings.local.json.example settings.local.json
```

### Hooks Not Running

1. Verify Node.js installed: `node --version`
2. Install dependencies: `cd hooks && npm install`
3. Check for errors in Claude Code console

---

## 📦 Portability Checklist

When copying `.claude/` to a new project:

- [ ] Copy entire `.claude/` directory
- [ ] Run `cd .claude/hooks && npm install`
- [ ] Edit `CLAUDE.md` with new project details
- [ ] Update `skills/skill-rules.json` file patterns
- [ ] Copy `settings.local.json.example` to `settings.local.json`
- [ ] Customize `project/` directory with your docs
- [ ] Remove showcase reference: `claude-code-infrastructure-showcase-main/`
- [ ] Test with a simple prompt

---

## 🔄 Updating the Template

This template may receive updates. To update:

```bash
# If using git subtree (recommended)
git subtree pull --prefix .claude \
  https://github.com/yourorg/template.git main --squash

# Or manually
# 1. Backup your customizations
# 2. Copy new .claude/ directory
# 3. Restore your customizations
```

**Always preserve:**
- `CLAUDE.md` (your project-specific)
- `project/` directory (your docs)
- `settings.local.json` (your settings)
- Custom skills in `skills/`

---

## 🌟 Key Files to Customize

**Must customize:**
1. `CLAUDE.md` - Your project's main instructions
2. `skills/skill-rules.json` - File patterns for your structure

**Should customize:**
3. `project/` - Your business logic and domain knowledge
4. `settings.local.json` - Your local permissions

**Optional to customize:**
5. Create custom skills in `skills/`
6. Add custom agents in `agents/`
7. Modify checklists in `checklists/`

---

## 💡 Pro Tips

1. **Keep business logic in `project/`** - Separates universal patterns from your specifics
2. **Version control `settings.json`** - Share permissions with team
3. **Gitignore `settings.local.json`** - Keep personal settings private
4. **Document in `project/`** - Your domain knowledge grows over time
5. **Skills over agents** - Use auto-activating skills for repetitive guidance

---

## 📞 Support

- Issues: Check `docs/` for troubleshooting guides
- Questions: See `docs/CONTRIBUTING.md`
- Updates: Check `CHANGELOG.md` in project root

---

**Everything you need is in this directory. Copy `.claude/` to any project and you're ready to go!**

# Portability Guide: Bringing This Template to Other Projects

## ✅ Complete Portability with Clear Separation

**This template separates infrastructure from business logic:**

- **`.claude/`** = Infrastructure (agents, skills, hooks, checklists) - **Replaceable, portable, updatable**
- **`docs/project/`** = Your business logic, domain knowledge, project-specific docs - **Never touched by template updates**

This separation means you can safely replace the entire `.claude/` directory when the template is updated, without losing any of your project-specific documentation or business logic.

### Why This Matters

When you use this template across multiple projects:
1. Copy `.claude/` to each project for infrastructure
2. Create `docs/project/` for that project's unique business logic
3. Update `.claude/` anytime without fear of losing business docs
4. Your domain knowledge stays safe in `docs/project/`

---

## 🚀 Quick Copy (5 Steps)

```bash
# 1. Copy the entire .claude/ directory (infrastructure)
cp -r /path/to/template/.claude /path/to/your-project/

# 2. Create docs/project/ structure (your business logic home)
cd /path/to/your-project
mkdir -p docs/project/{architecture,business,features,standards,security,testing,operations,domain}

# 3. Install hook dependencies (enables auto-activation)
cd .claude/hooks
npm install

# 4. Install git hooks (blocks commits to main/master)
cd ../..
./.claude/hooks/install-git-hooks.sh

# 5. Done! Start adding your business logic to docs/project/
```

That's it! Skills will auto-activate, agents are ready, checklists available, main branch is protected, and you have a dedicated place for your business logic that won't be overwritten during template updates.

---

## 📦 What's Included

### In `.claude/` (Infrastructure - Portable & Replaceable)

**Configuration**
- `settings.json` - Shared permissions & hooks (commit to git)
- `settings.local.json.example` - Template for local overrides
- `CLAUDE.md` - Main agent instructions (customize per project)

**Documentation (Template Docs)**
- `README.md` - This directory's guide
- `QUICK-START.md` - Fast setup
- `PORTABILITY.md` - This file
- `docs/` - All template guides
  - QUICKSTART.md
  - SETUP.md
  - MIGRATION-GUIDE.md
  - SHOWCASE-INTEGRATION.md
  - WHATS-NEW.md
  - CLAUDE-SETTINGS.md
  - GIT-WORKFLOW.md
  - GITHUB-BRANCH-PROTECTION.md
  - CONTRIBUTING.md

**Core Systems (Infrastructure)**
- `agents/` - 7 specialized agents (orchestrator, architect, qa, backend, frontend, devops, security)
- `skills/` - Auto-activating skills with sophisticated trigger rules
- `hooks/` - Automation system (TypeScript hooks, git hooks)
- `checklists/` - Quality gates and verification checklists
- `templates/` - Document templates (ADR, feature specs, etc.)

### In `docs/project/` (Your Business Logic - Never Overwritten)

**You create this structure in your project:**

```
docs/project/
├── architecture/     # Your system design, tech stack, ADRs
├── business/         # Your requirements, user stories, roadmaps
├── domain/          # Your domain models, terminology, business rules
├── features/        # Your feature specifications
├── security/        # Your security policies, compliance docs
├── standards/       # Your coding standards, conventions
├── testing/         # Your test strategies, QA processes
└── operations/      # Your deployment, monitoring, runbooks
```

**This separation means:**
- ✅ Template updates don't touch your business logic
- ✅ You can replace `.claude/` completely without losing anything
- ✅ Your domain knowledge is separate from infrastructure
- ✅ Clean portability across projects

---

## 🎯 Customization (3 Files)

After copying, customize these 3 files for your project:

### 1. CLAUDE.md
**What:** Main instructions for Claude
**Customize:**
- Project name and description
- Tech stack details
- Team structure
- Workflow preferences
- Links to project-specific docs

### 2. skills/skill-rules.json
**What:** Skill activation configuration
**Customize:**
- File path patterns (match your structure)
- Keywords (your domain terms)
- Add project-specific skills

**Example:**
```json
{
  "backend-dev-guidelines": {
    "fileTriggers": {
      "pathPatterns": [
        "YOUR-PATH/**/*.ts"  // ← Change to your structure
      ]
    }
  }
}
```

### 3. settings.local.json
**What:** Your personal permissions (gitignored)
**Customize:**
- Copy from settings.local.json.example
- Add any local-only permissions
- Adjust for your machine

```bash
cp settings.local.json.example settings.local.json
```

---

## 📋 Detailed Migration Checklist

### Pre-Migration

- [ ] Backup existing `.claude/` if present
- [ ] Understand your current project structure
- [ ] Note any existing Claude configurations

### Migration Steps

**1. Copy Template**
```bash
cp -r /template/.claude /your-project/
cd /your-project/.claude
```

**2. Install Dependencies**
```bash
cd hooks
npm install
chmod +x *.sh
```

**3. Customize Core Files**
```bash
# Main instructions
vim CLAUDE.md

# Skill activation patterns
vim skills/skill-rules.json

# Local settings
cp settings.local.json.example settings.local.json
vim settings.local.json
```

**4. Add Project Documentation**
```bash
# Your business logic
vim project/business/requirements.md

# Your architecture
vim project/architecture/tech-stack.md

# Your domain knowledge
vim project/domain/terminology.md
```

**5. Update .gitignore**
Add to your project's `.gitignore`:
```gitignore
# Claude Code
.claude/logs/
.claude/settings.local.json
.claude/hooks/node_modules/
.claude/hooks/package-lock.json
```

**6. Test**
```bash
# Test that skills activate
# Open Claude Code and type: "I want to implement a feature"
# Should see skill activation message
```

### Post-Migration

- [ ] Verify skills auto-activate
- [ ] Test agent invocation
- [ ] Check hooks are running
- [ ] Update team documentation
- [ ] Share with team

---

## 🔄 Keeping It Updated

The template may receive updates. Here's how to stay current:

### Option 1: Git Subtree (Recommended)

**Initial setup:**
```bash
# Add template as remote
git remote add claude-template https://github.com/yourorg/template.git

# Add as subtree
git subtree add --prefix .claude claude-template main --squash
```

**Update later:**
```bash
# Pull latest changes
git subtree pull --prefix .claude claude-template main --squash

# Resolve any conflicts (usually none, see below)
```

**What to preserve:**
- `.claude/CLAUDE.md` - Your project instructions
- `docs/project/` - Your business logic
- `.claude/settings.local.json` - Your local settings
- Custom skills in `.claude/skills/`

### Option 2: Complete Replacement (Easiest!)

**Because business logic is in `docs/project/`, you can simply replace `.claude/` entirely:**

1. **Backup only `.claude/CLAUDE.md` (your customized instructions):**
```bash
cp .claude/CLAUDE.md ~/backup/CLAUDE.md
```

2. **Replace entire .claude/ directory:**
```bash
rm -rf .claude
cp -r /new-template/.claude .
```

3. **Restore your customized CLAUDE.md:**
```bash
cp ~/backup/CLAUDE.md .claude/CLAUDE.md
```

4. **Done!** Your business logic in `docs/project/` was never touched. No merge conflicts, no manual restoration.

**This is the power of separation:**
- Infrastructure (`.claude/`) is replaceable
- Business logic (`docs/project/`) is preserved
- Updates are fast and conflict-free

---

## 🌐 Multi-Project Usage

### Scenario: Multiple Projects Using This Template

**Project structure:**
```
~/projects/
  ├── template/              # This repository
  │   └── .claude/
  ├── project-a/
  │   └── .claude/           # Copy from template
  ├── project-b/
  │   └── .claude/           # Copy from template
  └── project-c/
      └── .claude/           # Copy from template
```

**Workflow:**
1. Keep template repo updated with improvements
2. Each project copies `.claude/` from template
3. Each project customizes CLAUDE.md and skill-rules.json
4. Share improvements back to template

**Benefits:**
- Consistent tooling across projects
- Easy to update all projects
- Team familiarity (same structure everywhere)
- Cross-pollinate best practices

---

## 💡 Pro Tips

### Tip 1: Version Your .claude/ Directory

```bash
# Track .claude/ in git (except settings.local.json)
git add .claude/
git commit -m "feat: add Claude SDLC template"
```

**Benefits:**
- Team shares same configuration
- Version control for agents/skills
- Track evolution of project knowledge

### Tip 2: Document Your Customizations

Keep a log in `project/customizations.md`:
```markdown
# Template Customizations

## What We Changed
- Added payment-processing skill (2024-11-10)
- Customized backend paths for our monorepo
- Added Stripe-specific security guidelines

## Why
- We process payments heavily
- Our backend is in api/services/
- PCI compliance requirements
```

### Tip 3: Create Project-Specific Skills

Don't modify template skills. Create new ones:
```bash
# Don't modify
.claude/skills/backend-dev-guidelines/

# Instead create
.claude/skills/our-payment-backend/
.claude/skills/our-auth-system/
.claude/skills/our-deployment-process/
```

### Tip 4: Use settings.json for Team, settings.local.json for You

**settings.json** (committed):
```json
{
  "permissions": {
    "allow": ["Read(*)", "Bash(npm:*)"]
  }
}
```

**settings.local.json** (gitignored):
```json
{
  "permissions": {
    "allow": ["Write(*)", "Edit(*)", "Bash(*)"]
  }
}
```

This way:
- New team members get safe defaults
- Experienced devs can enable more permissions locally
- No accidental commits of permissive settings

### Tip 5: Link to Project Docs

In `CLAUDE.md`:
```markdown
## Important Project Documentation

External docs (not in .claude/):
- API Docs: /docs/api/
- Database Schema: /docs/schema/
- Deployment Guide: /docs/deployment/

These are referenced but not duplicated in .claude/
```

---

## 🔧 Troubleshooting

### Skills Not Activating

**Check:**
```bash
# 1. Dependencies installed?
ls .claude/hooks/node_modules/

# 2. Hooks executable?
ls -la .claude/hooks/*.sh

# 3. Settings configured?
cat .claude/settings.json | grep -A 3 "hooks"
```

**Fix:**
```bash
cd .claude/hooks
npm install
chmod +x *.sh
```

### File Patterns Not Matching

**Your structure:**
```
src/
  backend/
    api/
    services/
```

**Update skill-rules.json:**
```json
{
  "backend-dev-guidelines": {
    "fileTriggers": {
      "pathPatterns": [
        "src/backend/**/*.ts",  // ← Your actual path
        "src/api/**/*.ts"
      ]
    }
  }
}
```

### Hooks Not Running

1. **Check Node.js:** `node --version` (need >= 18)
2. **Reinstall:** `cd .claude/hooks && npm install`
3. **Check logs:** Look in Claude Code console for errors
4. **Verify config:** `.claude/settings.json` has hooks section

### Permissions Issues

See `.claude/docs/CLAUDE-SETTINGS.md` for comprehensive guide.

**Quick check:**
```bash
# Both should exist
ls .claude/settings.json
ls .claude/settings.local.json
```

---

## 📊 What to Commit vs Gitignore

### ✅ Commit to Git

```
.claude/
├── README.md                   ✓ Commit
├── CLAUDE.md                   ✓ Commit (project-specific)
├── QUICK-START.md             ✓ Commit
├── settings.json               ✓ Commit (shared config)
├── settings.local.json.example ✓ Commit (template)
├── agents/                     ✓ Commit
├── skills/                     ✓ Commit
├── hooks/*.sh                  ✓ Commit (scripts)
├── hooks/*.ts                  ✓ Commit (source)
├── hooks/package.json          ✓ Commit
├── hooks/tsconfig.json         ✓ Commit
├── checklists/                 ✓ Commit
├── templates/                  ✓ Commit
├── project/                    ✓ Commit (your docs)
└── docs/                       ✓ Commit
```

### ❌ Gitignore

```
.claude/
├── settings.local.json         ✗ Gitignore (personal)
├── logs/                       ✗ Gitignore (temporary)
└── hooks/
    ├── node_modules/           ✗ Gitignore (dependencies)
    └── package-lock.json       ✗ Gitignore (lockfile)
```

**Your .gitignore should have:**
```gitignore
.claude/logs/
.claude/settings.local.json
.claude/hooks/node_modules/
.claude/hooks/package-lock.json
```

---

## 🎓 Training New Team Members

### Day 1: Copy & Setup

```bash
# 1. Clone project
git clone your-project.git
cd your-project

# 2. Install Claude Code dependencies
cd .claude/hooks
npm install

# 3. Set up local config
cp ../settings.local.json.example ../settings.local.json

# 4. Read the quick start
cat ../.claude/QUICK-START.md
```

### Day 2: Learn the System

1. Read `.claude/README.md`
2. Browse `.claude/docs/WHATS-NEW.md`
3. Try prompts and watch skills activate
4. Explore agents in `.claude/agents/`

### Week 1: Contribute

1. Add domain knowledge to `docs/project/`
2. Suggest new skills
3. Improve checklists

---

## 🚢 Production Deployment Note

**.claude/ is for development only.** Don't deploy to production.

**In your deployment:**
```bash
# .dockerignore or similar
.claude/
```

**Why:**
- Development tooling, not runtime code
- Contains team workflows and documentation
- May have large node_modules

---

## ✨ Benefits of This Approach

### Self-Contained
- ✅ One directory has everything
- ✅ No scattered configuration
- ✅ Clear ownership

### Portable
- ✅ Copy to any project
- ✅ Works immediately
- ✅ No hidden dependencies

### Maintainable
- ✅ Easy to update
- ✅ Clear structure
- ✅ Well documented

### Shareable
- ✅ Team uses same setup
- ✅ Onboarding is fast
- ✅ Best practices spread

---

**Summary: Everything you need is in `.claude/`. Copy it, customize 3 files, done!**

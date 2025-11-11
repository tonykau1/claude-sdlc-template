# Setup Guide

This guide walks you through setting up the Claude SDLC Template for your projects.

## Prerequisites

- Git installed
- Basic understanding of git subtrees (or willingness to learn)
- A project to apply this template to (or ready to create one)

## Installation Methods

### Method 1: New Project (Recommended for Greenfield)

Use the included initialization script:

```bash
# Clone this template repository
git clone https://github.com/yourorg/claude-sdlc-template.git
cd claude-sdlc-template

# Run the initialization script
./scripts/init-project.sh my-new-project

# Navigate to your new project
cd my-new-project
```

This creates a new project with:
- Template linked via git subtree
- Project-specific directory structure
- Customizable main agent file (claude.md)
- Version tracking

### Method 2: Existing Project

Add the template to an existing project:

```bash
# Navigate to your existing project
cd my-existing-project

# Add template as git subtree
git subtree add --prefix .claude/_template \
  https://github.com/yourorg/claude-sdlc-template.git main --squash

# Create project-specific directories
mkdir -p docs/project/{architecture/decisions,business,features,standards,security,testing,operations}

# Copy template files you want to customize
cp .claude/_template/templates/adr-template.md docs/project/architecture/decisions/template.md

# Record template version
echo "0.1.0" > .claude/TEMPLATE_VERSION.txt

# Commit
git add .
git commit -m "Add Claude SDLC template"
```

### Method 3: Git Submodule (Alternative)

If you prefer submodules:

```bash
git submodule add https://github.com/yourorg/claude-sdlc-template.git .claude/_template
git submodule init
git submodule update
```

## Post-Installation Setup

### 1. Create Your Main Agent File

The main agent file is your project's entry point for Claude:

```bash
# Copy the template
cp .claude/_template/templates/claude.md.template .claude/claude.md

# Edit with your project details
vim .claude/claude.md
```

Fill in:
- Project name and description
- Tech stack
- Key stakeholders
- Development workflow specifics
- Links to your project-specific docs

### 2. Document Your Project

Create essential project documentation:

```bash
# Business context
vim docs/project/business/requirements.md
vim docs/project/business/user-personas.md

# Architecture decisions
vim docs/project/architecture/tech-stack.md

# Security considerations
vim docs/project/security/threat-model.md

# Code standards
vim docs/project/standards/code-style.md
vim docs/project/standards/naming-conventions.md
```

### 3. Customize Checklists (Optional)

The default checklists are generic. You can add project-specific items:

```bash
# Create project-specific checklist overrides
cp .claude/_template/checklists/pre-commit.md docs/project/checklists/pre-commit-additions.md

# Add your custom requirements
vim docs/project/checklists/pre-commit-additions.md
```

### 4. Initialize Git Hooks (Optional)

Set up pre-commit hooks to enforce standards:

```bash
# Create .git/hooks/pre-commit
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash
# Run linter
npm run lint || exit 1

# Run tests
npm test || exit 1

# Check for secrets
git diff --cached | grep -i "api_key\|password\|secret" && echo "⚠️  Possible secret detected!" && exit 1

exit 0
EOF

chmod +x .git/hooks/pre-commit
```

## Updating the Template

As the template evolves, pull updates:

```bash
# Check current version
cat .claude/TEMPLATE_VERSION.txt

# Pull latest updates
./scripts/sync-from-template.sh

# Review changes
git diff .claude/_template/

# Commit when satisfied
git commit -am "Update template to v0.2.0"
```

## Directory Structure

After setup, your project should look like:

```
my-project/
├── .claude/
│   ├── _template/              # Universal template (linked via subtree)
│   │   ├── agents/             # Agent configurations
│   │   ├── checklists/         # Development checklists
│   │   └── templates/          # Document templates
│   ├── project/                # YOUR project-specific docs
│   │   ├── architecture/       # ADRs, diagrams, tech stack
│   │   ├── business/           # Requirements, personas, workflows
│   │   ├── features/           # Feature specifications
│   │   ├── standards/          # Code style, naming conventions
│   │   ├── security/           # Threat models, compliance
│   │   ├── testing/            # Test strategies, coverage targets
│   │   └── operations/         # Deployment, monitoring, incidents
│   ├── claude.md               # Main agent file (customized)
│   └── TEMPLATE_VERSION.txt    # Tracks template version
├── src/                        # Your application code
└── ...
```

## Working with Claude Code

Once setup is complete, when you start Claude Code:

```bash
claude code

# Claude will read .claude/claude.md as its primary instructions
# It will reference agent files, checklists, and project docs as needed
```

### Best Practices

1. **Start each session with context**: "Review .claude/claude.md and let's work on feature X"
2. **Reference checklists explicitly**: "Before we commit, let's run through the pre-commit checklist"
3. **Invoke specialized agents**: "Can you do a security review using the security agent guidelines?"
4. **Document as you go**: Update relevant docs after significant decisions
5. **Version control everything**: All .claude/ content should be committed

## Troubleshooting

### Template Not Updating

```bash
# Force pull from template
git subtree pull --prefix .claude/_template \
  https://github.com/yourorg/claude-sdlc-template.git main --squash -X theirs
```

### Merge Conflicts

Template updates rarely conflict with project files since they're in separate directories. If conflicts occur:

1. They're likely in .claude/_template/ (universal files)
2. Accept template changes unless you intentionally modified template files
3. Your project-specific files (docs/project/) are never touched by updates

### Need Help?

- Check issues: https://github.com/yourorg/claude-sdlc-template/issues
- Read the README: [README.md](../README.md)
- Review the changelog: [CHANGELOG.md](../CHANGELOG.md)

## Next Steps

1. ✅ Template installed
2. ✅ Project structure created
3. ✅ Main agent file customized
4. → Start documenting your project requirements
5. → Create your first ADR
6. → Begin development with Claude Code!

---

Happy building! 🚀

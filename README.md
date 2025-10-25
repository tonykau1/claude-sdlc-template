# Claude SDLC Template

A comprehensive, best-practice template for software development with AI agents (like Claude Code). This template embeds SDLC principles, architecture patterns, security practices, and development workflows into your project from day one.

## What This Provides

- **Specialized AI Agents**: Pre-configured agent roles for architecture, security, frontend, backend, DevOps, and QA
- **Development Checklists**: Step-by-step validation for features, commits, merges, and deployments
- **Documentation Templates**: ADRs, feature specs, security reviews, and more
- **Best Practice Workflows**: TDD, security reviews, performance optimization, accessibility
- **Scalable Structure**: Clear separation between universal patterns and project-specific details

## Quick Start

### For New Projects

```bash
# Clone this template
git clone https://github.com/yourorg/claude-sdlc-template.git
cd claude-sdlc-template

# Initialize a new project
./scripts/init-project.sh my-new-project

# Navigate to your new project
cd my-new-project
```

### For Existing Projects

```bash
# In your existing project directory
git subtree add --prefix .claude/_template \
  https://github.com/yourorg/claude-sdlc-template.git main --squash

# Create project-specific structure
mkdir -p .claude/project/{architecture,business,features,standards,security,testing,operations}

# Copy and customize the main agent file
cp .claude/_template/templates/claude.md.template .claude/claude.md
```

## Template Structure

```
.claude/
├── agents/              # Specialized AI agent configurations
├── checklists/          # Validation checklists for different stages
└── templates/           # Reusable document templates
```

## Keeping Templates Updated

```bash
# Pull latest template updates
./scripts/sync-from-template.sh

# Contribute improvements back
./scripts/contribute-back.sh path/to/improved/file
```

## Philosophy

This template assumes you want to build production-quality software, not throwaway prototypes. It emphasizes:

- **Interactive Development**: Ask questions, understand requirements before coding
- **Security by Default**: Every feature gets a security review
- **Test-Driven**: Write tests as you develop, not after
- **Documented Decisions**: ADRs capture the "why" behind choices
- **Continuous Learning**: Document patterns and anti-patterns as you discover them

## Documentation

- [Setup Guide](docs/SETUP.md) - Detailed setup instructions
- [CHANGELOG](CHANGELOG.md) - Version history and updates

## Contributing

Improvements welcome! See [Contributing Guide](docs/CONTRIBUTING.md)

## License

[Your License Here]

## Version

Current version: $(cat VERSION)

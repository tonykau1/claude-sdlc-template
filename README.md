# Claude SDLC Template

A comprehensive, best-practice template for software development with AI agents (like Claude Code). This template embeds SDLC principles, architecture patterns, security practices, and development workflows into your project from day one.

## What This Provides

### Core Framework
- **7 Specialized AI Agents**: Architect, Security, Backend, Frontend, DevOps, QA, and Orchestrator
- **Development Checklists**: Step-by-step validation for features, commits, merges, and deployments
- **Documentation Templates**: ADRs, feature specs, security reviews, completion reports, and more
- **Best Practice Workflows**: TDD, security reviews, performance optimization, accessibility
- **Scalable Structure**: Clear separation between universal patterns and project-specific details

### Quality & Maintainability
- **File Size Discipline**: Comprehensive standards for maintainable code (200 LOC target, 250 LOC max)
- **Evidence-Based Completion**: Mandatory verification with proof before marking tasks complete
- **Reading Protocols**: Prevent LLM assumptions by requiring thorough code analysis
- **Completion Report Templates**: Standardized format for documenting task completion with evidence

### Autonomous Development
- **YOLO Mode**: Autonomous workflow configuration for faster development with safety guardrails
- **Orchestrator Agent**: Coordinate multiple specialized agents for complex multi-domain tasks
- **Granular Permissions**: Fine-grained control over autonomous operations

### Additional Resources
- **Database Patterns**: Schema documentation, migrations, and syntax guides for common databases
- **Agent Template**: Create custom domain-specific agents for your project needs

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
│   ├── orchestrator.md  # Multi-agent coordinator
│   ├── architect.md     # System design & architecture
│   ├── security.md      # Security reviews & threat modeling
│   ├── backend.md       # API design & business logic
│   ├── frontend.md      # UI/UX & accessibility
│   ├── devops.md        # Infrastructure & deployment
│   └── qa.md            # Testing & quality gates
├── checklists/          # Validation checklists for different stages
│   ├── pre-feature-start.md
│   ├── pre-commit.md
│   ├── pre-merge.md
│   ├── security-review.md
│   └── go-live.md
└── templates/           # Reusable document templates
    ├── claude.md.template
    ├── adr-template.md
    ├── completion-report-template.md
    ├── agent-template.md
    └── standards/
        └── file-size-discipline.md
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

- **Evidence-Based Completion**: Tasks are only done when proven to work with evidence
- **Maintainability Through Discipline**: File size limits and modular design keep code manageable
- **Interactive Development**: Ask questions, understand requirements before coding
- **Security by Default**: Every feature gets a security review
- **Test-Driven**: Write tests as you develop, not after
- **Documented Decisions**: ADRs capture the "why" behind choices
- **Continuous Learning**: Document patterns and anti-patterns as you discover them
- **LLM Awareness**: Reading protocols prevent assumptions and hallucinations

## Documentation

- [Setup Guide](docs/SETUP.md) - Detailed setup instructions
- [CHANGELOG](CHANGELOG.md) - Version history and updates

## Contributing

Improvements welcome! See [Contributing Guide](docs/CONTRIBUTING.md)

## License

MIT License - See [LICENSE](LICENSE) file for details.

## Version

Current version: 0.1.0

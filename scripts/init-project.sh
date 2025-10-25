#!/bin/bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get project name from argument
PROJECT_NAME=$1

if [ -z "$PROJECT_NAME" ]; then
    echo -e "${RED}❌ Error: Project name required${NC}"
    echo "Usage: ./init-project.sh my-project-name"
    exit 1
fi

# Get template version
TEMPLATE_VERSION=$(cat VERSION)
TEMPLATE_REPO="https://github.com/yourorg/claude-sdlc-template.git"

echo -e "${GREEN}🚀 Initializing new project: ${PROJECT_NAME}${NC}"
echo -e "${YELLOW}📦 Template version: ${TEMPLATE_VERSION}${NC}"
echo ""

# Check if directory already exists
if [ -d "$PROJECT_NAME" ]; then
    echo -e "${RED}❌ Error: Directory ${PROJECT_NAME} already exists${NC}"
    exit 1
fi

# Create project directory
echo "Creating project directory..."
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

# Initialize git
echo "Initializing git repository..."
git init

# Add template as subtree
echo "Adding Claude SDLC template..."
git subtree add --prefix .claude/_template "$TEMPLATE_REPO" main --squash

# Create project-specific directory structure
echo "Creating project-specific directories..."
mkdir -p .claude/project/architecture/{decisions,diagrams}
mkdir -p .claude/project/business/workflows
mkdir -p .claude/project/features
mkdir -p .claude/project/standards
mkdir -p .claude/project/security
mkdir -p .claude/project/testing
mkdir -p .claude/project/operations

# Copy customizable templates
echo "Copying customizable templates..."

# Create main claude.md from template
cat > .claude/claude.md << 'CLAUDE_MD'
# Project: [YOUR PROJECT NAME]

## Quick Links
- [Architecture Overview](project/architecture/tech-stack.md)
- [Business Requirements](project/business/requirements.md)
- [Code Standards](project/standards/code-style.md)
- [Security Checklist](_template/checklists/security-review.md)
- [Current Features](project/features/backlog.md)

## Project Context

**What we're building:** [Brief description]

**For whom:** [Target users/customers]

**Why it exists:** [Business problem we're solving]

**Success looks like:** [Key metrics and goals]

## Tech Stack

- **Frontend:** [Framework/library]
- **Backend:** [Language/framework]
- **Database:** [Database type]
- **Infrastructure:** [Cloud provider/hosting]
- **CI/CD:** [Pipeline tools]

## Development Workflow

### Before Starting Any Feature
1. Review [pre-feature checklist](_template/checklists/pre-feature-start.md)
2. Document requirements in `project/features/[feature-name]/requirements.md`
3. Create Architecture Decision Record if needed
4. Create feature branch: `feature/[feature-name]`

### During Development
1. Follow [code standards](project/standards/code-style.md)
2. Write tests alongside code (TDD)
3. Keep business logic separate from display logic
4. Document as you go

### Before Committing
1. Run [pre-commit checklist](_template/checklists/pre-commit.md)
2. Run linter and tests
3. Review your own changes
4. Write clear commit message (Conventional Commits)

### Before Merging
1. Complete [PR checklist](_template/checklists/pre-merge.md)
2. Ensure CI passes
3. Get required reviews
4. Squash if needed

## Specialized Agents

When you need focused expertise, reference these agents:

- **Architecture decisions**: [architect agent](_template/agents/architect.md)
- **Security review**: [security agent](_template/agents/security.md)
- **Performance optimization**: [backend agent](_template/agents/backend.md)
- **UI/UX concerns**: [frontend agent](_template/agents/frontend.md)
- **Infrastructure & deployment**: [devops agent](_template/agents/devops.md)
- **Testing strategy**: [qa agent](_template/agents/qa.md)

## Core Development Principles

1. **Interactive Development**
   - Ask questions before making assumptions
   - Understand the "why" behind requirements
   - Discuss trade-offs and alternatives

2. **Security by Default**
   - Every feature gets a security review
   - Never commit secrets or credentials
   - Think like a pentester

3. **Test-Driven Development**
   - Write tests as you develop, not after
   - Test business logic independently
   - Aim for meaningful coverage, not just high percentages

4. **Documentation First**
   - Document decisions in ADRs
   - Keep runbooks updated
   - Explain complex logic in comments

5. **Clean Codebase**
   - Fix warnings, don't ignore them
   - Refactor as you go
   - Leave code better than you found it

## Project-Specific Guidelines

[Add any project-specific rules, patterns, or conventions here]

## Session Continuity

To maintain context across sessions:
- Update `project/features/backlog.md` with current status
- Document open questions in feature directories
- Reference this file at start of each session

---

**Template Version:** See TEMPLATE_VERSION.txt
**Last Updated:** [Date]
CLAUDE_MD

# Copy ADR template
cp .claude/_template/templates/adr-template.md .claude/project/architecture/decisions/template.md

# Create initial project documentation files
cat > .claude/project/business/requirements.md << 'EOF'
# Business Requirements

## Overview
[High-level description of what we're building and why]

## Target Users
- **Primary:** [Description]
- **Secondary:** [Description]

## Core Features
1. [Feature 1]
2. [Feature 2]
3. [Feature 3]

## Success Metrics
- [Metric 1]
- [Metric 2]
- [Metric 3]

## Constraints
- [Constraint 1]
- [Constraint 2]

## Out of Scope (for now)
- [Item 1]
- [Item 2]
EOF

cat > .claude/project/architecture/tech-stack.md << 'EOF'
# Technology Stack

## Frontend
- **Framework:** [e.g., React, Vue, Svelte]
- **Language:** [e.g., TypeScript]
- **Styling:** [e.g., Tailwind CSS]
- **State Management:** [e.g., Zustand, Redux]

## Backend
- **Language:** [e.g., Node.js, Python, Go]
- **Framework:** [e.g., Express, FastAPI, Gin]
- **API Style:** [e.g., REST, GraphQL, gRPC]

## Database
- **Primary:** [e.g., PostgreSQL, MongoDB]
- **Caching:** [e.g., Redis]
- **Search:** [e.g., Elasticsearch]

## Infrastructure
- **Cloud Provider:** [e.g., AWS, GCP, Azure]
- **Hosting:** [e.g., Vercel, Railway, EC2]
- **CI/CD:** [e.g., GitHub Actions, GitLab CI]

## Development Tools
- **Version Control:** Git
- **Package Manager:** [e.g., npm, pnpm, yarn]
- **Linter:** [e.g., ESLint]
- **Formatter:** [e.g., Prettier]
- **Testing:** [e.g., Jest, Vitest, Pytest]

## Rationale
[Why did we choose this stack? What were the trade-offs?]
EOF

cat > .claude/project/standards/code-style.md << 'EOF'
# Code Style Guide

## General Principles
- Clarity over cleverness
- Consistency over personal preference
- Comments explain "why", not "what"

## Naming Conventions
- **Variables:** camelCase
- **Constants:** UPPER_SNAKE_CASE
- **Functions:** camelCase, verb-based (e.g., getUserData)
- **Classes:** PascalCase
- **Files:** kebab-case

## Code Organization
[Document your folder structure and file organization principles]

## Linting
- **Tool:** [e.g., ESLint, Pylint]
- **Config:** [Link to config file or document rules here]
- **Pre-commit:** Linting runs automatically before every commit

## Formatting
- **Tool:** [e.g., Prettier, Black]
- **Line Length:** [e.g., 100 characters]
- **Indentation:** [e.g., 2 spaces]

## Best Practices
1. [Practice 1]
2. [Practice 2]
3. [Practice 3]
EOF

cat > .claude/project/features/backlog.md << 'EOF'
# Feature Backlog

## Current Sprint

### In Progress
- [ ] [Feature name] - [Assigned to] - [Status]

### Ready to Start
- [ ] [Feature name]

## Upcoming

### High Priority
- [ ] [Feature name]

### Medium Priority
- [ ] [Feature name]

### Low Priority / Future
- [ ] [Feature name]

## Completed
- [x] [Feature name] - Completed [date]
EOF

# Record template version
echo "$TEMPLATE_VERSION" > .claude/TEMPLATE_VERSION.txt

# Create .gitignore
cat > .gitignore << 'EOF'
# Dependencies
node_modules/
.pnp
.pnp.js

# Testing
coverage/

# Production
build/
dist/

# Environment variables
.env
.env.local
.env.*.local

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Logs
logs/
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
EOF

# Create README for the new project
cat > README.md << EOF
# $PROJECT_NAME

[Brief project description]

## Getting Started

[Setup instructions]

## Development

[Development workflow]

## Documentation

See [\`.claude/\`](.claude/) directory for:
- Architecture decisions
- Development guidelines  
- Feature specifications
- Testing strategies

## License

[Your license]
EOF

# Initial commit
git add .
git commit -m "Initial project setup with claude-sdlc-template v$TEMPLATE_VERSION

- Added Claude SDLC template via git subtree
- Created project-specific directory structure
- Set up initial documentation templates
- Ready for development"

echo ""
echo -e "${GREEN}✅ Project initialized successfully!${NC}"
echo ""
echo -e "${YELLOW}📋 Next steps:${NC}"
echo "  1. cd $PROJECT_NAME"
echo "  2. Edit .claude/claude.md with your project details"
echo "  3. Fill out .claude/project/business/requirements.md"
echo "  4. Define your tech stack in .claude/project/architecture/tech-stack.md"
echo "  5. Set up your code style in .claude/project/standards/code-style.md"
echo "  6. Start building! 🚀"
echo ""
echo -e "${YELLOW}💡 Tip:${NC} Start Claude Code with: ${GREEN}claude code${NC}"

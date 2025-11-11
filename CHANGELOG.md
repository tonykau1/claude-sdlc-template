# Changelog

All notable changes to the Claude SDLC Template will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- **Auto-Activation System**: Skills now activate automatically based on context
  - UserPromptSubmit hook analyzes prompts and suggests relevant skills
  - PostToolUse hook tracks file modifications for context awareness
  - skill-rules.json configuration for pattern matching
- **Skills Directory**: New `.claude/skills/` with auto-activating domain guidance
  - skill-developer: Meta-skill for creating new skills
  - sdlc-practices: SDLC best practices and quality gates
  - Progressive disclosure pattern (500-line rule)
- **Hooks Directory**: New `.claude/hooks/` for workflow automation
  - UserPromptSubmit-skill-activation.sh
  - PostToolUse-tracker.sh
  - Comprehensive hooks documentation
- **Claude Integration Guide**: AI-assisted setup and customization guide
- **Enhanced Documentation**:
  - Skills README with comprehensive examples
  - Hooks README with configuration guide
  - Updated main README with new features

### Changed
- settings.json now includes hooks configuration
- README updated to highlight auto-activation features
- Philosophy section expanded with progressive disclosure principle

### Technical Details
- Inspired by [claude-code-infrastructure-showcase](https://github.com/diet103/claude-code-infrastructure-showcase)
- Combines showcase's auto-activation with our SDLC framework
- Maintains backward compatibility with existing configurations
- Hook system requires `jq` for JSON parsing

## [0.2.0] - 2025-10-30

### Added

#### New Agents & Templates
- **Orchestrator Agent**: Multi-agent coordinator for complex tasks
  - Task analysis and agent selection matrix
  - Workflow decision trees by task type
  - Mandatory completion verification protocol
  - Success criteria establishment framework
- **Completion Report Template**: Standardized evidence-based completion format
  - Self-testing protocol checklist
  - Evidence requirements section
  - Quality gates verification
  - Integration testing checklist
- **File Size Discipline Standards**: Comprehensive code maintainability guidelines
  - LOC limits by file type (components, APIs, tests, etc.)
  - Refactoring triggers (150/180/200 LOC thresholds)
  - Extraction strategies and best practices
  - Anti-patterns to avoid
- **Agent Template**: Reusable template for creating custom agents
  - Standardized structure with YAML frontmatter
  - Reading & analysis protocols
  - Completion verification requirements
  - Best practices and anti-patterns sections

#### Agent Enhancements
- **Universal Agent Improvements** applied to all 6 agents:
  - YAML frontmatter metadata (name, description, tools)
  - Reading & Analysis Protocol section
  - Humility & Thoroughness principles
  - File Size Discipline guidelines
  - Completion Verification Requirements
  - Evidence-based completion report format
  - Self-testing protocols

#### Checklist Enhancements
- **Pre-Commit Checklist** updates:
  - File size limits verification (250 LOC max)
  - LOC count reporting requirements
  - Evidence of functionality testing
  - Links to new standards and templates
- **Pre-Feature-Start Checklist** updates:
  - Existing codebase review requirements
  - File size planning section
  - Reference to Orchestrator Agent for complex features
  - Links to file size discipline standards

#### YOLO Mode Enhancements
- **Granular Permission Examples** in yolo-mode-setup.md:
  - settings.local.json configuration examples
  - Permission patterns explained (wildcards, specific commands)
  - Common permission sets for web dev, data science, infrastructure
  - Safety denials and best practices
- **Plan-Then-Execute Workflow** (`plan-then-execute-workflow.md`):
  - Comprehensive guide for autonomous development workflow
  - Interactive planning → Approval → Autonomous execution → Delivery
  - No interruptions during execution phase
  - Full file read/write permissions for agents
  - Test execution without approval
  - Database read and dev/test write operations
  - Production-ready `settings.local.json.example`
  - Complete usage examples for features, bugs, and multi-agent tasks
  - Best practices for scope management and review
- **Migration Guide** (`docs/MIGRATION-GUIDE.md`):
  - Comprehensive guide for integrating template into existing projects
  - Safe preservation of business logic from existing agents
  - Side-by-side installation (template + existing config)
  - Business logic extraction patterns
  - Gradual adoption strategy
  - Common migration scenarios and troubleshooting
  - Before/after examples

### Previous Additions
- **YOLO Mode**: Autonomous workflow configuration with safety guardrails
  - Comprehensive setup guide at `.claude/templates/yolo-mode-setup.md`
  - Example hooks configuration in `.claude/templates/settings.json.example`
  - Auto-blocks destructive commands (rm -rf, DROP TABLE, git reset --hard, etc.)
  - Activity logging for audit trails
  - Configurable permission levels for different project types
- **Agent Autonomy Settings** section in claude.md.template
  - YOLO Mode (autonomous) enabled by default
  - Interactive Mode (ask first) as optional alternative
  - Clear list of auto-approved vs. requires-permission operations
- Database schema documentation template with PostgreSQL/MySQL/MongoDB examples
- Database migration examples (001-003) demonstrating best practices
- Environment variables section in claude.md.template with agent instructions
- Database schema reference section with syntax guides for common databases
- Scratch work directories (`/temp/` and `/scratch/`) added to .gitignore
- Migrations directory structure and comprehensive README
- Session continuity improvements for better agent context across sessions
- Database-specific syntax guides (parameterized queries, arrays, JSONB, etc.)
- Common query patterns and performance considerations documentation

### Changed
- **All Agent Files**: Now include standardized structure with frontmatter, reading protocols, and completion verification
- **Checklists**: Enhanced with file size discipline and evidence requirements
- **YOLO Mode Documentation**: Expanded with granular permission configuration examples
- Enhanced claude.md.template with "Database Schema Reference" section
- Updated "Environment Setup" section with explicit agent instructions
- Expanded "Important Files & Locations" to include database schema and scratch directories
- Improved .gitignore to include temp/, scratch/, .claude/logs/, and .claude/settings.local.json
- Updated README with YOLO Mode and Database Patterns features
- Modified "Interactive Development" principle to account for YOLO mode workflow

### Philosophy
This release emphasizes **evidence-based completion** and **maintainability through discipline**:
- Agents must provide proof of functionality, not just claims
- File size limits prevent bloated, unmaintainable code
- Reading protocols prevent LLM assumptions and hallucinations
- Orchestration enables complex multi-domain tasks with quality gates

## [0.1.0] - 2025-10-25

### Added
- Initial template structure with .claude directory
- Six specialized agent configurations:
  - Architect: Architecture decisions and patterns
  - Security: Security reviews and threat modeling
  - Frontend: UI/UX and accessibility
  - Backend: API and business logic
  - DevOps: Infrastructure and deployment
  - QA: Testing strategies and quality assurance
- Five development checklists:
  - Pre-feature start checklist
  - Pre-commit checklist
  - Pre-merge/PR checklist
  - Security review checklist
  - Go-live/production readiness checklist
- Template files:
  - Architecture Decision Record (ADR) template
- Setup scripts:
  - init-project.sh: Initialize new projects
  - sync-from-template.sh: Pull template updates
  - contribute-back.sh: Push improvements to template
- Documentation:
  - README with quick start guide
  - SETUP guide with detailed instructions
  - VERSION file for template versioning

### Philosophy
- Interactive, question-driven development
- Security and testing as default practices
- Clear separation between universal patterns and project-specific details
- Documentation-first approach with ADRs

---

## Version History

### Semantic Versioning Guide
- **Major (x.0.0)**: Breaking changes to structure, agent roles, or workflows
- **Minor (0.x.0)**: New agents, checklists, templates, or substantial additions
- **Patch (0.0.x)**: Bug fixes, typo corrections, clarifications, minor improvements

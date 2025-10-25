# Changelog

All notable changes to the Claude SDLC Template will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
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
- Enhanced claude.md.template with "Database Schema Reference" section
- Updated "Environment Setup" section with explicit agent instructions
- Expanded "Important Files & Locations" to include database schema and scratch directories
- Improved .gitignore to include temp/ and scratch/ directories

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

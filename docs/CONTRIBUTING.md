# Contributing to Claude SDLC Template

Thank you for your interest in improving the Claude SDLC Template! This document provides guidelines for contributing improvements back to the template.

## Philosophy

This template aims to encode SDLC best practices into reusable, AI-friendly documentation. Contributions should:

1. **Be universally applicable** - Not specific to one project or tech stack
2. **Improve AI agent effectiveness** - Help Claude Code and similar tools deliver better results
3. **Follow established patterns** - Maintain consistency with existing structure
4. **Be well-documented** - Include clear explanations and examples

## Types of Contributions

### 1. Agent Improvements
Enhance agent role definitions with:
- Better question frameworks
- Additional security patterns
- More comprehensive checklists
- Real-world examples

### 2. New Checklists
Create checklists for:
- New development phases
- Specific technology stacks
- Compliance requirements

### 3. Template Files
Add templates for:
- Common document types
- Project artifacts
- Communication formats

### 4. Script Enhancements
Improve automation:
- Better error handling
- Additional features
- Cross-platform compatibility

### 5. Documentation
- Clarify existing docs
- Add examples
- Fix typos or errors

## Contribution Workflow

### From Your Project

If you've made improvements while working on a project:

```bash
# 1. Navigate to your project
cd my-project

# 2. Make changes to template files in .claude/_template/
vim .claude/_template/agents/security.md

# 3. Test the changes in your project
# Verify they improve Claude's assistance

# 4. Use the contribute-back script
./scripts/contribute-back.sh .claude/_template/agents/security.md

# 5. The script creates a branch and opens PR dialog
# Create PR on GitHub
```

### Direct to Template Repo

For template-only improvements:

```bash
# 1. Fork the repository
gh repo fork yourorg/claude-sdlc-template

# 2. Create a feature branch
git checkout -b improvement/better-security-checklist

# 3. Make your changes
vim .claude/agents/security.md

# 4. Test in a sample project
cd ../test-project
./scripts/init-project.sh test-with-changes

# 5. Commit with clear message
git commit -m "feat(security): add API key rotation checklist"

# 6. Push and create PR
git push origin improvement/better-security-checklist
gh pr create
```

## Commit Message Format

Use [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Types
- **feat**: New feature or enhancement
- **fix**: Bug fix
- **docs**: Documentation changes
- **style**: Formatting changes
- **refactor**: Code restructuring
- **test**: Adding tests
- **chore**: Maintenance tasks

### Scopes
- **agents**: Agent role files
- **checklists**: Development checklists
- **templates**: Document templates
- **scripts**: Automation scripts
- **docs**: General documentation

### Examples
```
feat(agents): add performance optimization patterns to backend agent
fix(scripts): handle spaces in project names correctly
docs(readme): clarify installation steps
chore(templates): update ADR template with better examples
```

## PR Guidelines

### Before Submitting

- [ ] Changes are universally applicable (not project-specific)
- [ ] Documentation is clear and includes examples
- [ ] Existing structure and patterns followed
- [ ] CHANGELOG.md updated
- [ ] No proprietary/confidential information included
- [ ] Spell-checked and grammar-checked

### PR Description Should Include

1. **What:** Clear description of changes
2. **Why:** Reasoning behind the improvement
3. **How:** Implementation details if complex
4. **Testing:** How you verified the changes work
5. **Examples:** Before/after or usage examples

### PR Template

```markdown
## Description
Brief description of what this PR does.

## Motivation
Why is this change needed? What problem does it solve?

## Changes
- Change 1
- Change 2
- Change 3

## Testing
How did you verify this works?
- [ ] Tested in project X
- [ ] Verified with Claude Code
- [ ] Checked against existing patterns

## Examples
[Include examples if applicable]

## Checklist
- [ ] Updated CHANGELOG.md
- [ ] No project-specific details included
- [ ] Documentation is clear
- [ ] Examples provided
```

## Review Process

1. **Automated Checks** - Linting, formatting
2. **Maintainer Review** - Content and structure review
3. **Community Feedback** - Input from other users
4. **Testing** - Verification in real projects
5. **Merge** - After approval and any requested changes

## What Gets Accepted

✅ **GOOD:**
- Universal best practices
- Clear, concise documentation
- Well-explained patterns
- Real-world tested improvements

❌ **NOT ACCEPTED:**
- Company/project-specific details
- Untested changes
- Breaking changes without discussion
- Opinionated preferences without rationale

## Versioning

Contributions may trigger version bumps:

- **Patch (0.0.x)**: Bug fixes, typos, clarifications
- **Minor (0.x.0)**: New agents, checklists, or substantial additions
- **Major (x.0.0)**: Breaking changes to structure or workflows

## Getting Help

- **Questions:** Open a GitHub Discussion
- **Bugs:** Open a GitHub Issue
- **Ideas:** Open a GitHub Issue with "enhancement" label
- **Chat:** [Your preferred communication channel]

## Code of Conduct

### Our Standards

- **Be respectful** - Treat everyone with respect
- **Be constructive** - Provide helpful feedback
- **Be collaborative** - Work together to improve
- **Be inclusive** - Welcome diverse perspectives

### Unacceptable Behavior

- Harassment or discrimination
- Trolling or insulting comments
- Personal or political attacks
- Spam or off-topic content

## Recognition

Contributors will be:
- Listed in CHANGELOG.md for their contributions
- Credited in release notes
- Added to CONTRIBUTORS.md (if substantial contributions)

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.

## Questions?

Feel free to open an issue or discussion if you have questions about contributing!

---

Thank you for helping make this template better for everyone! 🙏

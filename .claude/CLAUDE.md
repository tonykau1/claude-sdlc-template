# Project Instructions for Claude

## Project-Specific Documentation Location (IMPORTANT)

**ALL project-specific business logic, architecture, and domain knowledge goes in `docs/project/`**, NOT in `.claude/`.

### Why This Separation?

The `.claude/` directory is **infrastructure**—it contains agents, skills, hooks, and workflow templates that can be updated from this template repository. The `docs/project/` directory contains **your unique business logic and domain knowledge** that must never be overwritten.

### Directory Structure

```
docs/project/
├── architecture/     # System design, tech stack, ADRs
├── business/         # Requirements, user stories, roadmaps
├── domain/          # Domain models, terminology, business rules
├── features/        # Feature specifications
├── security/        # Security policies, compliance
├── standards/       # Coding standards, best practices
├── testing/         # Test strategies, QA processes
└── operations/      # Deployment, monitoring, runbooks
```

### When Creating Documentation

**ALWAYS put project-specific docs in `docs/project/`:**

✅ Architecture decisions → `docs/project/architecture/`
✅ Business requirements → `docs/project/business/`
✅ Domain terminology → `docs/project/domain/`
✅ Feature specs → `docs/project/features/`
✅ Security policies → `docs/project/security/`
✅ Coding standards → `docs/project/standards/`
✅ Test strategies → `docs/project/testing/`
✅ Deployment procedures → `docs/project/operations/`

❌ NEVER put project-specific docs in `.claude/project/` (that location is deprecated)

### Template Portability

This separation allows you to:
1. Update `.claude/` by copying from template (agents, skills, checklists)
2. Keep all your business logic safe in `docs/project/`
3. No merge conflicts, no lost documentation

**When you see this template updated, you can safely replace the entire `.claude/` directory without losing any project-specific information.**

---

## Git Workflow (CRITICAL)

**NEVER commit directly to main or master branch!**

### Branch-Based Development (MANDATORY)

1. **Before ANY code changes:**
   ```bash
   # Check current branch
   git branch --show-current

   # If on main/master, create a feature branch
   git checkout -b feature/descriptive-name
   ```

2. **Commit at milestones:**
   - After completing a logical unit of work
   - When a todo item is finished
   - Before switching tasks
   - Use descriptive commit messages

3. **Example workflow:**
   ```bash
   # Start feature
   git checkout -b feature/add-authentication

   # Make changes, complete todo item
   git add .
   git commit -m "feat: implement JWT authentication"

   # Continue work, complete another todo
   git add .
   git commit -m "feat: add login endpoint tests"

   # Push to remote
   git push -u origin feature/add-authentication
   ```

4. **When ready to merge:**
   - Push branch to remote
   - Create pull request
   - Wait for review/approval
   - **Use "Squash and merge"** on GitHub (keeps history clean)
   - Never merge via direct push to main

5. **Merge strategy:**
   - ✅ **Squash and merge** (preferred) - Combines all commits into one clean commit
   - ❌ Create merge commit - Creates messy merge commits
   - ❌ Rebase and merge - Can cause issues with shared branches

   **Why squash?**
   - Clean, linear history on main
   - Each PR = one logical commit
   - Easy to revert if needed
   - Clear what each feature added

**If you find yourself on main/master:**
- STOP immediately
- Create a branch: `git checkout -b feature/your-feature`
- Continue work there

**Git hooks protection:**
- Pre-commit hook blocks commits to main/master locally
- To install: `cp .claude/hooks/pre-commit .git/hooks/pre-commit`

## File Operations

**IMPORTANT**: NEVER use bash commands (cat, echo, printf, etc.) with output redirection (`>`, `>>`, `<<`) for file operations.

- ALWAYS use the **Write tool** for creating new files
- ALWAYS use the **Edit tool** for modifying existing files
- Reserve bash exclusively for actual system commands and terminal operations (git, npm, docker, etc.)

This ensures better error handling, proper file permissions, and a better user experience.

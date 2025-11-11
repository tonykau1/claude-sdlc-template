# Git Workflow: Branch Protection & Squash Merges

## Overview

This template enforces a **branch-based development workflow** with **squash merges** to maintain a clean, linear git history.

---

## 🛡️ Branch Protection (Multi-Layer)

### Layer 1: Git Pre-Commit Hook (Local)

**What:** Blocks commits to main/master on your machine
**Installation:**
```bash
./.claude/hooks/install-git-hooks.sh
```

**How it works:**
- Runs before every commit
- Checks current branch
- Blocks if on main/master
- Provides helpful error message with fix instructions

**Test it:**
```bash
git checkout main
git commit --allow-empty -m "test"
# Should be blocked with error message
```

### Layer 2: Claude Code Settings (Agent)

**What:** Denies git commands that commit to main/master
**Location:** `.claude/settings.json`

**Rules:**
```json
{
  "deny": [
    "Bash(git push origin main:*)",
    "Bash(git push origin master:*)",
    "Bash(git commit*main*)",
    "Bash(git commit*master*)"
  ]
}
```

### Layer 3: CLAUDE.md Instructions (Agent Guidance)

**What:** Explicit instructions in main agent file
**Effect:** Claude will always create feature branches before coding

### Layer 4: GitHub Branch Protection (Optional, Paid)

**What:** Server-side enforcement
**Requires:** GitHub Team plan for private repos (free for public)
**Setup:** See `.claude/docs/GITHUB-BRANCH-PROTECTION.md`

---

## 🌿 Branch-Based Workflow

### Starting New Work

```bash
# 1. Ensure main is up-to-date
git checkout main
git pull origin main

# 2. Create feature branch
git checkout -b feature/descriptive-name

# 3. Make changes and commit
git add .
git commit -m "feat: implement feature X"

# 4. Push branch
git push -u origin feature/descriptive-name
```

### Branch Naming Conventions

```bash
# Features
feature/add-authentication
feature/user-dashboard
feature/payment-integration

# Bug fixes
fix/login-timeout
fix/memory-leak
fix/validation-error

# Hotfixes (urgent production fixes)
hotfix/security-patch
hotfix/critical-bug

# Refactoring
refactor/simplify-auth
refactor/database-queries

# Experiments
experiment/new-architecture
experiment/performance-test
```

### Committing at Milestones

Commit after each logical unit of work:

```bash
# Implement core feature
git add src/auth/
git commit -m "feat: add JWT authentication logic"

# Add tests
git add tests/auth/
git commit -m "test: add authentication tests"

# Add documentation
git add docs/
git commit -m "docs: document authentication flow"

# Fix issues found during testing
git add src/auth/validation.ts
git commit -m "fix: improve token validation"
```

**Benefits:**
- ✅ Clear history of changes
- ✅ Easy to revert specific commits
- ✅ Better code review
- ✅ Easier debugging with `git bisect`

---

## 🔀 Squash Merges (Keeping History Clean)

### Why Squash?

**Without squash (messy):**
```
main: A -- B -- C -- M -- D -- E -- M -- F
                     |           |
feature1:            X -- Y -- Z
feature2:                          P -- Q -- R
```

**With squash (clean):**
```
main: A -- B -- C -- [feature1] -- D -- E -- [feature2] -- F
```

Each PR becomes one logical commit on main.

### How to Squash Merge

#### Via GitHub UI (Recommended)

1. Open your pull request
2. Click **"Squash and merge"** button (not "Merge" or "Rebase and merge")
3. Edit the commit message:
   ```
   feat: Add user authentication (#42)

   - Implement JWT tokens
   - Add login/logout endpoints
   - Add password hashing
   - Add authentication tests

   Co-authored-by: Claude <noreply@anthropic.com>
   ```
4. Click **"Confirm squash and merge"**

#### Via GitHub CLI

```bash
gh pr merge --squash --delete-branch
```

#### Set as Default

**In GitHub repo settings:**
1. Go to Settings → General
2. Scroll to "Pull Requests"
3. Uncheck "Allow merge commits"
4. Uncheck "Allow rebase merging"
5. Keep only "Allow squash merging" checked
6. Save changes

Now squash is the only option! 🎉

---

## 📝 Commit Message Format

Use **Conventional Commits** format:

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Formatting, missing semicolons, etc (no code change)
- `refactor`: Code change that neither fixes a bug nor adds a feature
- `perf`: Performance improvement
- `test`: Adding or updating tests
- `chore`: Maintenance, dependencies, build config

### Examples

```bash
# Simple feature
git commit -m "feat: add email notifications"

# Bug fix with scope
git commit -m "fix(auth): resolve token expiration issue"

# Breaking change
git commit -m "feat!: change API response format

BREAKING CHANGE: All API responses now include pagination metadata"

# Documentation
git commit -m "docs: update API documentation for v2 endpoints"

# Multiple changes (in PR description)
feat: Add user authentication system

- Implement JWT token generation
- Add login/logout endpoints
- Add password hashing with bcrypt
- Add authentication middleware
- Add comprehensive tests

Closes #42
```

---

## 🔄 Pull Request Workflow

### 1. Create PR

```bash
# Push your branch
git push -u origin feature/your-feature

# Create PR via CLI
gh pr create \
  --title "feat: Add user authentication" \
  --body "$(cat << 'EOF'
## Summary
Implements JWT-based authentication system

## Changes
- Add login/logout endpoints
- Add JWT token generation
- Add authentication middleware
- Add tests with 95% coverage

## Testing
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed

## Screenshots
(if UI changes)
EOF
)"
```

### 2. Review Process

**As author:**
- Respond to comments
- Make requested changes
- Push updates to same branch
- Mark conversations as resolved

**Making changes:**
```bash
# Make requested changes
git add .
git commit -m "fix: address review comments"
git push

# PR automatically updates
```

### 3. Merge

**After approval:**
1. Ensure CI passes
2. Resolve any conflicts
3. Click **"Squash and merge"**
4. Edit commit message (include PR number)
5. Confirm merge
6. Delete branch

### 4. Cleanup

```bash
# Update local main
git checkout main
git pull origin main

# Delete local feature branch
git branch -d feature/your-feature

# Remote branch auto-deleted on GitHub
```

---

## ⚠️ Handling Conflicts

### Update Branch with Latest Main

```bash
# Fetch latest changes
git fetch origin

# Merge main into your branch
git checkout feature/your-feature
git merge origin/main

# Resolve conflicts, then:
git add .
git commit -m "chore: merge main into feature branch"
git push
```

### Alternative: Rebase (Cleaner)

```bash
git checkout feature/your-feature
git rebase origin/main

# Resolve conflicts at each commit
git add .
git rebase --continue

# Force push (your branch only!)
git push --force-with-lease
```

**⚠️ Warning:** Only rebase branches you own. Never rebase shared branches.

---

## 🚨 Emergency Procedures

### Bypass Pre-Commit Hook (Emergency Only)

```bash
git commit --no-verify -m "hotfix: critical security patch"
```

**Only use when:**
- Production is down
- Security vulnerability needs immediate patch
- Pre-commit hook is buggy and blocking legitimate work

**After emergency:**
- Document why bypass was needed
- Create issue to prevent future need for bypass

### Direct Push to Main (Absolute Emergency)

**If you must (extremely rare):**

1. **Make backup:**
```bash
git checkout -b backup-before-emergency
git push origin backup-before-emergency
```

2. **Make fix:**
```bash
git checkout main
git pull origin main
# Make your changes
git add .
git commit -m "hotfix: critical fix with reason"
git push origin main
```

3. **Document:**
- Create issue explaining why
- What went wrong
- How to prevent future occurrences

4. **Clean up:**
- Create proper PR with the fix (for review)
- Update documentation
- Improve safeguards

---

## 📊 Viewing History

### See Clean History

```bash
# View squashed commits on main
git log --oneline main

# Should show one commit per feature
# Example output:
# a1b2c3d feat: Add user authentication (#42)
# e4f5g6h fix: Resolve login timeout (#41)
# i7j8k9l feat: Add payment processing (#40)
```

### See Detailed Feature Work

```bash
# View full history with PR branch commits
git log --graph --all --oneline

# See what went into a specific PR
git log --oneline main^..feature/your-feature
```

---

## 🎯 Best Practices

### DO ✅

- ✅ Create feature branch for every change
- ✅ Commit at logical milestones
- ✅ Write descriptive commit messages
- ✅ Use squash merge for PRs
- ✅ Delete branches after merge
- ✅ Keep PRs focused and small
- ✅ Test before creating PR
- ✅ Review your own code first

### DON'T ❌

- ❌ Commit directly to main/master
- ❌ Force push to main/master
- ❌ Create huge PRs with multiple features
- ❌ Commit without testing
- ❌ Bypass pre-commit hooks casually
- ❌ Leave branches undeleted
- ❌ Skip code review
- ❌ Merge without CI passing

---

## 🔧 Troubleshooting

### "I accidentally committed to main"

```bash
# DON'T PUSH! Create branch from current state
git branch feature/moved-from-main

# Reset main to remote
git checkout main
git reset --hard origin/main

# Continue work on feature branch
git checkout feature/moved-from-main
git push -u origin feature/moved-from-main
```

### "I pushed to main by accident"

```bash
# If no one else has pulled:
git reset --hard HEAD~1
git push --force origin main

# If others have pulled (create revert):
git revert HEAD
git push origin main

# Then create proper PR with the changes
```

### "Pre-commit hook not working"

```bash
# Check if installed
ls -la .git/hooks/pre-commit

# Reinstall
./.claude/hooks/install-git-hooks.sh

# Check if executable
chmod +x .git/hooks/pre-commit
```

### "Can't merge - branch outdated"

```bash
# Update your branch
git checkout feature/your-feature
git fetch origin
git merge origin/main
git push

# Or rebase for cleaner history
git rebase origin/main
git push --force-with-lease
```

---

## 📚 Additional Resources

- **Full setup guide:** `.claude/docs/GITHUB-BRANCH-PROTECTION.md`
- **Main instructions:** `.claude/CLAUDE.md`
- **Conventional Commits:** https://www.conventionalcommits.org/
- **GitHub Flow:** https://guides.github.com/introduction/flow/

---

## Summary

**Your workflow:**
1. ✅ Create feature branch
2. ✅ Commit at milestones
3. ✅ Push branch and create PR
4. ✅ Get review and approval
5. ✅ **Squash and merge** (clean history!)
6. ✅ Delete branch
7. ✅ Update local main

**Protection layers:**
- 🛡️ Local git hook (blocks commits to main)
- 🛡️ Claude Code settings (denies main commits)
- 🛡️ Agent instructions (always uses branches)
- 🛡️ GitHub protection (optional, paid)

**Result:** Clean, linear history on main with each PR as one logical commit! 🎉

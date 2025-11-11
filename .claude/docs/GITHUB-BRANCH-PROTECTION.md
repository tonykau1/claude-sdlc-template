# GitHub Branch Protection Guide

## Overview

This guide shows you how to configure GitHub to **prevent direct commits to main/master** and enforce a pull request workflow.

---

## Why Branch Protection?

✅ **Prevents accidents** - No accidental commits to main
✅ **Enforces review** - All changes go through PRs
✅ **Maintains quality** - CI/CD runs before merge
✅ **Creates history** - Clear audit trail of changes
✅ **Team coordination** - Everyone follows same workflow

---

## Quick Setup (GitHub Web UI)

### Step 1: Navigate to Settings

1. Go to your repository on GitHub
2. Click **Settings** tab (top right)
3. Click **Branches** (left sidebar under "Code and automation")

### Step 2: Add Branch Protection Rule

1. Click **Add branch protection rule**
2. In "Branch name pattern" enter: `main` (or `master` if you use that)

### Step 3: Configure Protection Rules

**Required settings** (check these boxes):

✅ **Require a pull request before merging**
   - ✅ Require approvals: 1 (or more for teams)
   - ✅ Dismiss stale pull request approvals when new commits are pushed
   - ✅ Require review from Code Owners (optional, if you have CODEOWNERS file)

✅ **Require status checks to pass before merging** (if you have CI/CD)
   - ✅ Require branches to be up to date before merging
   - Select your CI checks (e.g., "build", "test", "lint")

✅ **Require conversation resolution before merging** (recommended)

✅ **Do not allow bypassing the above settings**
   - This prevents admins from accidentally pushing directly

**Optional but recommended:**

✅ **Require linear history** - Prevents messy merge commits
✅ **Require deployments to succeed** - If you have automated deployments
✅ **Lock branch** - Prevents any pushes (very strict, usually not needed)

### Step 4: Save

Click **Create** or **Save changes** at the bottom.

---

## Configuration via GitHub CLI

If you prefer command-line:

```bash
# Install GitHub CLI if needed
brew install gh

# Authenticate
gh auth login

# Create branch protection rule
gh api repos/:owner/:repo/branches/main/protection \
  --method PUT \
  --field required_pull_request_reviews='{"required_approving_review_count":1,"dismiss_stale_reviews":true}' \
  --field enforce_admins=true \
  --field required_conversation_resolution=true
```

---

## Configuration via Repository Settings File

**For GitHub Enterprise or advanced setups:**

Create `.github/settings.yml` (requires GitHub Settings App):

```yaml
branches:
  - name: main
    protection:
      required_pull_request_reviews:
        required_approving_review_count: 1
        dismiss_stale_reviews: true
        require_code_owner_reviews: false
      required_status_checks:
        strict: true
        contexts:
          - build
          - test
          - lint
      enforce_admins: true
      required_conversation_resolution: true
      restrictions: null
```

---

## Verification

After setup, test that it works:

```bash
# Try to push directly to main (should fail)
git checkout main
git commit --allow-empty -m "test direct commit"
git push origin main

# Expected error:
# remote: error: GH006: Protected branch update failed for refs/heads/main.
# remote: error: Changes must be made through a pull request.
```

If you see this error, **it's working!** 🎉

---

## Developer Workflow with Protected Main

### 1. Start New Work

```bash
# Ensure you're on main and up-to-date
git checkout main
git pull origin main

# Create feature branch
git checkout -b feature/your-feature-name
```

### 2. Make Changes

```bash
# Make your changes
vim src/file.js

# Commit at milestones
git add .
git commit -m "feat: implement feature X"

# Continue work
vim src/another-file.js
git add .
git commit -m "test: add tests for feature X"
```

### 3. Push and Create PR

```bash
# Push branch to remote
git push -u origin feature/your-feature-name

# Create PR via GitHub CLI
gh pr create --title "Feature: Your Feature" --body "Description of changes"

# Or create PR via GitHub web UI
```

### 4. After PR is Approved

```bash
# Merge via GitHub UI (click "Merge pull request")
# Or via CLI:
gh pr merge --squash

# Update local main
git checkout main
git pull origin main

# Delete feature branch
git branch -d feature/your-feature-name
git push origin --delete feature/your-feature-name
```

---

## Exceptions & Bypassing

### When You Need to Bypass (Emergencies Only)

**Option 1: Temporarily disable protection**
1. Go to Settings → Branches
2. Edit the protection rule
3. Uncheck "Do not allow bypassing"
4. Make your emergency push
5. **Re-enable immediately**

**Option 2: Admin override (if allowed)**
```bash
# Some orgs allow admins to push with a flag
git push origin main --force-with-lease
```

**⚠️ WARNING**: Only bypass in true emergencies (site down, security fix, etc.)

---

## Common Issues & Solutions

### Issue: "I accidentally committed to main"

**Solution:**
```bash
# DON'T PUSH! Create a branch from current state
git branch feature/moved-from-main

# Reset main to remote
git checkout main
git reset --hard origin/main

# Switch to feature branch and continue
git checkout feature/moved-from-main
```

### Issue: "CI checks are required but I don't have CI"

**Solution:**
1. Either set up CI (recommended)
2. Or disable "Require status checks" in branch protection

### Issue: "I need to merge without review for hotfix"

**Solution:**
1. Still create a PR (for documentation)
2. If you're admin and bypass is allowed, merge immediately
3. Or temporarily disable review requirement
4. **Document why in PR description**

### Issue: "PR can't merge - branch is out of date"

**Solution:**
```bash
# Update your feature branch with latest main
git checkout feature/your-feature
git fetch origin
git merge origin/main

# Or rebase (cleaner history)
git rebase origin/main

# Push updated branch
git push --force-with-lease
```

---

## Additional Protections

### CODEOWNERS File

Create `.github/CODEOWNERS` to require specific reviewers:

```
# Default owners for everything
* @your-username

# Specific paths
/src/backend/ @backend-team
/src/frontend/ @frontend-team
*.md @docs-team

# Require security review for auth code
/src/auth/ @security-team
```

### Status Checks (CI/CD)

Require these checks to pass:

```yaml
# Example: GitHub Actions workflow
name: CI
on: pull_request

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: npm install
      - run: npm run build
      - run: npm test
      - run: npm run lint
```

### Auto-merge for Bots

Allow Dependabot PRs to auto-merge:

```yaml
# .github/workflows/auto-merge.yml
name: Auto-merge Dependabot PRs
on: pull_request

jobs:
  auto-merge:
    if: github.actor == 'dependabot[bot]'
    runs-on: ubuntu-latest
    steps:
      - name: Enable auto-merge
        run: gh pr merge --auto --squash "$PR_URL"
        env:
          PR_URL: ${{github.event.pull_request.html_url}}
          GITHUB_TOKEN: ${{secrets.GITHUB_TOKEN}}
```

---

## Best Practices

### Branch Naming

```bash
# Feature branches
feature/add-authentication
feature/user-dashboard

# Bug fixes
fix/login-error
fix/memory-leak

# Hotfixes
hotfix/security-patch
hotfix/prod-down

# Experiments
experiment/new-api-design
```

### Commit Messages

Follow conventional commits:

```bash
feat: add user authentication
fix: resolve login timeout issue
docs: update API documentation
test: add integration tests for payments
refactor: simplify database queries
chore: update dependencies
```

### PR Descriptions

Include:
- **What** changed
- **Why** it changed
- **How** to test
- **Screenshots** (for UI changes)
- **Breaking changes** (if any)

---

## Team Setup Checklist

When setting up for a team:

- [ ] Enable branch protection on main/master
- [ ] Require at least 1 approval
- [ ] Set up CI/CD status checks
- [ ] Create CODEOWNERS file
- [ ] Document workflow in README
- [ ] Train team on PR process
- [ ] Set up GitHub Actions for automation
- [ ] Configure notifications
- [ ] Test protection rules
- [ ] Create PR template

---

## GitHub PR Template

Create `.github/pull_request_template.md`:

```markdown
## Description
<!-- What does this PR do? Why? -->

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
<!-- How was this tested? -->

## Checklist
- [ ] Code follows style guidelines
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] No breaking changes (or documented)
- [ ] Reviewed own code first
```

---

## Summary

**With branch protection enabled:**

✅ No direct commits to main
✅ All changes via pull requests
✅ Required reviews before merge
✅ CI/CD checks must pass
✅ Conversation resolution enforced
✅ Clear audit trail
✅ Team collaboration workflow

**Setup takes 5 minutes, saves countless headaches!**

---

## Resources

- [GitHub Branch Protection Docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches)
- [CODEOWNERS Documentation](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners)
- [GitHub Actions](https://docs.github.com/en/actions)
- [Conventional Commits](https://www.conventionalcommits.org/)

---

**Your main branch is now protected! All changes must go through the PR workflow. 🛡️**

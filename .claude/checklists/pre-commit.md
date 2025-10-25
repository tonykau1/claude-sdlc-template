# Pre-Commit Checklist

Run through this checklist before every commit to maintain code quality and avoid issues.

## 🧹 Code Quality

- [ ] **Code runs without errors**
  - Application starts successfully?
  - No compilation errors?
  - No runtime errors in affected areas?

- [ ] **Linter passes**
  - Run linter: `npm run lint` (or equivalent)
  - All warnings addressed or documented?
  - Code style consistent?

- [ ] **Formatter applied**
  - Run formatter: `npm run format` (or equivalent)
  - Consistent indentation and spacing?

- [ ] **No debug code**
  - `console.log()` statements removed?
  - Debugging breakpoints removed?
  - Test-only code removed?
  - Commented-out code removed?

## 🧪 Testing

- [ ] **All tests pass**
  - Unit tests: `npm test`
  - Integration tests pass?
  - No skipped/disabled tests without reason?

- [ ] **New tests added**
  - New features have tests?
  - Bug fixes have regression tests?
  - Edge cases covered?

- [ ] **Test coverage acceptable**
  - Coverage hasn't decreased?
  - Critical paths covered?
  - Business logic tested?

## 🔒 Security

- [ ] **No secrets committed**
  - API keys not in code?
  - Passwords not in code?
  - Private keys not included?
  - `.env` file not committed?

- [ ] **Sensitive data not logged**
  - Passwords not in logs?
  - API keys not in error messages?
  - User PII properly handled?

- [ ] **Input validation present**
  - User input validated?
  - SQL injection prevented?
  - XSS prevented?

## 📝 Code Review Self-Check

- [ ] **Code is readable**
  - Variable names clear?
  - Functions have single responsibility?
  - Complex logic commented?

- [ ] **No TODOs or FIXMEs** (or documented in issues)
  - All TODOs tracked as issues?
  - No temporary hacks?

- [ ] **Dependencies justified**
  - New dependencies necessary?
  - License compatible?
  - Security scan passed?

- [ ] **Business logic separated**
  - Logic not mixed with presentation?
  - Functions are testable?
  - Concerns separated?

## 🗃️ Data & Database

- [ ] **Migrations tested** (if applicable)
  - Migration runs successfully?
  - Rollback tested?
  - Data integrity maintained?

- [ ] **Indexes added** (if needed)
  - Slow queries identified?
  - Appropriate indexes created?

## 📚 Documentation

- [ ] **Code comments added** (where needed)
  - Complex logic explained?
  - Why documented, not just what?

- [ ] **API docs updated** (if applicable)
  - New endpoints documented?
  - Request/response examples updated?
  - Error responses documented?

- [ ] **README updated** (if needed)
  - Setup instructions current?
  - New environment variables documented?

## 🔍 Version Control

- [ ] **Files staged correctly**
  - Only relevant files included?
  - No accidental files (`.DS_Store`, etc.)?
  - Generated files excluded?

- [ ] **Commit message follows conventions**
  - Format: `type(scope): description`
  - Types: feat, fix, docs, style, refactor, test, chore
  - Example: `feat(auth): add password reset flow`
  - Clear and descriptive?
  - References issue/ticket?

- [ ] **Commit is atomic**
  - Single logical change?
  - Not mixing unrelated changes?
  - Could be reverted cleanly?

## ⚡ Performance

- [ ] **No obvious performance issues**
  - No n+1 queries?
  - Large loops optimized?
  - Unnecessary network calls removed?

- [ ] **Memory leaks prevented**
  - Event listeners cleaned up?
  - Timers/intervals cleared?
  - Subscriptions unsubscribed?

## 🎨 UI/Frontend (if applicable)

- [ ] **UI tested manually**
  - Functionality works as expected?
  - No visual bugs?
  - Responsive on different screen sizes?

- [ ] **Accessibility checked**
  - Keyboard navigation works?
  - Alt text on images?
  - Color contrast sufficient?

- [ ] **Cross-browser tested** (if critical)
  - Works in Chrome/Firefox/Safari?
  - Mobile browsers tested?

## 📦 Build & Deployment

- [ ] **Build succeeds**
  - Production build works?
  - No build warnings?

- [ ] **Environment variables documented**
  - New env vars in `.env.example`?
  - Documentation updated?

## ✅ Final Verification

- [ ] **Changes reviewed personally**
  - Reviewed your own diff?
  - No unintended changes?
  - Only intended files modified?

- [ ] **Feature works end-to-end**
  - Tested complete user flow?
  - Error cases handled?
  - Edge cases considered?

---

## 🤖 Automation Helpers

Consider adding these to your pre-commit hooks:

```bash
#!/bin/bash
# .git/hooks/pre-commit

# Run linter
npm run lint || exit 1

# Run tests
npm test || exit 1

# Check for secrets
git diff --cached | grep -i "api_key\|password\|secret" && \
  echo "⚠️  Possible secret detected!" && exit 1

# Check for console.log
git diff --cached | grep -E "console\.(log|error|warn)" && \
  echo "⚠️  Console statements detected!" && exit 1

exit 0
```

## 💡 Pro Tips

**Before committing, ask yourself:**
- Would I be comfortable with someone reviewing this right now?
- Is this the smallest logical change I could make?
- Have I tested the happy path AND error cases?
- Will this be easy to understand in 6 months?

**Speed up commits:**
- Fix linting issues as you go
- Write tests alongside code
- Run tests frequently during development
- Use IDE plugins for real-time feedback

## 🚨 Never Commit If:

- Tests are failing (and you know why)
- Code doesn't compile
- You haven't tested it
- Contains secrets or credentials
- It's 3am and you're tired (save for morning!)

## 📝 Commit Message Examples

```
✅ GOOD:
feat(auth): add password reset functionality
fix(api): prevent null pointer in user service
docs(readme): update installation instructions
refactor(utils): extract common validation logic
test(users): add edge cases for email validation

❌ BAD:
WIP
fix stuff
asdf
updated files
final version
```

## Next Steps

After committing:
1. Push to remote regularly
2. Keep commits small and frequent
3. Prepare for PR review (see pre-merge checklist)
4. Continue with next task or feature

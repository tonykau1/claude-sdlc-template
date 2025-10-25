# Pre-Merge Checklist

Complete this checklist before merging a Pull Request to ensure production-ready code.

## 📋 PR Basics

- [ ] **PR description complete**
  - What does this PR do?
  - Why is this change needed?
  - How was it implemented?
  - Screenshots/videos (if UI changes)?
  - Breaking changes documented?

- [ ] **Issue/ticket linked**
  - References issue number (e.g., "Closes #123")?
  - Requirements traceable?

- [ ] **PR size reasonable**
  - < 400 lines changed (ideally)?
  - If larger, is it justified?
  - Could it be split into smaller PRs?

## 🧪 Testing

- [ ] **All tests pass**
  - CI/CD pipeline green?
  - Unit tests passing?
  - Integration tests passing?
  - E2E tests passing (if applicable)?

- [ ] **New tests added**
  - New features have tests?
  - Bug fixes have regression tests?
  - Test coverage maintained or improved?

- [ ] **Manual testing completed**
  - Feature tested in dev environment?
  - Edge cases tested?
  - Error handling verified?

- [ ] **Cross-browser tested** (if frontend)
  - Chrome ✓
  - Firefox ✓
  - Safari ✓
  - Mobile browsers (if applicable) ✓

- [ ] **Responsive design verified** (if UI changes)
  - Mobile (320px+)
  - Tablet (768px+)
  - Desktop (1024px+)

## 🔒 Security

- [ ] **Security review completed**
  - Input validation present?
  - Output encoding applied?
  - Authorization checks in place?
  - No SQL injection vulnerabilities?
  - No XSS vulnerabilities?

- [ ] **Secrets properly managed**
  - No hardcoded secrets?
  - Environment variables used?
  - Secrets not in logs?

- [ ] **Security scan passed**
  - Dependency vulnerabilities checked?
  - SAST scan clean?
  - No new security warnings?

## 📝 Code Quality

- [ ] **Code review feedback addressed**
  - All review comments resolved?
  - Requested changes implemented?
  - Questions answered?

- [ ] **Code follows standards**
  - Naming conventions followed?
  - Code style consistent?
  - Linter passes?
  - Formatter applied?

- [ ] **No code smells**
  - No duplicate code?
  - Functions not too long (< 50 lines)?
  - Cyclomatic complexity reasonable?
  - No deep nesting (< 4 levels)?

- [ ] **Business logic separated**
  - Not mixed with presentation layer?
  - Pure functions where possible?
  - Testable architecture?

## 🗃️ Database & Data

- [ ] **Migrations tested** (if applicable)
  - Migration runs successfully?
  - Rollback tested?
  - No data loss?
  - Applied to staging environment?

- [ ] **Indexes added** (if needed)
  - Slow queries identified and indexed?
  - Query performance acceptable?

- [ ] **Data integrity maintained**
  - Foreign key constraints respected?
  - Validation at database level?
  - No orphaned records?

## 📚 Documentation

- [ ] **Code documented**
  - Complex logic explained?
  - Public APIs documented?
  - JSDoc/docstrings added?

- [ ] **API documentation updated** (if applicable)
  - OpenAPI/Swagger spec updated?
  - New endpoints documented?
  - Request/response examples updated?
  - Error responses documented?

- [ ] **User documentation updated** (if needed)
  - User-facing features documented?
  - Help text updated?
  - Changelog entry added?

- [ ] **Technical documentation updated**
  - README updated if setup changed?
  - Architecture docs updated?
  - ADR created if significant decision?

- [ ] **Environment variables documented**
  - New variables in `.env.example`?
  - Setup instructions updated?
  - Default values specified?

## ⚡ Performance

- [ ] **Performance acceptable**
  - No obvious performance regressions?
  - Load time reasonable?
  - Database queries optimized?

- [ ] **Resource usage reasonable**
  - Memory usage acceptable?
  - No memory leaks?
  - CPU usage normal?

- [ ] **Bundle size acceptable** (if frontend)
  - No large dependencies added unnecessarily?
  - Code splitting used appropriately?
  - Lazy loading implemented?

## ♿ Accessibility (if UI changes)

- [ ] **WCAG 2.1 AA compliance**
  - Semantic HTML used?
  - Proper heading hierarchy?
  - Alt text on images?
  - Form labels present?

- [ ] **Keyboard navigation**
  - All interactive elements reachable?
  - Tab order logical?
  - Focus indicators visible?

- [ ] **Screen reader compatible**
  - ARIA labels where needed?
  - Content reads in logical order?

- [ ] **Color contrast sufficient**
  - Text readable (4.5:1 ratio)?
  - Interactive elements distinguishable?

## 🔄 Integration

- [ ] **Backwards compatible** (or migration path documented)
  - Existing functionality not broken?
  - API changes backwards compatible?
  - Database changes reversible?

- [ ] **Integration points tested**
  - Works with existing features?
  - Dependencies updated if needed?
  - Third-party integrations tested?

- [ ] **Conflicts resolved**
  - No merge conflicts?
  - Rebased on latest main/develop?

## 📦 Build & Deployment

- [ ] **Build succeeds**
  - Production build works?
  - No build errors or warnings?
  - Assets optimized?

- [ ] **Configuration checked**
  - Environment-specific config correct?
  - Feature flags set appropriately?

- [ ] **Deployment plan ready**
  - Deployment steps documented?
  - Rollback plan clear?
  - Database migrations coordinated?

## 🎯 Product & UX

- [ ] **Acceptance criteria met**
  - All requirements implemented?
  - Edge cases handled?
  - Error messages user-friendly?

- [ ] **UX reviewed** (if applicable)
  - Intuitive to use?
  - Consistent with design system?
  - Loading states present?
  - Error states handled gracefully?

- [ ] **Copy reviewed** (if user-facing)
  - Grammar and spelling correct?
  - Tone appropriate?
  - Terminology consistent?

## 📊 Monitoring & Observability

- [ ] **Logging added**
  - Important events logged?
  - Error logging comprehensive?
  - No sensitive data in logs?

- [ ] **Metrics added** (if applicable)
  - Key events tracked?
  - Performance metrics captured?

- [ ] **Alerts configured** (if needed)
  - Critical errors trigger alerts?
  - Thresholds appropriate?

## ✅ Final Verification

- [ ] **Reviewed own changes**
  - Reviewed the entire diff?
  - No unintended changes?
  - Debug code removed?

- [ ] **CI/CD pipeline green**
  - All checks passed?
  - No skipped tests?
  - Coverage requirements met?

- [ ] **Required approvals received**
  - Code review approved?
  - Product approval (if needed)?
  - Design approval (if UI changes)?

- [ ] **Ready to deploy**
  - Confident code is production-ready?
  - No known issues?
  - Stakeholders informed?

---

## 👥 Review Guidelines

### For Reviewers:
- Review within 24 hours
- Provide constructive feedback
- Approve if minor changes needed
- Request changes if significant issues
- Test locally if possible

### For Authors:
- Respond to all comments
- Explain your reasoning
- Don't take feedback personally
- Push changes and re-request review
- Thank reviewers for their time

## 🚨 Blocking Issues

**Do NOT merge if:**
- CI/CD pipeline failing
- Security vulnerabilities present
- Test coverage decreased significantly
- Required approvals not received
- Known bugs introduced
- Breaking changes not communicated
- Performance significantly degraded

## 💡 Pro Tips

**Speed up reviews:**
- Keep PRs small and focused
- Write good descriptions
- Add screenshots/videos
- Link to relevant docs
- Pre-review your own code

**Before requesting review:**
- Self-review the entire diff
- Test thoroughly
- Update documentation
- Respond to automated feedback
- Ensure CI is green

## 📝 PR Title Format

```
✅ GOOD:
feat: Add password reset functionality
fix: Prevent null pointer in user service
docs: Update installation instructions
refactor: Extract validation logic to utils
perf: Optimize database query for user search

❌ BAD:
Update code
Bug fix
WIP
Changes
Final version
```

## 📋 PR Description Template

```markdown
## What
Brief description of what this PR does.

## Why
Why is this change needed? What problem does it solve?

## How
How was it implemented? Any important technical details?

## Testing
How was this tested? What scenarios were covered?

## Screenshots
(if UI changes)

## Breaking Changes
(if applicable)

## Checklist
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] Manually tested
- [ ] Security reviewed

Closes #123
```

## Next Steps

After merging:
1. Delete feature branch
2. Monitor deployment
3. Verify in staging/production
4. Update relevant stakeholders
5. Close related issues

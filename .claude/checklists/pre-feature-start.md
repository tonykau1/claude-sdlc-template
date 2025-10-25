# Pre-Feature Start Checklist

Use this checklist before starting any new feature to ensure proper planning and avoid rework.

## 📋 Requirements & Planning

- [ ] **Business requirements documented**
  - What problem does this solve?
  - Who are the users?
  - What's the expected outcome?
  - Success metrics defined?

- [ ] **User stories written**
  - As a [user type], I want [goal], so that [benefit]
  - Acceptance criteria clear?
  - Edge cases identified?

- [ ] **Design/mockups reviewed** (if applicable)
  - UI/UX approved?
  - Responsive design considered?
  - Accessibility requirements clear?

- [ ] **Technical approach discussed**
  - Solution makes sense?
  - Alternatives considered?
  - Team alignment on approach?

## 🏗️ Architecture & Design

- [ ] **Impact assessment completed**
  - Which components/services affected?
  - Database changes needed?
  - API changes needed?
  - Breaking changes identified?

- [ ] **Architecture Decision Record (ADR) created** (if significant)
  - Context documented?
  - Decision explained?
  - Consequences understood?
  - Alternatives captured?

- [ ] **Data model reviewed**
  - Schema changes needed?
  - Migration plan ready?
  - Index strategy defined?

- [ ] **API contract defined** (if applicable)
  - Endpoints documented?
  - Request/response formats clear?
  - Error responses defined?
  - Versioning considered?

## 🔒 Security Considerations

- [ ] **Security review initiated**
  - New attack surface identified?
  - Authentication/authorization requirements clear?
  - Data sensitivity assessed?
  - Compliance requirements reviewed?

- [ ] **Input validation planned**
  - What inputs need validation?
  - What's the sanitization strategy?
  - Error handling defined?

- [ ] **Secrets/credentials identified**
  - What secrets are needed?
  - How will they be stored?
  - Rotation strategy considered?

## 🧪 Testing Strategy

- [ ] **Test plan created**
  - What needs to be tested?
  - Test data requirements clear?
  - Edge cases identified?

- [ ] **Testing approach defined**
  - Unit tests scope?
  - Integration tests needed?
  - E2E tests required?

- [ ] **Performance considerations**
  - Expected load/scale?
  - Performance targets set?
  - Load testing needed?

## 📚 Dependencies & Resources

- [ ] **Dependencies identified**
  - New libraries needed?
  - Third-party services required?
  - License compatibility checked?

- [ ] **Environment setup**
  - Development environment ready?
  - Test data available?
  - Access permissions granted?

- [ ] **Related work identified**
  - Blocking issues resolved?
  - Dependent features tracked?
  - Integration points coordinated?

## 👥 Communication & Collaboration

- [ ] **Stakeholders notified**
  - Product team informed?
  - Design team consulted?
  - Other engineers aware?

- [ ] **Timeline estimated**
  - Realistic time estimate?
  - Deadlines communicated?
  - Dependencies flagged?

- [ ] **Documentation plan**
  - What docs need updates?
  - User-facing docs needed?
  - API docs required?

## 🌿 Git & Workflow

- [ ] **Feature branch created**
  - Naming convention followed? (e.g., `feature/user-authentication`)
  - Branched from latest main/develop?

- [ ] **Issue/ticket referenced**
  - GitHub issue created?
  - Jira ticket linked?
  - Requirements traceable?

## 📊 Monitoring & Observability

- [ ] **Monitoring strategy defined**
  - What metrics to track?
  - Alerts needed?
  - Logging requirements clear?

- [ ] **Rollback plan considered**
  - How to revert if issues?
  - Feature flags needed?
  - Staged rollout planned?

## ✅ Final Checks

- [ ] **All questions answered**
  - No blocking unknowns?
  - Assumptions documented?
  - Risks identified?

- [ ] **Ready to start**
  - Clear understanding of requirements?
  - Confident in approach?
  - Resources available?

---

## 💡 Tips

- **Don't skip this step!** 10 minutes of planning saves hours of rework
- **Ask questions early** - assumptions are expensive
- **Document as you go** - future you will thank you
- **When in doubt, start smaller** - break large features into phases

## 🚨 Red Flags

If any of these are true, **STOP** and clarify before proceeding:

- Requirements are vague or contradictory
- No clear success criteria
- Multiple approaches with no decision
- Security concerns not addressed
- No idea how to test it
- Blocking dependencies unresolved

## 📝 Next Steps

After completing this checklist:

1. Create feature documentation in `.claude/project/features/[feature-name]/`
2. Start with tests (TDD approach)
3. Implement incrementally
4. Commit frequently with clear messages
5. Review your own code before pushing

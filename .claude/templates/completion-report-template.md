# Completion Report Template

Use this template when completing any significant task to provide evidence-based verification of completion.

## Task Information

**Task**: [Brief description of what was requested]

**Date**: [Completion date]

**Duration**: [Time spent]

**Agent(s) Involved**: [Which agents worked on this]

---

## ✅ Primary Deliverables

List each deliverable with specific evidence of completion:

### Deliverable 1: [Name]
- **Status**: COMPLETE
- **Evidence**: [Screenshot/output/file location showing it works]
- **Details**: [Brief description of what was delivered]

### Deliverable 2: [Name]
- **Status**: COMPLETE
- **Evidence**: [Screenshot/output/file location showing it works]
- **Details**: [Brief description of what was delivered]

---

## ✅ Quality Gates

Document that all quality criteria were met:

### Code Quality
- [ ] **Code compiles/builds without errors**
  - Evidence: [Build output or test results]
- [ ] **Code follows established patterns and standards**
  - Evidence: [Linter output, code review notes]
- [ ] **No warnings or errors introduced**
  - Evidence: [Verification output]

### Testing
- [ ] **All tests passing**
  - Evidence: [Test output or test run screenshot]
- [ ] **New tests written for new functionality**
  - Evidence: [Test file locations and coverage]
- [ ] **No regressions in existing functionality**
  - Evidence: [Regression test results]

### Integration
- [ ] **Integrates correctly with existing components**
  - Evidence: [Integration test results]
- [ ] **Dependencies properly managed**
  - Evidence: [Package updates, import verification]
- [ ] **APIs/interfaces compatible**
  - Evidence: [API test results, contract validation]

### Standards Compliance
- [ ] **File size limits maintained** (if applicable)
  - Report: [List files with LOC counts]
- [ ] **Security considerations addressed**
  - Evidence: [Security checklist, threat analysis]
- [ ] **Accessibility requirements met** (if UI changes)
  - Evidence: [Accessibility audit results]
- [ ] **Performance impact acceptable**
  - Evidence: [Performance metrics before/after]

---

## ✅ Verification Evidence

### Functional Testing
[Describe how you verified the feature/fix actually works]

**Test Steps**:
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Expected Behavior**: [What should happen]

**Actual Behavior**: [What did happen]

**Screenshots/Output**:
```
[Paste relevant console output, screenshots, or test results]
```

### Edge Case Testing
[List edge cases tested and results]

- **Edge case 1**: [Description] → [Result]
- **Edge case 2**: [Description] → [Result]
- **Edge case 3**: [Description] → [Result]

### Error Handling
[How error scenarios were tested]

- **Error scenario 1**: [Description] → [Handled correctly: Yes/No]
- **Error scenario 2**: [Description] → [Handled correctly: Yes/No]

---

## ⚠️ Limitations & Assumptions

### Known Limitations
[Any limitations in the current implementation]

1. [Limitation 1 and why it exists]
2. [Limitation 2 and why it exists]

### Assumptions Made
[Any assumptions that were made during implementation]

1. [Assumption 1 and justification]
2. [Assumption 2 and justification]

### Future Improvements
[Identified opportunities for future enhancement]

1. [Improvement 1 and why it would be valuable]
2. [Improvement 2 and why it would be valuable]

---

## 📊 Metrics

### Code Changes
- **Files Modified**: [Number]
- **Files Created**: [Number]
- **Lines Added**: [Number]
- **Lines Removed**: [Number]
- **Net Change**: [Number]

### File Sizes (if applicable)
[List any files with LOC counts to verify size limits]

| File | LOC | Status |
|------|-----|--------|
| path/to/file1.js | 187 | ✅ Under limit |
| path/to/file2.js | 201 | ⚠️ Approaching limit |
| path/to/file3.js | 95 | ✅ Under limit |

### Test Coverage
- **New Tests Written**: [Number]
- **Test Coverage**: [Percentage or description]
- **All Tests Passing**: [Yes/No]

---

## 📝 Documentation Updates

- [ ] **Code comments added/updated**
  - Location: [File paths]
- [ ] **API documentation updated**
  - Location: [Documentation paths]
- [ ] **README updated** (if needed)
  - Changes: [Summary of changes]
- [ ] **ADR created** (for significant decisions)
  - Location: [ADR file path]
- [ ] **Changelog updated** (if applicable)
  - Entry: [What was added to changelog]

---

## 🔄 Integration Points

### Modified Integration Points
[List any integration points that were modified]

1. **Component/API 1**
   - What changed: [Description]
   - Backward compatible: [Yes/No]
   - Migration needed: [Yes/No - if yes, describe]

2. **Component/API 2**
   - What changed: [Description]
   - Backward compatible: [Yes/No]
   - Migration needed: [Yes/No - if yes, describe]

### New Integration Points
[List any new integration points created]

1. **New API/Interface 1**
   - Purpose: [What it does]
   - Documentation: [Where to find details]

---

## ✅ Final Status

**OVERALL STATUS**: [READY FOR DELIVERY / REQUIRES ADDITIONAL WORK]

**Completion Confidence**: [High/Medium/Low]

**Recommended Next Steps**:
1. [Next step 1]
2. [Next step 2]
3. [Next step 3]

**Blockers Resolved**: [Yes/No - if no, describe remaining blockers]

---

## Sign-off

**Completed by**: [Agent name or role]

**Reviewed by**: [Who reviewed this, if applicable]

**Date**: [Completion date]

**Notes**: [Any additional notes or context]

---

## Template Usage Notes

### When to Use This Template

- Completing a significant feature (>1 day of work)
- Fixing a critical bug
- Major refactoring effort
- Before merging to main branch
- When handing off work between agents
- For any task requiring formal verification

### How to Adapt

- Remove sections that don't apply to your task
- Add project-specific sections as needed
- Adjust quality gates to match your standards
- Customize metrics based on your requirements

### Best Practices

1. **Fill out during the task, not after** - Document as you go
2. **Be specific with evidence** - Screenshots, output, file paths
3. **Be honest about limitations** - They'll be discovered anyway
4. **Focus on verification** - Show don't tell that it works
5. **Keep it concise** - Provide enough detail without overwhelming

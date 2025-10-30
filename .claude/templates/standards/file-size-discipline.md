# File Size Discipline Standards

## Philosophy

Small, focused files are easier to understand, test, maintain, and refactor. Large files become monolithic, difficult to navigate, and prone to merge conflicts.

This document establishes file size standards and refactoring triggers to maintain code quality.

## Size Limits by File Type

### General Guidelines

| File Type | Target | Maximum | Rationale |
|-----------|--------|---------|-----------|
| Component Files | 200 LOC | 250 LOC | Keep components focused on single responsibility |
| Utility/Service Files | 200 LOC | 250 LOC | Group related functions, extract when growing |
| API Routes | 100 LOC | 100 LOC | One route per file, extract business logic to services |
| Test Files | 200 LOC | 250 LOC | Split large test suites into focused test modules |
| Configuration Files | 200 LOC | 250 LOC | Complex configs should be split by domain |
| Migration Files | 100 LOC | 150 LOC | Focused, single-purpose database changes |

### Framework-Specific Adjustments

Adjust these based on your framework and conventions:

#### React/Vue/Svelte
- **Server Components**: 200 LOC (can handle more logic)
- **Client Components**: 150 LOC (keep interactive code focused)
- **Custom Hooks**: 100 LOC maximum
- **Context Providers**: 150 LOC maximum

#### Backend (Express/FastAPI/Rails)
- **Controllers**: 150 LOC maximum
- **Models**: 200 LOC target
- **Middleware**: 100 LOC maximum
- **Services**: 200 LOC target

#### Mobile (React Native/Flutter)
- **Screens**: 200 LOC target
- **Widgets/Components**: 150 LOC maximum
- **State Management**: 200 LOC target

## Refactoring Triggers

### Green Zone (< 150 LOC)
✅ **Healthy file size** - No action needed

### Yellow Zone (150-180 LOC)
⚠️ **Flag for consideration**
- Note in code review
- Consider refactoring in next iteration
- Watch for continued growth
- Begin planning extraction strategy

### Orange Zone (180-200 LOC)
🔶 **Actively plan refactor**
- Schedule refactoring before next feature
- Document extraction opportunities
- Review with team/architect
- Block new features until refactored

### Red Zone (200+ LOC)
🔴 **Immediate refactor required**
- **Stop adding features to this file**
- Refactor immediately before any new work
- Extract to smaller, focused modules
- Update this file's imports and exports

### Critical (250+ LOC)
🚨 **Exceeds absolute maximum**
- **Code review should block**
- Must refactor before merge
- Technical debt issue created
- Post-mortem: why did we get here?

## Refactoring Strategies

### 1. Extract Related Functions
When a file has multiple related functions:

```
Before: services/user-service.js (300 LOC)
After:
  - services/user-auth.js (120 LOC)
  - services/user-profile.js (95 LOC)
  - services/user-preferences.js (85 LOC)
```

### 2. Extract Components
When a component does too much:

```
Before: components/Dashboard.jsx (280 LOC)
After:
  - components/Dashboard.jsx (120 LOC) - layout and coordination
  - components/DashboardHeader.jsx (50 LOC)
  - components/DashboardStats.jsx (60 LOC)
  - components/DashboardCharts.jsx (70 LOC)
```

### 3. Extract Utilities
When helper functions grow:

```
Before: utils/data-processing.js (320 LOC)
After:
  - utils/data-validation.js (110 LOC)
  - utils/data-transformation.js (125 LOC)
  - utils/data-formatting.js (85 LOC)
```

### 4. Extract Business Logic
When API routes have too much logic:

```
Before: api/orders.js (180 LOC)
After:
  - api/orders.js (85 LOC) - route handler only
  - services/order-service.js (120 LOC) - business logic
```

### 5. Split Test Files
When test suites grow large:

```
Before: __tests__/user-service.test.js (350 LOC)
After:
  - __tests__/user-auth.test.js (130 LOC)
  - __tests__/user-profile.test.js (110 LOC)
  - __tests__/user-preferences.test.js (110 LOC)
```

## Workflow Integration

### Before Starting Work

**Check file sizes before modifying**:
```bash
# Count lines in target file
wc -l path/to/file.js

# Or use your IDE's line count feature
```

**If file is 180+ LOC**:
1. ⛔ Stop - refactor first
2. Plan extraction strategy
3. Refactor into smaller modules
4. Then add your feature

### During Development

**Track LOC continuously**:
- Keep mental note of file size
- Stop at target limits
- Extract proactively, not reactively
- Create helper files early

**Design for small files**:
- Plan features to fit within limits
- Build in extraction from the start
- Single Responsibility Principle
- Prefer composition over inheritance

### Before Committing

**Verify file sizes**:
```bash
# Check all modified files
git diff --stat

# Count lines in modified files
git diff --name-only | xargs wc -l
```

**Pre-commit checklist**:
- [ ] No files exceed maximum limits
- [ ] Files in orange zone have refactor plan
- [ ] Files in red zone have been refactored
- [ ] Extraction creates logically cohesive modules

### During Code Review

**Review for size discipline**:
- [ ] Check LOC counts for all modified files
- [ ] Request refactoring for files exceeding limits
- [ ] Verify extracted modules have clear purpose
- [ ] Ensure no artificial splitting (keep cohesive code together)

## Measuring Lines of Code

### What Counts as a Line

**Included**:
- Code statements
- Function/class declarations
- Comments (inline and block)
- Blank lines within code blocks
- Import/export statements

**Excluded** (in some tools):
- Leading/trailing blank lines
- License headers (in some conventions)

### Tools for Counting

```bash
# Unix/Linux
wc -l file.js

# Count non-blank lines
grep -vc '^$' file.js

# Using cloc (recommended)
cloc file.js

# Using tokei
tokei file.js
```

## Exceptions to the Rules

### When Larger Files Are Acceptable

Some situations justify larger files:

1. **Generated Code**: Auto-generated files (GraphQL schemas, API clients)
2. **Configuration**: Complex but necessary configuration
3. **Constants**: Large enum/constant definitions
4. **Types**: TypeScript type definitions (though consider splitting)
5. **Legacy Code**: During migration, document plan to split

**Document exceptions**:
```javascript
// NOTE: This file exceeds size limits (350 LOC) due to [reason]
// TODO: Plan to split into [modules] - see issue #123
```

## Reporting and Monitoring

### In Pull Requests

Include file size report:
```
Modified Files LOC Report:
✅ src/components/Button.jsx: 87 LOC
⚠️ src/services/api.js: 193 LOC (approaching limit)
🔴 src/pages/Dashboard.jsx: 267 LOC (REQUIRES REFACTOR)
```

### In Completion Reports

Always report final LOC counts:
```
File Size Compliance:
- file1.js: 187 LOC ✅
- file2.js: 201 LOC ⚠️
- file3.js: 95 LOC ✅
```

### Team Metrics (Optional)

Track trends over time:
- Average file size
- Number of files exceeding limits
- Refactoring frequency
- Code growth patterns

## Best Practices

### 1. Start Small
- Begin with focused modules
- It's easier to combine than to split
- Design for composition

### 2. Refactor Continuously
- Don't wait for files to become huge
- Refactor at 180 LOC, not 300 LOC
- Build refactor time into estimates

### 3. Clear Boundaries
- Extract along natural boundaries
- Keep related code together
- Don't artificially split cohesive logic

### 4. Single Responsibility
- Each file should have one clear purpose
- If you can't describe it in one sentence, it's too big
- Extract to maintain clarity

### 5. Test While Refactoring
- Ensure tests pass after extraction
- Add tests if coverage gaps exist
- Verify no regressions

## Anti-Patterns to Avoid

### ❌ Artificial Splitting
Don't split just to hit numbers if it hurts cohesion:
```javascript
// Bad: Artificially split related logic
user-validation-name.js
user-validation-email.js
user-validation-phone.js

// Good: Keep related validations together
user-validation.js (150 LOC - cohesive)
```

### ❌ Over-Engineering
Don't create unnecessary abstractions:
```javascript
// Bad: Over-abstracted for 20 lines
abstract-base-factory-builder.js

// Good: Simple and clear
user-factory.js
```

### ❌ Ignoring Context
Consider the framework and conventions:
```javascript
// React: A 200-line component with clear sections is okay
// vs.
// 200 lines of deeply nested conditionals (refactor!)
```

## Project-Specific Adjustments

Customize these standards for your project:

1. **Adjust limits** based on your team's experience and codebase
2. **Define framework-specific rules** for your stack
3. **Create refactoring guidelines** for common patterns
4. **Establish review processes** for size violations
5. **Set up automated checks** if desired (ESLint plugins, pre-commit hooks)

## Resources

- [Single Responsibility Principle](https://en.wikipedia.org/wiki/Single-responsibility_principle)
- [Code Smells: Long Method/Large Class](https://refactoring.guru/smells/long-method)
- [Refactoring: Improving the Design of Existing Code](https://refactoring.com/)

## Summary

**Remember**: These are guidelines, not strict laws. Use judgment. The goal is maintainable, understandable code - not hitting arbitrary numbers.

**Key Principle**: If a file is hard to understand, navigate, or test, it's probably too large - regardless of LOC count.

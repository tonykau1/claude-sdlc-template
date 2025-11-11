---
name: sdlc-practices
description: SDLC best practices including quality gates, evidence-based completion, TDD, security reviews, checklists, and development workflows. Use when implementing features, fixing bugs, refactoring, testing, or preparing for deployment.
---

# SDLC Best Practices

Comprehensive software development lifecycle practices for production-quality code with AI agents.

## Purpose

This skill provides guardrails and best practices for:
- Feature development workflows
- Quality gates and verification
- Evidence-based completion
- Testing strategies
- Security considerations
- Pre-commit/merge/deployment checklists

## Core Philosophy

**Production Quality Over Speed**:
- Evidence-based completion (prove it works)
- Test-driven development
- Security by default
- Documented decisions
- Maintainable code structure

**Interactive Development**:
- Ask questions before coding
- Understand requirements thoroughly
- Validate assumptions
- Plan before implementing

## Development Workflows

### Feature Development Workflow

**Phase 1: Planning**
1. **Understand Requirements**
   - Ask clarifying questions
   - Identify acceptance criteria
   - Understand user impact
   - Check for existing patterns

2. **Design Approach**
   - Consider 3+ alternatives
   - Evaluate trade-offs
   - Plan file structure
   - Identify integration points

3. **Security Review**
   - Authentication/authorization needs
   - Data protection requirements
   - Input validation strategy
   - Potential vulnerabilities

**Phase 2: Implementation**
1. **Write Tests First** (TDD)
   - Unit tests for business logic
   - Integration tests for APIs
   - E2E tests for critical flows

2. **Implement in Small Increments**
   - Keep files under 250 LOC
   - One responsibility per module
   - Clear, self-documenting code
   - Comprehensive error handling

3. **Continuous Verification**
   - Tests pass after each change
   - No compilation errors
   - Code follows team patterns
   - Documentation stays current

**Phase 3: Completion**
1. **Evidence-Based Verification**
   - All tests passing (show output)
   - Feature works as specified (demonstrate)
   - Integration verified (prove it)
   - No regressions (test evidence)

2. **Documentation**
   - Update relevant docs
   - Add code comments where needed
   - Create/update ADR if significant
   - Document any trade-offs

3. **Checklist Completion**
   - Run pre-commit checklist
   - Verify all quality gates
   - Get code review if needed
   - Create completion report

## Quality Gates

### NEVER Mark Complete Without

**1. Working Code Evidence**:
```markdown
✅ Tests passing:
  - Unit tests: 15/15 passed
  - Integration tests: 8/8 passed
  - Output: [paste test output]

✅ Feature demonstrated:
  - Tested endpoint: POST /api/users
  - Response: 201 Created
  - Evidence: [paste response]

✅ Integration verified:
  - Tested with auth system
  - Tested with database
  - No side effects observed
```

**2. No Regressions**:
- Existing tests still pass
- No new compilation errors
- Performance not degraded
- Backward compatibility maintained

**3. Code Quality**:
- Follows established patterns
- Files under 250 LOC target
- Clear naming and structure
- Error handling comprehensive
- Security considerations addressed

**4. Documentation Current**:
- README updated if needed
- API docs reflect changes
- Comments explain "why" not "what"
- ADR created if significant decision

## Checklists

### Pre-Feature Start

See [Checklist](../../checklists/pre-feature-start.md) for full details.

**Quick Check**:
- [ ] Requirements clearly understood
- [ ] Design approach planned
- [ ] Test strategy defined
- [ ] Security considerations identified
- [ ] File structure planned

### Pre-Commit

See [Checklist](../../checklists/pre-commit.md) for full details.

**Quick Check**:
- [ ] All tests passing
- [ ] No compilation errors
- [ ] Code follows team standards
- [ ] Security review completed
- [ ] Documentation updated

### Pre-Merge

See [Checklist](../../checklists/pre-merge.md) for full details.

**Quick Check**:
- [ ] Code reviewed
- [ ] Integration tests passing
- [ ] No merge conflicts
- [ ] CI/CD pipeline green
- [ ] Migration scripts ready (if needed)

### Security Review

See [Checklist](../../checklists/security-review.md) for full details.

**Quick Check**:
- [ ] Input validation implemented
- [ ] Authentication/authorization correct
- [ ] Sensitive data protected
- [ ] SQL injection prevented
- [ ] XSS prevention in place

### Go-Live

See [Checklist](../../checklists/go-live.md) for full details.

**Quick Check**:
- [ ] All environments tested
- [ ] Rollback plan documented
- [ ] Monitoring configured
- [ ] Documentation complete
- [ ] Team notified

## Testing Strategy

### Test-Driven Development (TDD)

**Why TDD?**
- Clarifies requirements before coding
- Ensures testability from start
- Provides immediate feedback
- Prevents regressions
- Documents expected behavior

**TDD Cycle**:
1. **Red**: Write failing test
2. **Green**: Write minimal code to pass
3. **Refactor**: Improve code while keeping tests green

**Example**:
```typescript
// 1. RED - Write failing test
describe('UserService', () => {
  it('should create user with valid data', async () => {
    const service = new UserService();
    const result = await service.createUser({
      email: 'test@example.com',
      name: 'Test User'
    });

    expect(result.success).toBe(true);
    expect(result.user.email).toBe('test@example.com');
  });
});

// 2. GREEN - Implement minimal solution
class UserService {
  async createUser(data: CreateUserDto) {
    // Minimal implementation to pass test
    const user = await db.user.create({ data });
    return { success: true, user };
  }
}

// 3. REFACTOR - Add validation, error handling
class UserService {
  async createUser(data: CreateUserDto) {
    // Validate input
    if (!this.isValidEmail(data.email)) {
      return { success: false, error: 'Invalid email' };
    }

    // Handle errors
    try {
      const user = await db.user.create({ data });
      return { success: true, user };
    } catch (error) {
      logger.error('Failed to create user', { error });
      return { success: false, error: 'Creation failed' };
    }
  }
}
```

### Testing Pyramid

**Unit Tests** (70%):
- Test business logic in isolation
- Fast, deterministic
- Mock external dependencies
- Run on every save

**Integration Tests** (20%):
- Test component interactions
- Real database (test instance)
- Real external services (mocked)
- Run on commit

**E2E Tests** (10%):
- Test complete user workflows
- Real browser
- Real backend
- Run on merge/deploy

### Test Coverage Standards

**Minimum Coverage**:
- Overall: 80%
- Critical paths: 100%
- Business logic: 95%
- Utility functions: 90%

**What to Test**:
- ✅ Business logic
- ✅ Error handling
- ✅ Edge cases
- ✅ Integration points
- ✅ Security validations

**What NOT to Test**:
- ❌ Third-party libraries
- ❌ Framework internals
- ❌ Trivial getters/setters
- ❌ Configuration files

## File Size Discipline

### Standards

**Target**: 200 lines of code
**Maximum**: 250 lines of code
**Action**: Refactor when approaching 250 LOC

**Why?**
- Easier to understand
- Simpler to test
- Reduces merge conflicts
- Encourages modularity
- Improves maintainability

See [File Size Discipline](../../templates/standards/file-size-discipline.md) for complete guidelines.

### Refactoring Triggers

**Immediate Refactoring** (250+ LOC):
- Extract functions
- Split into modules
- Create helper utilities
- Move to separate files

**Planned Refactoring** (200-250 LOC):
- Schedule refactoring task
- Document refactoring strategy
- Continue with awareness
- Refactor before adding more

## Security Best Practices

### Input Validation

**Always Validate**:
```typescript
// ✅ Good: Validate and sanitize
async function createUser(input: unknown) {
  const validated = UserSchema.parse(input); // Zod validation
  const sanitized = sanitizeHtml(validated.bio);
  // ... create user
}

// ❌ Bad: Trust user input
async function createUser(input: any) {
  const user = await db.create(input); // SQL injection risk
}
```

### Authentication & Authorization

**Check Both**:
```typescript
// ✅ Good: Verify identity and permissions
async function deletePost(userId: string, postId: string) {
  // Authentication
  const user = await authService.verifyToken();
  if (!user) throw new UnauthorizedError();

  // Authorization
  const post = await db.post.findUnique({ where: { id: postId } });
  if (post.authorId !== userId && !user.isAdmin) {
    throw new ForbiddenError();
  }

  await db.post.delete({ where: { id: postId } });
}
```

### Sensitive Data

**Never Log or Expose**:
```typescript
// ✅ Good: Sanitize before logging
logger.info('User login attempt', {
  email: user.email,
  // password: NEVER log passwords
});

// ❌ Bad: Log sensitive data
logger.info('Login', { email, password }); // NEVER!
```

## Error Handling

### Comprehensive Error Handling

**Pattern**:
```typescript
// ✅ Good: Handle all error cases
async function fetchUserData(userId: string) {
  try {
    // Validate input
    if (!userId) {
      return { success: false, error: 'User ID required' };
    }

    // Attempt operation
    const user = await db.user.findUnique({
      where: { id: userId }
    });

    // Handle not found
    if (!user) {
      return { success: false, error: 'User not found' };
    }

    return { success: true, data: user };

  } catch (error) {
    // Log error with context
    logger.error('Failed to fetch user', {
      userId,
      error: error.message,
      stack: error.stack
    });

    // Return user-friendly error
    return {
      success: false,
      error: 'Failed to fetch user data'
    };
  }
}
```

### Error Response Structure

**Consistent Format**:
```typescript
interface ErrorResponse {
  success: false;
  error: string;        // User-friendly message
  code?: string;        // Machine-readable code
  details?: unknown;    // Additional context (dev only)
}

interface SuccessResponse<T> {
  success: true;
  data: T;
}
```

## Code Review Guidelines

### What to Look For

**Architecture**:
- [ ] Appropriate design patterns used
- [ ] Clear separation of concerns
- [ ] Scalability considered
- [ ] File organization logical

**Code Quality**:
- [ ] Readable and maintainable
- [ ] DRY (Don't Repeat Yourself)
- [ ] SOLID principles followed
- [ ] Files under 250 LOC

**Testing**:
- [ ] Adequate test coverage
- [ ] Tests are meaningful
- [ ] Edge cases tested
- [ ] Integration tested

**Security**:
- [ ] Input validated
- [ ] Auth/authz correct
- [ ] No sensitive data exposed
- [ ] SQL injection prevented

**Documentation**:
- [ ] Code is self-documenting
- [ ] Complex logic explained
- [ ] API docs updated
- [ ] README current

## Documentation Standards

### Code Comments

**When to Comment**:
- Complex algorithms
- Non-obvious decisions
- Workarounds for bugs
- Performance optimizations

**What to Explain**:
- **Why**, not what (code shows what)
- Business rules
- Assumptions
- Edge cases

**Example**:
```typescript
// ✅ Good: Explains WHY
// Cache expires after 5 minutes to balance freshness with API rate limits
const CACHE_TTL = 5 * 60 * 1000;

// ❌ Bad: States the obvious
// Set cache TTL to 5 minutes
const CACHE_TTL = 5 * 60 * 1000;
```

### Architecture Decision Records (ADRs)

**When to Create ADR**:
- Technology choices
- Architectural patterns
- Major refactoring decisions
- Breaking changes

See [ADR Template](../../templates/adr-template.md)

## Performance Considerations

### Query Optimization

**Database Best Practices**:
```typescript
// ✅ Good: Select only needed fields
const users = await db.user.findMany({
  select: { id: true, email: true, name: true },
  where: { active: true },
  take: 20
});

// ❌ Bad: Select everything
const users = await db.user.findMany(); // Could be millions of records
```

### Caching Strategy

**What to Cache**:
- Expensive computations
- Frequently accessed data
- Third-party API responses
- Static content

**Cache Invalidation**:
- Time-based (TTL)
- Event-based (on update)
- Manual (when needed)

## Completion Report Template

See [Completion Report Template](../../templates/completion-report-template.md) for full format.

**Essential Elements**:
```markdown
## Task Completed: [Feature Name]

### Deliverables
- [x] Feature X implemented
- [x] Tests written and passing
- [x] Documentation updated

### Evidence
**Tests Passing**:
[Paste test output]

**Feature Working**:
[Describe how you verified]

### Quality Gates
- [x] No compilation errors
- [x] All tests passing (15/15)
- [x] Code follows patterns
- [x] Security review completed
- [x] Files under 250 LOC

### Integration
- Integrates with: [components]
- Tested scenarios: [list]
- No regressions found

### Next Steps
[Any follow-up tasks if applicable]
```

## Resources

### Detailed Guides

- [Testing Strategies](resources/testing-strategies.md) - Comprehensive testing guide
- [Security Practices](resources/security-practices.md) - Security deep dive
- [Code Quality](resources/code-quality.md) - Maintainability patterns
- [Performance](resources/performance.md) - Optimization techniques

### Related Checklists

All checklists available in `.claude/checklists/`:
- pre-feature-start.md
- pre-commit.md
- pre-merge.md
- security-review.md
- go-live.md

### Templates

All templates available in `.claude/templates/`:
- completion-report-template.md
- adr-template.md
- feature-spec-template.md
- bug-report-template.md

## Quick Reference

### Common Patterns

**Result Pattern**:
```typescript
type Result<T> =
  | { success: true; data: T }
  | { success: false; error: string };
```

**Error Handling**:
```typescript
try {
  // operation
  return { success: true, data: result };
} catch (error) {
  logger.error('Operation failed', { error });
  return { success: false, error: 'Operation failed' };
}
```

**Validation**:
```typescript
const validated = Schema.parse(input); // Throws if invalid
```

### Remember

1. **Evidence-Based Completion**: Prove it works
2. **Test First**: Write tests before code
3. **Security By Default**: Always validate input
4. **Keep Files Small**: Under 250 LOC
5. **Ask Questions**: Understand before coding
6. **Document Decisions**: Especially significant ones
7. **Quality Over Speed**: Production quality always

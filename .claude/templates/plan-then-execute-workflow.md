# Plan-Then-Execute Workflow

A highly autonomous development workflow where you plan interactively, then let agents execute completely until ready for your review.

## Overview

**Traditional Workflow**: User → Agent asks → User approves → Agent acts → Agent asks again → ...

**Plan-Then-Execute**: User → Interactive Planning → User approves plan → **Agents execute autonomously until complete** → User reviews deliverable

## Quick Setup

### 1. Copy Settings Configuration

```bash
# Copy the example settings
cp .claude/_template/templates/settings.local.json.example .claude/settings.local.json

# Add to .gitignore (if not already there)
echo ".claude/settings.local.json" >> .gitignore
```

### 2. Update Your `.claude/claude.md`

Add this section to your project's `.claude/claude.md`:

```markdown
## Agent Autonomy Mode: Plan-Then-Execute

**Workflow**: Interactive planning phase → Approval → Autonomous execution → Final review

### Planning Phase (Interactive)
During planning, agents will:
- ✅ Ask clarifying questions about requirements
- ✅ Propose multiple architectural approaches
- ✅ Discuss trade-offs and alternatives
- ✅ Present detailed implementation plan
- ✅ Wait for your approval before proceeding

### Execution Phase (Autonomous)
Once plan is approved, agents will autonomously:
- ✅ Read all relevant files completely
- ✅ Write and edit any files needed
- ✅ Run tests, linters, formatters
- ✅ Execute database read operations
- ✅ Run build and dev commands
- ✅ Make git commits to feature branches
- ✅ Coordinate between multiple agents
- ✅ Verify completion with evidence
- ❌ No interruptions or approval requests

### What Still Requires Approval
- ❌ Pushing to main/master/develop branches
- ❌ Installing new dependencies (npm install, pip install)
- ❌ Production database operations
- ❌ Destructive operations (DROP, DELETE, rm -rf)
- ❌ Force pushes or git resets

### Agent Instructions
1. **Start with planning**: Present a comprehensive plan before implementation
2. **Get explicit approval**: Wait for "approved" or "go ahead" signal
3. **Execute autonomously**: Once approved, work continuously without asking
4. **Coordinate internally**: Use orchestrator for multi-agent tasks
5. **Deliver complete work**: Present finished, tested, working functionality
```

## Usage Examples

### Example 1: New Feature Development

```
User: "I need to add user profile editing with avatar upload"

Claude (Planning Phase):
"Let me plan this feature implementation.

FEATURE ANALYSIS:
- User profile editing form
- Image upload with validation
- Backend API for profile updates
- Database schema updates
- Security considerations (auth, file validation)

PROPOSED APPROACH:
1. Database: Add avatar_url column to users table
2. Backend: Create PUT /api/users/:id/profile endpoint
3. Backend: Add file upload handler with validation
4. Frontend: Build ProfileEditForm component
5. Frontend: Add ImageUpload component
6. Testing: Add unit and integration tests

ARCHITECTURE DECISIONS:
- Store images in cloud storage (S3/Cloudinary)
- Use signed URLs for secure uploads
- Validate file types (jpg, png, webp only)
- Limit file size to 5MB
- Compress images on upload

FILE SIZE PLAN:
- ProfileEditForm.tsx: ~150 LOC
- ImageUpload.tsx: ~120 LOC
- profileController.ts: ~180 LOC
- All within limits

TESTING STRATEGY:
- Unit tests for file validation
- Integration tests for profile update flow
- E2E test for complete user journey

Should I proceed with this plan?"

User: "Yes, go ahead"

Claude (Execution Phase - No interruptions):
*Reads all relevant files*
*Creates database migration*
*Implements backend endpoints*
*Writes tests and verifies they pass*
*Creates frontend components*
*Runs linters and formatters*
*Makes git commits*
*Runs full test suite*
*Verifies integration*

Claude: "Feature complete! Here's what was delivered:

✅ DATABASE:
- Migration: 001_add_avatar_to_users.sql
- Added avatar_url column

✅ BACKEND:
- PUT /api/users/:id/profile (file: profileController.ts, 175 LOC)
- File upload validation middleware
- S3 integration for storage
- Tests passing: 12/12

✅ FRONTEND:
- ProfileEditForm component (145 LOC)
- ImageUpload component (118 LOC)
- Integration with existing UserProfile page
- Tests passing: 8/8

✅ VERIFICATION:
- All tests passing (94% coverage)
- Linter: 0 errors
- Build: successful
- Manual testing: profile editing works, image uploads to S3

📦 COMMITS:
- feat(db): add avatar support to users table
- feat(api): add profile update endpoint with file upload
- feat(ui): add profile editing with avatar upload
- test: add profile editing test coverage

Ready for your review. Branch: feature/profile-editing"
```

### Example 2: Bug Fix with Investigation

```
User: "Users are reporting that the checkout page crashes when applying discount codes"

Claude (Planning Phase):
"Let me investigate and plan the fix.

INVESTIGATION PLAN:
1. Read checkout page component and discount logic
2. Check error logs for stack traces
3. Review discount validation code
4. Identify root cause
5. Plan fix with tests

Should I proceed with investigation?"

User: "Yes"

Claude (Execution - Autonomous Investigation):
*Reads CheckoutPage.tsx*
*Reads discountService.ts*
*Checks application logs*
*Runs checkout flow in test mode*
*Identifies null pointer exception*

Claude (Back to Planning):
"Investigation complete. Here's what I found:

ROOT CAUSE:
- discountService.ts:87 - discount.expiresAt.getTime() throws error
- Some discounts in database have null expiresAt
- Code assumes expiresAt is always present

FIX PLAN:
1. Add null check in discount validation
2. Database: Set default expiresAt for existing discounts
3. Add validation to discount creation
4. Add regression test for null expiresAt case
5. Add error boundary to prevent crash

AFFECTED FILES:
- services/discountService.ts (add null check)
- pages/CheckoutPage.tsx (add error boundary)
- tests/discount.test.ts (add regression test)

Should I proceed with the fix?"

User: "Approved"

Claude (Execution - No interruptions):
*Implements fix in discountService.ts*
*Adds error boundary*
*Updates database records*
*Writes regression tests*
*Runs full test suite*
*Verifies checkout flow works*
*Makes git commits*

Claude: "Bug fix complete!

✅ FIX IMPLEMENTED:
- Added null check for discount.expiresAt
- Error boundary prevents page crash
- Database updated: 47 discounts fixed

✅ TESTING:
- Added regression test for null expiresAt
- All 156 tests passing
- Manually verified checkout with various discount codes

✅ FILES MODIFIED:
- services/discountService.ts: 165 LOC (was 158)
- pages/CheckoutPage.tsx: 203 LOC (was 198)
- tests/discount.test.ts: 89 LOC (was 76)

📦 COMMITS:
- fix(checkout): handle null discount expiration dates
- test: add regression test for discount edge cases

Bug fixed and verified. Branch: bugfix/discount-crash"
```

### Example 3: Complex Multi-Agent Feature

```
User: "Build a real-time notification system with WebSocket support"

Claude (Planning - Orchestrator):
"This is a complex multi-domain feature. Let me coordinate the specialists.

ORCHESTRATION PLAN:
I'll coordinate: Architect, Backend, Frontend, Database, DevOps, QA

IMPLEMENTATION PHASES:
1. Architecture: Design WebSocket architecture
2. Database: Notification schema and indexes
3. Backend: WebSocket server + REST API
4. Frontend: Real-time notification UI
5. DevOps: WebSocket deployment config
6. QA: Integration and load testing

Each specialist will work autonomously once we begin.

Should I proceed with full autonomous implementation?"

User: "Go for it"

Claude (Autonomous Multi-Agent Execution):

[Architect Agent]
*Designs WebSocket architecture*
*Creates ADR for notification system*
*Plans message queue integration*

[Database Engineer]
*Creates notifications table*
*Adds indexes for user queries*
*Sets up message queue tables*

[Backend Agent]
*Implements WebSocket server*
*Creates notification REST endpoints*
*Adds authentication middleware*
*Integrates with Socket.io*

[Frontend Agent]
*Builds NotificationCenter component*
*Adds WebSocket connection hook*
*Implements toast notifications*
*Adds notification badge*

[DevOps Agent]
*Updates docker-compose.yml*
*Adds Redis for pub/sub*
*Configures WebSocket load balancing*

[QA Agent]
*Writes integration tests*
*Creates load test scenarios*
*Verifies real-time delivery*
*Tests reconnection logic*

Claude (Final Report):
"Real-time notification system complete!

✅ ARCHITECTURE:
- ADR created: 003-websocket-notification-system.md
- WebSocket server with Socket.io
- Redis pub/sub for scaling
- JWT authentication

✅ DATABASE:
- notifications table with user_id index
- message_queue for reliable delivery
- Migration: 005_create_notifications.sql

✅ BACKEND (3 files, all under limits):
- websocketServer.ts: 198 LOC
- notificationController.ts: 167 LOC
- notificationService.ts: 189 LOC
- Tests: 24/24 passing

✅ FRONTEND (4 components, all under limits):
- NotificationCenter.tsx: 145 LOC
- useNotifications.ts: 98 LOC
- NotificationToast.tsx: 67 LOC
- NotificationBadge.tsx: 43 LOC
- Tests: 18/18 passing

✅ INFRASTRUCTURE:
- Docker: Added Redis container
- Nginx: WebSocket proxy config
- Environment: WEBSOCKET_PORT=3001

✅ TESTING:
- Unit tests: 42/42 passing
- Integration tests: 12/12 passing
- Load test: 1000 concurrent connections stable
- Reconnection: Tested and working

✅ VERIFICATION:
- Real-time delivery: <100ms latency
- Reconnection: Automatic within 5s
- Message persistence: Working
- Multi-tab support: Working

📦 COMMITS (8 total):
- docs(adr): add WebSocket notification system design
- feat(db): create notifications schema
- feat(api): implement WebSocket server
- feat(api): add notification REST endpoints
- feat(ui): build notification center
- feat(ui): add real-time toast notifications
- ops(docker): add Redis for pub/sub
- test: comprehensive notification testing

System ready for production deployment!
Branch: feature/realtime-notifications"
```

## Configuration Details

### File Operations

```json
{
  "permissions": {
    "allow": [
      "Read(*)",      // Read any file
      "Write(*)",     // Write any file
      "Edit(*)",      // Edit any file
      "Glob(*)",      // Find files
      "Grep(*)"       // Search files
    ]
  }
}
```

**Why unrestricted?**
- Agents need to explore codebase freely
- File size discipline in agent training prevents bloat
- Reading protocols ensure thorough analysis
- Version control provides safety net

### Test Execution

```json
{
  "permissions": {
    "allow": [
      "Bash(npm test:*)",
      "Bash(npm run test:*)",
      "Bash(jest:*)",
      "Bash(pytest:*)",
      "Bash(playwright:*)"
    ]
  }
}
```

**Tests run automatically:**
- Unit tests after implementation
- Integration tests before completion
- E2E tests for user flows
- No need to ask permission

### Database Operations

```json
{
  "permissions": {
    "allow": [
      // Safe read operations
      "Bash(psql:*)",
      "Bash(mysql:*)",

      // Write to dev/test databases
      "Bash(psql -d test_db:*)",
      "Bash(psql -d dev_db:*)",
      "Bash(npm run db:migrate:*)"
    ],
    "deny": [
      // Production databases
      "Bash(psql -d production:*)",

      // Destructive operations
      "Bash(*DROP DATABASE*)",
      "Bash(*DROP TABLE*)",
      "Bash(*DELETE FROM users*)"
    ]
  }
}
```

**Safety through naming:**
- Development databases: `dev_db`, `test_db`, `local_db`
- Production databases: `production`, `prod`, `prod_db`
- Agents can freely query and migrate dev/test
- Production requires explicit approval

## Best Practices

### 1. Clear Planning Phase Boundaries

```
✅ GOOD:
User: "Build feature X"
Agent: [Presents comprehensive plan]
User: "Approved" or "Go ahead" or "Yes, proceed"
Agent: [Executes completely]

❌ BAD:
User: "Build feature X"
Agent: [Starts coding immediately without plan]
```

### 2. Explicit Approval Signal

Use clear language for approval:
- "Approved"
- "Go ahead"
- "Proceed"
- "Yes, do it"
- "Looks good, implement it"

Avoid ambiguous signals:
- "OK" (could mean "I understand" not "proceed")
- "Sounds good" (acknowledgment, not approval)

### 3. Plan Completeness

Ensure plans include:
- ✅ What will be built
- ✅ How it will be architected
- ✅ Which files will be modified/created
- ✅ File size estimates
- ✅ Testing strategy
- ✅ Security considerations
- ❌ Implementation details (those come during execution)

### 4. Scope Management

```
✅ GOOD - Well-scoped:
"Add user profile editing"

❌ BAD - Too vague:
"Improve the user experience"

✅ GOOD - Clear boundaries:
"Fix the checkout crash when applying invalid discount codes"

❌ BAD - Open-ended:
"Make the app better"
```

### 5. Review Expectations

After autonomous execution, review:
- [ ] Functionality works as specified
- [ ] Tests are passing
- [ ] Code follows standards
- [ ] File sizes are within limits
- [ ] Security considerations addressed
- [ ] Git commits are clean
- [ ] Documentation updated

## Troubleshooting

### Problem: Agent keeps asking for approval during execution

**Cause**: Plan wasn't explicit enough or agent interpreted something as needing approval

**Fix**:
1. Be more explicit in planning phase
2. Add to your `.claude/claude.md`:
   ```markdown
   IMPORTANT: During execution phase, proceed autonomously without asking
   unless encountering:
   - Ambiguous requirements
   - Security concerns
   - Production system access
   ```

### Problem: Agent stops mid-execution

**Cause**: Hit a permission that requires asking

**Fix**:
1. Check what command triggered the pause
2. Add to `permissions.allow` in settings.local.json
3. Or clarify in plan that agent should skip that step

### Problem: Too many git commits

**Cause**: Agent commits after every small change

**Fix**: Add to `.claude/claude.md`:
```markdown
**Git Commit Strategy**:
- Commit logical units of work
- One commit per component or feature
- Group related changes together
- Not per-file commits
```

### Problem: Tests fail and agent stops

**Cause**: Agent considers failing tests a blocker

**Fix**: This is correct behavior! Agent should:
1. Fix the test failures
2. Continue once tests pass
3. Not proceed with broken tests

## Advanced: Custom Permission Patterns

### Allow Specific Database Schemas

```json
{
  "allow": [
    "Bash(psql -d dev_db -c 'SELECT*)",
    "Bash(psql -d dev_db -c 'INSERT*)",
    "Bash(psql -d dev_db -c 'UPDATE*)"
  ],
  "deny": [
    "Bash(psql -d dev_db -c '*DELETE*)",
    "Bash(psql -d dev_db -c '*DROP*)"
  ]
}
```

### Allow Scripts in Specific Directories

```json
{
  "allow": [
    "Bash(node scripts/test-*)",
    "Bash(node scripts/seed-*)",
    "Bash(python scripts/analyze-*)"
  ],
  "deny": [
    "Bash(node scripts/deploy-*)",
    "Bash(python scripts/migrate-prod-*)"
  ]
}
```

### Environment-Specific Permissions

```json
{
  "allow": [
    "Bash(*NODE_ENV=development*)",
    "Bash(*NODE_ENV=test*)"
  ],
  "deny": [
    "Bash(*NODE_ENV=production*)"
  ]
}
```

## Example `.claude/claude.md` Section

```markdown
## Development Workflow: Plan-Then-Execute

### Phase 1: Planning (Interactive)
When starting any task:
1. Analyze requirements and ask clarifying questions
2. Propose comprehensive implementation plan including:
   - Architecture approach
   - Files to modify/create with LOC estimates
   - Testing strategy
   - Security considerations
3. **Wait for explicit approval** ("approved", "go ahead", "proceed")

### Phase 2: Execution (Autonomous)
Once approved:
- Work continuously without interruption
- Read all relevant files completely
- Implement with file size discipline
- Write and run tests
- Verify integration
- Make clean git commits
- Use orchestrator for multi-domain features
- **No asking for approval unless:**
  - Ambiguous requirements discovered
  - Security concerns arise
  - Need to access production systems

### Phase 3: Delivery (Interactive)
Present completed work with:
- Evidence of functionality (test output, screenshots)
- File size compliance report
- Test coverage results
- Integration verification
- Git commits summary
- Known limitations or future improvements

### Auto-Approved Operations
During execution phase, automatically proceed with:
- ✅ Reading any project files
- ✅ Writing/editing any project files
- ✅ Running tests, linters, formatters
- ✅ Running builds and dev servers
- ✅ SELECT queries on dev/test databases
- ✅ INSERT/UPDATE on dev/test databases
- ✅ Database migrations on dev/test
- ✅ Git commits to feature branches
- ✅ Installing packages listed in package.json (npm install without arguments)

### Requires Approval
- ❌ Pushing to main/master/develop branches
- ❌ Adding new dependencies (npm install <package>)
- ❌ Any production database operations
- ❌ Destructive operations (DROP, DELETE cascades, rm -rf)
- ❌ Force git operations
```

## Summary

**Plan-Then-Execute workflow = Maximum velocity with safety**

- 📋 Plan interactively → Get aligned on approach
- 🚀 Execute autonomously → No interruptions
- ✅ Deliver with evidence → Confidence in quality
- 🔒 Safety guardrails → Prevent disasters
- 🤝 Review at end → Your final approval matters

Start with planning, approve the plan, then let the agents work their magic!

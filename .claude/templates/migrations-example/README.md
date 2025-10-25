# Database Migrations Example Structure

This directory contains example migration files to demonstrate best practices.

## Directory Structure

Copy this structure to your project:

```
/migrations/
├── 001_initial_schema.sql
├── 002_add_users_table.sql
├── 003_add_sessions_table.sql
├── README.md
```

## Migration Naming Convention

**Format**: `NNN_descriptive_name.sql`

- `NNN`: Sequential number (001, 002, 003, etc.)
- `descriptive_name`: Brief description with underscores
- `.sql`: SQL file extension

**Examples**:
- ✅ `001_initial_schema.sql`
- ✅ `002_add_users_table.sql`
- ✅ `015_add_index_to_posts.sql`
- ❌ `add-users.sql` (no number)
- ❌ `2_users.sql` (not zero-padded)

## Migration Best Practices

### 1. Never Modify Existing Migrations
Once a migration is deployed, **never modify it**. Always create a new migration to fix issues.

```bash
# ❌ WRONG: Edit 002_add_users_table.sql after it's deployed

# ✅ CORRECT: Create new migration
003_fix_users_table_constraints.sql
```

### 2. Each Migration Should Be Atomic
One migration should do one logical change:

```sql
-- ✅ GOOD: Single purpose
-- 005_add_email_index.sql
CREATE INDEX idx_users_email ON users(email);

-- ❌ BAD: Multiple unrelated changes in one file
-- Creates confusion about what changed and when
CREATE INDEX idx_users_email ON users(email);
ALTER TABLE posts ADD COLUMN featured BOOLEAN;
CREATE TABLE categories (...);
```

### 3. Include Rollback Instructions
Always document how to rollback:

```sql
-- Migration: 005_add_email_index.sql
-- Description: Add index on users.email for faster lookups
-- Rollback: DROP INDEX idx_users_email;

CREATE INDEX idx_users_email ON users(email);
```

### 4. Test Migrations Before Deploying

```bash
# Test against copy of production data
pg_dump production_db > test_db_backup.sql
psql test_db < test_db_backup.sql
psql test_db < migrations/005_add_email_index.sql

# Check performance impact
EXPLAIN ANALYZE SELECT * FROM users WHERE email = 'test@example.com';
```

### 5. Handle Large Tables Carefully

```sql
-- For large tables, create indexes concurrently (PostgreSQL)
CREATE INDEX CONCURRENTLY idx_posts_created_at ON posts(created_at);

-- Add columns with DEFAULT in two steps to avoid table locks
-- Step 1: Add column without default
ALTER TABLE posts ADD COLUMN view_count INTEGER;

-- Step 2: Set default (can be in same migration)
ALTER TABLE posts ALTER COLUMN view_count SET DEFAULT 0;

-- Step 3: Backfill in batches (if needed)
UPDATE posts SET view_count = 0 WHERE view_count IS NULL;
```

### 6. Use Transactions

```sql
-- Most migration tools handle this, but if writing raw SQL:
BEGIN;

-- Your migration here
CREATE TABLE new_table (...);
CREATE INDEX idx_new_table ON new_table(column);

COMMIT;
-- If anything fails, entire migration rolls back
```

## Migration Workflow

### Development
```bash
# 1. Create new migration file
touch migrations/$(printf "%03d" $(($(ls migrations/*.sql | wc -l) + 1)))_description.sql

# 2. Write migration
vim migrations/NNN_description.sql

# 3. Test locally
[your migration command]

# 4. Verify schema matches expectations
psql -d mydb -c "\d users"  # Describe table

# 5. Commit migration
git add migrations/NNN_description.sql
git commit -m "Add migration: description"
```

### Production Deployment
```bash
# 1. Backup database first!
pg_dump production_db > backup_$(date +%Y%m%d_%H%M%S).sql

# 2. Run migration
[your migration command]

# 3. Verify success
[check migration status]

# 4. Monitor for issues
[check application logs and database performance]

# 5. If issues, rollback
# (This is why we documented rollback steps!)
```

## Migration Tools

Choose one for your project:

### Flyway (Java/SQL)
```bash
flyway migrate
flyway info
flyway repair  # Fix migration history
```

### Liquibase (Java/SQL/XML/YAML)
```bash
liquibase update
liquibase rollback
```

### Alembic (Python)
```bash
alembic upgrade head
alembic downgrade -1
alembic revision --autogenerate -m "description"
```

### Prisma (Node.js/TypeScript)
```bash
npx prisma migrate dev --name description
npx prisma migrate deploy
```

### golang-migrate (Go)
```bash
migrate -path migrations -database $DATABASE_URL up
migrate -path migrations -database $DATABASE_URL down 1
```

### Custom SQL Scripts
```bash
# Simple approach for small projects
for f in migrations/*.sql; do
  psql $DATABASE_URL < $f
done
```

## Common Issues

### Migration Already Applied
```bash
# Most tools track which migrations have run
# Check migration status first
[your tool's status command]
```

### Migration Failed Mid-Way
```bash
# If not using transactions, database may be in inconsistent state
# 1. Check what partially applied
# 2. Manually fix inconsistencies
# 3. Mark migration as failed
# 4. Create fix migration
```

### Need to Hotfix Production
```bash
# 1. Create emergency migration
migrations/NNN_hotfix_critical_issue.sql

# 2. Test thoroughly (even under time pressure!)
# 3. Deploy to production
# 4. Document in ADR why hotfix was needed
# 5. Post-mortem to prevent future issues
```

## Template Files

See example migration files in this directory:
- [001_initial_schema.sql](001_initial_schema.sql)
- [002_add_users_table.sql](002_add_users_table.sql)
- [003_add_sessions_table.sql](003_add_sessions_table.sql)

## Resources

- [PostgreSQL Migration Best Practices](https://www.postgresql.org/docs/current/ddl-alter.html)
- [Zero-Downtime Migrations](https://blog.example.com/zero-downtime-migrations)
- [Database Version Control](https://www.liquibase.org/get-started/best-practices)

---

**Remember**: Migrations are a permanent record of your database evolution. Treat them with care!

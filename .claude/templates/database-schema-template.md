# Database Schema

**Database Type**: [PostgreSQL 15 / MySQL 8 / MongoDB 6 / etc.]

**Last Updated**: [Date]

**Migration Status**: [Current migration number/version]

---

## Quick Reference for AI Agents

**ALWAYS consult this file before writing database queries to avoid syntax errors.**

### Connection
- **Environment Variable**: `DATABASE_URL`
- **Never hardcode** connection strings in code

### Database-Specific Syntax

#### PostgreSQL Example:
```sql
-- Parameterized queries
SELECT * FROM users WHERE id = $1 AND email = $2;

-- Arrays
INSERT INTO tags (name, categories) VALUES ('example', ARRAY['cat1', 'cat2']);

-- JSONB
UPDATE settings SET metadata = metadata || '{"key": "value"}'::jsonb;

-- RETURNING clause
INSERT INTO users (name, email) VALUES ($1, $2) RETURNING id, created_at;
```

#### MySQL Example:
```sql
-- Parameterized queries
SELECT * FROM users WHERE id = ? AND email = ?;

-- JSON
UPDATE settings SET metadata = JSON_SET(metadata, '$.key', 'value');
```

#### MongoDB Example:
```javascript
// Find with filter
db.users.findOne({ _id: ObjectId("...") });

// Update with operators
db.users.updateOne({ _id: id }, { $set: { status: 'active' } });
```

---

## Schema Overview

### Tables/Collections

#### `users`
**Purpose**: User accounts and authentication

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | UUID | PRIMARY KEY | Unique user identifier |
| email | VARCHAR(255) | UNIQUE, NOT NULL | User email address |
| password_hash | VARCHAR(255) | NOT NULL | Bcrypt hashed password |
| created_at | TIMESTAMP | NOT NULL, DEFAULT NOW() | Account creation time |
| updated_at | TIMESTAMP | NOT NULL, DEFAULT NOW() | Last update time |

**Indexes**:
- `idx_users_email` on `email` (unique)
- `idx_users_created_at` on `created_at`

**Relations**:
- Has many `sessions`
- Has many `posts`

---

#### `sessions`
**Purpose**: User authentication sessions

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | UUID | PRIMARY KEY | Session identifier |
| user_id | UUID | FOREIGN KEY users(id) | Associated user |
| token | VARCHAR(255) | UNIQUE, NOT NULL | Session token |
| expires_at | TIMESTAMP | NOT NULL | Expiration time |
| created_at | TIMESTAMP | NOT NULL, DEFAULT NOW() | Session creation |

**Indexes**:
- `idx_sessions_token` on `token` (unique)
- `idx_sessions_user_id` on `user_id`
- `idx_sessions_expires_at` on `expires_at`

**Relations**:
- Belongs to `users`

---

#### `posts`
**Purpose**: User-generated content

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | UUID | PRIMARY KEY | Post identifier |
| user_id | UUID | FOREIGN KEY users(id) | Author |
| title | VARCHAR(255) | NOT NULL | Post title |
| content | TEXT | NOT NULL | Post content |
| metadata | JSONB | DEFAULT '{}' | Flexible metadata |
| published | BOOLEAN | DEFAULT false | Publication status |
| created_at | TIMESTAMP | NOT NULL, DEFAULT NOW() | Creation time |
| updated_at | TIMESTAMP | NOT NULL, DEFAULT NOW() | Last update |

**Indexes**:
- `idx_posts_user_id` on `user_id`
- `idx_posts_created_at` on `created_at DESC`
- `idx_posts_published` on `published` WHERE published = true
- `idx_posts_metadata` on `metadata` using GIN (for JSONB queries)

**Relations**:
- Belongs to `users`
- Has many `comments`

---

## Common Query Patterns

### Pagination
```sql
-- Cursor-based pagination (recommended for large datasets)
SELECT * FROM posts
WHERE created_at < $1  -- cursor value
ORDER BY created_at DESC
LIMIT 20;

-- Offset pagination (simpler but slower for large offsets)
SELECT * FROM posts
ORDER BY created_at DESC
LIMIT 20 OFFSET $1;
```

### Full-text Search (PostgreSQL)
```sql
-- Using tsvector
SELECT * FROM posts
WHERE to_tsvector('english', title || ' ' || content) @@ to_tsquery('search & terms');
```

### JSONB Queries (PostgreSQL)
```sql
-- Query JSONB field
SELECT * FROM posts WHERE metadata @> '{"featured": true}';

-- Extract JSONB value
SELECT metadata->>'author' FROM posts;
```

---

## Performance Considerations

### N+1 Query Prevention
```sql
-- Bad: Will cause N+1 queries in application code
SELECT * FROM posts;
-- Then for each post: SELECT * FROM users WHERE id = $1;

-- Good: Use JOIN
SELECT posts.*, users.name, users.email
FROM posts
JOIN users ON posts.user_id = users.id;
```

### Missing Indexes Warning
If you notice slow queries, check for missing indexes:
```sql
-- PostgreSQL: Find queries without index usage
SELECT * FROM pg_stat_statements
ORDER BY total_time DESC
LIMIT 10;
```

---

## Migration History

| Version | Description | Date | Notes |
|---------|-------------|------|-------|
| 001 | Initial schema | 2025-01-15 | Users, sessions, posts |
| 002 | Add comments table | 2025-02-01 | User comments on posts |
| 003 | Add metadata JSONB | 2025-02-15 | Flexible post metadata |

**Migration Files Location**: `/migrations/` or `[your path]`

---

## Schema Maintenance

### Updating This File
1. After each migration, update this file
2. Update the "Last Updated" date
3. Update the "Migration Status"
4. Document any new indexes, constraints, or relations

### Generating Schema Documentation
```bash
# PostgreSQL - Generate schema.sql
pg_dump --schema-only $DATABASE_URL > docs/project/architecture/database-schema.sql

# Or use your ORM's schema export
# Prisma: npx prisma db pull && npx prisma generate
# TypeORM: npm run typeorm schema:log
```

### Schema Validation
- Run tests against schema before merging migrations
- Check for missing indexes on foreign keys
- Ensure proper constraints (NOT NULL, UNIQUE, etc.)

---

## Common Pitfalls (For AI Agents)

### PostgreSQL
- ❌ `WHERE id = 'uuid-string'` → ✅ `WHERE id = $1::uuid`
- ❌ `['val1', 'val2']` → ✅ `ARRAY['val1', 'val2']`
- ❌ Concatenating user input in queries → ✅ Use parameterized queries
- ❌ Forgetting `RETURNING` clause → ✅ Always use `RETURNING *` or specific columns

### MySQL
- ❌ Using PostgreSQL array syntax → ✅ Use JSON arrays or separate tables
- ❌ `RETURNING` clause (not supported) → ✅ Use `SELECT LAST_INSERT_ID()`

### General
- ❌ Modifying existing migrations → ✅ Always create new migrations
- ❌ Missing indexes on foreign keys → ✅ Always index foreign key columns
- ❌ Exposing raw database errors to users → ✅ Handle errors gracefully

---

## Resources

- **Database Documentation**: [Link to official docs]
- **ORM Documentation**: [Link to ORM docs]
- **Migration Tool**: [Link to migration tool docs]
- **Team Runbook**: [Link to internal runbook]

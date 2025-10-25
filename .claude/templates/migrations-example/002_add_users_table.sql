-- Migration: 002_add_users_table.sql
-- Description: Create users table for authentication
-- Author: [Your Name]
-- Date: 2025-01-15
-- Rollback: DROP TABLE IF EXISTS users;

BEGIN;

-- ============================================================================
-- USERS TABLE
-- ============================================================================

CREATE TABLE users (
    -- Primary key
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    -- Authentication
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,

    -- Profile
    username VARCHAR(50) UNIQUE,
    full_name VARCHAR(255),

    -- Status
    is_active BOOLEAN DEFAULT true,
    is_verified BOOLEAN DEFAULT false,

    -- Metadata (flexible data storage)
    metadata JSONB DEFAULT '{}',

    -- Timestamps
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
    last_login_at TIMESTAMP,

    -- Constraints
    CONSTRAINT email_format CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    CONSTRAINT username_format CHECK (username ~* '^[A-Za-z0-9_-]{3,50}$')
);


-- ============================================================================
-- INDEXES
-- ============================================================================

-- Email lookup (most common query)
CREATE INDEX idx_users_email ON users(email);

-- Username lookup
CREATE INDEX idx_users_username ON users(username);

-- Active users filter
CREATE INDEX idx_users_is_active ON users(is_active) WHERE is_active = true;

-- Recent users (for admin dashboards)
CREATE INDEX idx_users_created_at ON users(created_at DESC);

-- JSONB metadata queries (GIN index for JSONB)
CREATE INDEX idx_users_metadata ON users USING GIN(metadata);


-- ============================================================================
-- TRIGGERS
-- ============================================================================

-- Auto-update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();


-- ============================================================================
-- COMMENTS (for documentation)
-- ============================================================================

COMMENT ON TABLE users IS 'User accounts and authentication data';
COMMENT ON COLUMN users.email IS 'User email address (unique, used for login)';
COMMENT ON COLUMN users.password_hash IS 'Bcrypt hashed password (never store plaintext!)';
COMMENT ON COLUMN users.metadata IS 'Flexible JSONB field for user preferences, settings, etc.';

COMMIT;

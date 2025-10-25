-- Migration: 003_add_sessions_table.sql
-- Description: Create sessions table for user authentication sessions
-- Author: [Your Name]
-- Date: 2025-01-16
-- Rollback: DROP TABLE IF EXISTS sessions;

BEGIN;

-- ============================================================================
-- SESSIONS TABLE
-- ============================================================================

CREATE TABLE sessions (
    -- Primary key
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    -- Foreign key to users
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,

    -- Session token (store hashed in production!)
    token VARCHAR(255) NOT NULL UNIQUE,

    -- Session metadata
    ip_address INET,
    user_agent TEXT,

    -- Expiration
    expires_at TIMESTAMP NOT NULL,

    -- Timestamps
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    last_accessed_at TIMESTAMP NOT NULL DEFAULT NOW(),

    -- Constraints
    CONSTRAINT expires_at_future CHECK (expires_at > created_at)
);


-- ============================================================================
-- INDEXES
-- ============================================================================

-- Token lookup (most common query for auth)
CREATE UNIQUE INDEX idx_sessions_token ON sessions(token);

-- User's sessions lookup
CREATE INDEX idx_sessions_user_id ON sessions(user_id);

-- Cleanup expired sessions (for background job)
CREATE INDEX idx_sessions_expires_at ON sessions(expires_at);

-- Active sessions (for admin dashboards)
CREATE INDEX idx_sessions_active ON sessions(expires_at) WHERE expires_at > NOW();


-- ============================================================================
-- TRIGGERS
-- ============================================================================

-- Auto-update last_accessed_at on any update
CREATE TRIGGER update_sessions_last_accessed
    BEFORE UPDATE ON sessions
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();  -- Reuse existing function


-- ============================================================================
-- COMMENTS
-- ============================================================================

COMMENT ON TABLE sessions IS 'User authentication sessions';
COMMENT ON COLUMN sessions.token IS 'Session token (should be hashed in production)';
COMMENT ON COLUMN sessions.expires_at IS 'Session expiration time (cleanup old sessions regularly)';
COMMENT ON COLUMN sessions.ip_address IS 'IP address for security monitoring';

COMMIT;


-- ============================================================================
-- CLEANUP JOB (Run separately as a scheduled task)
-- ============================================================================

-- Example cleanup query (run via cron or scheduled job):
-- DELETE FROM sessions WHERE expires_at < NOW();

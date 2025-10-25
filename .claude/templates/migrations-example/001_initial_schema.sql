-- Migration: 001_initial_schema.sql
-- Description: Create initial database schema with extensions and basic structure
-- Author: [Your Name]
-- Date: 2025-01-15
-- Rollback: DROP EXTENSION IF EXISTS "uuid-ossp"; DROP SCHEMA public CASCADE; CREATE SCHEMA public;

-- ============================================================================
-- EXTENSIONS
-- ============================================================================

-- UUID support for PostgreSQL
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Optional: pg_trgm for fuzzy text search
-- CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- Optional: pgcrypto for additional crypto functions
-- CREATE EXTENSION IF NOT EXISTS pgcrypto;


-- ============================================================================
-- ENUMS (if using PostgreSQL)
-- ============================================================================

-- Example: User role enum
-- CREATE TYPE user_role AS ENUM ('admin', 'user', 'guest');


-- ============================================================================
-- INITIAL SETUP COMPLETE
-- ============================================================================

-- Note: Actual tables will be added in subsequent migrations
-- This keeps the initial migration simple and focused on setup

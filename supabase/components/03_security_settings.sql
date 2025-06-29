-- =============================================================================
-- SUPABASE SECURITY SETTINGS
-- =============================================================================
-- This file configures security-related settings for Supabase database roles.
-- These settings help prevent abuse and ensure good performance characteristics.
--
-- IMPORTANT: These settings are applied at the role level and affect all 
-- connections using these roles. Adjust timeout values based on your 
-- application's needs.
-- =============================================================================

-- -----------------------------------------------------------------------------
-- STATEMENT TIMEOUT CONFIGURATION
-- -----------------------------------------------------------------------------
-- Set maximum execution time for SQL statements to prevent long-running queries
-- from consuming excessive resources or causing performance issues.

-- ANONYMOUS ROLE TIMEOUT: 3 seconds
-- Restrictive timeout for unauthenticated users to prevent abuse
-- Suitable for simple queries like public data fetches, user registration
ALTER ROLE anon SET statement_timeout = '3s';

-- AUTHENTICATED ROLE TIMEOUT: 8 seconds  
-- More generous timeout for logged-in users who may perform complex operations
-- Suitable for user dashboard queries, data modifications, reports
ALTER ROLE authenticated SET statement_timeout = '8s';

-- -----------------------------------------------------------------------------
-- ADDITIONAL SECURITY CONSIDERATIONS
-- -----------------------------------------------------------------------------
-- The following are examples of additional security settings you might consider:

-- Uncomment and adjust these settings based on your security requirements:

-- Limit idle time in transactions (prevents hanging transactions)
-- ALTER ROLE anon SET idle_in_transaction_session_timeout = '10s';
-- ALTER ROLE authenticated SET idle_in_transaction_session_timeout = '30s';

-- Limit memory usage per query (prevents memory exhaustion attacks)
-- ALTER ROLE anon SET work_mem = '4MB';
-- ALTER ROLE authenticated SET work_mem = '16MB';

-- Disable certain potentially dangerous functions for specific roles
-- (Example: prevent anon users from accessing file system functions)
-- REVOKE EXECUTE ON FUNCTION pg_read_file(text) FROM anon;

-- Set row security policies (RLS) - enable this on tables for fine-grained access control
-- (This should be done per table as needed)
-- ALTER TABLE your_table_name ENABLE ROW LEVEL SECURITY;

-- -----------------------------------------------------------------------------
-- MONITORING AND LOGGING
-- -----------------------------------------------------------------------------
-- Consider enabling these for production environments:

-- Log all statements that take longer than specified time
-- ALTER ROLE anon SET log_min_duration_statement = '1000'; -- 1 second
-- ALTER ROLE authenticated SET log_min_duration_statement = '2000'; -- 2 seconds

-- -----------------------------------------------------------------------------
-- NOTES FOR PRODUCTION
-- -----------------------------------------------------------------------------
-- 1. Review and tighten these timeout values based on your application's needs
-- 2. Consider implementing Row Level Security (RLS) on sensitive tables
-- 3. Regular monitoring of slow queries and resource usage
-- 4. Implement proper error handling in your application for timeout scenarios 
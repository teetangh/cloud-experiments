-- =============================================================================
-- SUPABASE DATABASE SETUP SCRIPT (LIMITED PERMISSIONS)
-- =============================================================================
-- This version works when you don't have superuser privileges.
-- Use this in Supabase SQL Editor or when you can't create extensions.
--
-- IMPORTANT: Run this in your Supabase project database, NOT the postgres database!
--
-- What this script does:
-- 1. Sets up permissions on existing schemas (no schema creation)
-- 2. Configures role permissions for current objects
-- 3. Sets up default privileges for future objects
-- 4. Applies security settings
-- =============================================================================

-- 🚀 Starting Supabase Database Setup (Limited Permissions)...

-- -----------------------------------------------------------------------------
-- STEP 1: SCHEMA PERMISSIONS (No Creation)
-- -----------------------------------------------------------------------------
-- 📋 Step 1/3: Setting up permissions on existing schemas...

-- Grant usage on public schema (should already exist)
GRANT USAGE ON SCHEMA public TO postgres, anon, authenticated, service_role;

-- Note: Extensions and auth schemas are typically already set up by Supabase

-- ✅ Schema permissions configured!

-- -----------------------------------------------------------------------------
-- STEP 2: ROLE PERMISSIONS
-- -----------------------------------------------------------------------------
-- 🔐 Step 2/3: Configuring role permissions...

-- Current object permissions
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public 
    TO postgres, anon, authenticated, service_role;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public 
    TO postgres, anon, authenticated, service_role;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public 
    TO postgres, anon, authenticated, service_role;

-- Default privileges for future objects
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
    GRANT ALL ON TABLES TO postgres, anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
    GRANT ALL ON FUNCTIONS TO postgres, anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
    GRANT ALL ON SEQUENCES TO postgres, anon, authenticated, service_role;

-- ✅ Role permissions configured!

-- -----------------------------------------------------------------------------
-- STEP 3: SECURITY SETTINGS
-- -----------------------------------------------------------------------------
-- 🛡️ Step 3/3: Applying security settings...

-- Statement timeouts (may require elevated permissions)
-- If these fail, you can comment them out - they're optional
-- Uncomment the lines below if you have permission to modify roles:

-- ALTER ROLE anon SET statement_timeout = '3s';
-- ALTER ROLE authenticated SET statement_timeout = '8s';

-- If the above lines cause permission errors, that's normal for standard users

-- ✅ Security settings applied (or skipped if no permissions)!

-- -----------------------------------------------------------------------------
-- SETUP COMPLETE
-- -----------------------------------------------------------------------------
-- 🎉 Supabase database setup complete!
--
-- Next steps:
-- 1. Consider enabling Row Level Security (RLS) on your tables
-- 2. Create policies for data access control
-- 3. If timeout settings failed, ask your admin to apply them
-- 4. Monitor query performance and adjust as needed
--
-- For more information, see the README.md file. 
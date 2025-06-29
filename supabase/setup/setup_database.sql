-- =============================================================================
-- SUPABASE DATABASE MASTER SETUP SCRIPT
-- =============================================================================
-- This master script executes all Supabase database setup components in the
-- correct order. Run this single file to completely configure your database.
--
-- EXECUTION ORDER:
-- 1. Database initialization (schemas, extensions, paths)
-- 2. Role permissions and privileges  
-- 3. Security settings and configurations
--
-- USAGE:
--   Execute this file in your SQL client or Supabase SQL editor
-- =============================================================================

-- 🚀 Starting Supabase Database Setup...

-- -----------------------------------------------------------------------------
-- STEP 1: DATABASE INITIALIZATION
-- -----------------------------------------------------------------------------
-- 📋 Step 1/3: Setting up schemas and extensions...

-- Create schemas
CREATE SCHEMA IF NOT EXISTS "auth";
CREATE SCHEMA IF NOT EXISTS "extensions";

-- Install extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;
CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;
CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA extensions;

-- Configure search paths
ALTER USER supabase_admin SET search_path TO public, extensions;

-- ✅ Database initialization complete!

-- -----------------------------------------------------------------------------
-- STEP 2: ROLE PERMISSIONS
-- -----------------------------------------------------------------------------
-- 🔐 Step 2/3: Configuring role permissions...

-- Schema usage permissions
GRANT USAGE ON SCHEMA public TO postgres, anon, authenticated, service_role;
GRANT USAGE ON SCHEMA extensions TO postgres, anon, authenticated, service_role;

-- Current object permissions
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public 
    TO postgres, anon, authenticated, service_role, supabase_admin;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public 
    TO postgres, anon, authenticated, service_role, supabase_admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public 
    TO postgres, anon, authenticated, service_role, supabase_admin;

-- Default privileges for future objects
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
    GRANT ALL ON TABLES TO postgres, anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
    GRANT ALL ON FUNCTIONS TO postgres, anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
    GRANT ALL ON SEQUENCES TO postgres, anon, authenticated, service_role;

-- Supabase admin default privileges
ALTER DEFAULT PRIVILEGES FOR USER supabase_admin IN SCHEMA public 
    GRANT ALL ON SEQUENCES TO postgres, anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR USER supabase_admin IN SCHEMA public 
    GRANT ALL ON TABLES TO postgres, anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR USER supabase_admin IN SCHEMA public 
    GRANT ALL ON FUNCTIONS TO postgres, anon, authenticated, service_role;

-- ✅ Role permissions configured!

-- -----------------------------------------------------------------------------
-- STEP 3: SECURITY SETTINGS
-- -----------------------------------------------------------------------------
-- 🛡️ Step 3/3: Applying security settings...

-- Statement timeouts
ALTER ROLE anon SET statement_timeout = '3s';
ALTER ROLE authenticated SET statement_timeout = '8s';

-- ✅ Security settings applied!

-- -----------------------------------------------------------------------------
-- SETUP COMPLETE
-- -----------------------------------------------------------------------------
-- 🎉 Supabase database setup complete!
--
-- Next steps:
-- 1. Consider enabling Row Level Security (RLS) on your tables
-- 2. Create policies for data access control
-- 3. Review timeout settings for your use case
-- 4. Monitor query performance and adjust as needed
--
-- For more information, see the README.md file. 
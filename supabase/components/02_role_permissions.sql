-- =============================================================================
-- SUPABASE ROLE PERMISSIONS & PRIVILEGES
-- =============================================================================
-- This file configures permissions for all Supabase database roles.
-- 
-- SUPABASE ROLES EXPLAINED:
-- • postgres: Superuser role with full database access
-- • anon: Anonymous/public access (unauthenticated users)
-- • authenticated: Logged-in users
-- • service_role: Backend services and admin operations
-- • supabase_admin: Supabase platform administration
--
-- SECURITY NOTE: These permissions are quite permissive and suitable for
-- development. In production, consider more restrictive permissions based
-- on your security requirements.
-- =============================================================================

-- -----------------------------------------------------------------------------
-- SCHEMA USAGE PERMISSIONS
-- -----------------------------------------------------------------------------
-- Grant basic schema access to all roles

-- Public schema: Main application schema where your tables/functions live
-- All roles need usage access to interact with objects in this schema
GRANT USAGE ON SCHEMA public TO postgres, anon, authenticated, service_role;

-- Extensions schema: Allow access to installed extensions
-- This enables roles to use extension functions like uuid_generate_v4()
GRANT USAGE ON SCHEMA extensions TO postgres, anon, authenticated, service_role;

-- -----------------------------------------------------------------------------
-- CURRENT OBJECT PERMISSIONS
-- -----------------------------------------------------------------------------
-- Grant permissions on all existing objects in the public schema

-- TABLES: Grant full access to all existing tables
-- This allows all roles to SELECT, INSERT, UPDATE, DELETE on any table
-- WARNING: This is very permissive - consider row-level security (RLS) for data protection
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public 
    TO postgres, anon, authenticated, service_role, supabase_admin;

-- FUNCTIONS: Grant execution rights on all existing functions
-- This allows all roles to call any user-defined function in the public schema
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public 
    TO postgres, anon, authenticated, service_role, supabase_admin;

-- SEQUENCES: Grant usage and update rights on all existing sequences
-- This allows roles to use sequences for auto-incrementing columns
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public 
    TO postgres, anon, authenticated, service_role, supabase_admin;

-- -----------------------------------------------------------------------------
-- DEFAULT PRIVILEGES FOR FUTURE OBJECTS
-- -----------------------------------------------------------------------------
-- Set up automatic permissions for objects created in the future

-- Tables created by any user will automatically grant permissions to standard roles
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
    GRANT ALL ON TABLES TO postgres, anon, authenticated, service_role;

-- Functions created by any user will automatically grant permissions to standard roles  
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
    GRANT ALL ON FUNCTIONS TO postgres, anon, authenticated, service_role;

-- Sequences created by any user will automatically grant permissions to standard roles
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
    GRANT ALL ON SEQUENCES TO postgres, anon, authenticated, service_role;

-- -----------------------------------------------------------------------------
-- SUPABASE ADMIN DEFAULT PRIVILEGES
-- -----------------------------------------------------------------------------
-- Ensure objects created by supabase_admin are accessible to application roles

-- When supabase_admin creates sequences, grant access to application roles
ALTER DEFAULT PRIVILEGES FOR USER supabase_admin IN SCHEMA public 
    GRANT ALL ON SEQUENCES TO postgres, anon, authenticated, service_role;

-- When supabase_admin creates tables, grant access to application roles
ALTER DEFAULT PRIVILEGES FOR USER supabase_admin IN SCHEMA public 
    GRANT ALL ON TABLES TO postgres, anon, authenticated, service_role;

-- When supabase_admin creates functions, grant access to application roles
ALTER DEFAULT PRIVILEGES FOR USER supabase_admin IN SCHEMA public 
    GRANT ALL ON FUNCTIONS TO postgres, anon, authenticated, service_role; 
-- =============================================================================
-- EMERGENCY PERMISSION FIX FOR SUPABASE
-- =============================================================================
-- Use this script when you get "permission denied for schema public" errors.
-- This attempts to restore basic permissions that allow your app to function.
-- 
-- IMPORTANT: Run this as a user with sufficient privileges (like postgres role)
-- =============================================================================

-- Grant basic schema usage - this is often the root cause
DO $$
BEGIN
    -- Grant usage on public schema to all standard roles
    GRANT USAGE ON SCHEMA public TO anon;
    GRANT USAGE ON SCHEMA public TO authenticated;
    GRANT USAGE ON SCHEMA public TO service_role;
    
    RAISE NOTICE 'Schema usage permissions granted';
EXCEPTION WHEN insufficient_privilege THEN
    RAISE NOTICE 'Could not grant schema permissions - insufficient privileges';
END $$;

-- Grant permissions on all existing tables
DO $$
BEGIN
    -- For anon role (read-only typically)
    GRANT SELECT ON ALL TABLES IN SCHEMA public TO anon;
    
    -- For authenticated role (read/write)
    GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO authenticated;
    
    -- For service role (full access)
    GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO service_role;
    
    RAISE NOTICE 'Table permissions granted';
EXCEPTION WHEN insufficient_privilege THEN
    RAISE NOTICE 'Could not grant table permissions - insufficient privileges';
END $$;

-- Grant permissions on sequences (for auto-increment columns)
DO $$
BEGIN
    GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO  anon;
    GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA public TO authenticated;
    GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO service_role;
    
    RAISE NOTICE 'Sequence permissions granted';
EXCEPTION WHEN insufficient_privilege THEN
    RAISE NOTICE 'Could not grant sequence permissions - insufficient privileges';
END $$;

-- Grant permissions on functions
DO $$
BEGIN
    GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO anon;
    GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO authenticated;
    GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO service_role;
    
    RAISE NOTICE 'Function permissions granted';
EXCEPTION WHEN insufficient_privilege THEN
    RAISE NOTICE 'Could not grant function permissions - insufficient privileges';
END $$;

-- Set up default privileges for future objects
DO $$
BEGIN
    -- Tables
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO anon;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO authenticated;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO service_role;
    
    -- Sequences
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE, SELECT ON SEQUENCES TO anon;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE, SELECT, UPDATE ON SEQUENCES TO authenticated;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;
    
    -- Functions
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT EXECUTE ON FUNCTIONS TO anon;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT EXECUTE ON FUNCTIONS TO authenticated;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;
    
    RAISE NOTICE 'Default privileges set for future objects';
EXCEPTION WHEN insufficient_privilege THEN
    RAISE NOTICE 'Could not set default privileges - insufficient privileges';
END $$;

-- Check if we have any tables with RLS enabled but no policies
DO $$
DECLARE
    rec RECORD;
    policy_count INTEGER;
BEGIN
    FOR rec IN 
        SELECT tablename 
        FROM pg_tables t
        JOIN pg_class c ON c.relname = t.tablename
        WHERE t.schemaname = 'public' AND c.relrowsecurity = true
    LOOP
        SELECT COUNT(*) INTO policy_count
        FROM pg_policies 
        WHERE schemaname = 'public' AND tablename = rec.tablename;
        
        IF policy_count = 0 THEN
            RAISE NOTICE 'WARNING: Table % has RLS enabled but no policies! This will block all access.', rec.tablename;
            RAISE NOTICE 'Consider: ALTER TABLE % DISABLE ROW LEVEL SECURITY; -- or create policies', rec.tablename;
        END IF;
    END LOOP;
END $$;

-- Final verification
SELECT 
    'Permission fix completed. Check the notices above for any issues.' as status; 
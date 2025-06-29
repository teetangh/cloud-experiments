-- =============================================================================
-- SUPABASE PERMISSIONS DIAGNOSTIC SCRIPT
-- =============================================================================
-- This script helps diagnose permission issues in your Supabase database.
-- Run this to understand what's causing "permission denied for schema public" errors.
-- =============================================================================

-- Check current user and database
SELECT 
    'Current Database: ' || current_database() as info
UNION ALL
SELECT 
    'Current User: ' || current_user as info
UNION ALL
SELECT 
    'Session User: ' || session_user as info;

-- Check schema permissions
SELECT 
    'SCHEMA PERMISSIONS:' as section,
    '' as schema_name,
    '' as grantee,
    '' as privilege_type
UNION ALL
SELECT 
    '',
    nspname as schema_name,
    grantee::text,
    privilege_type
FROM information_schema.schema_privileges sp
JOIN pg_namespace n ON n.nspname = sp.schema_name
WHERE schema_name IN ('public', 'auth', 'extensions')
ORDER BY section DESC, schema_name, grantee;

-- Check if RLS is enabled on any tables
SELECT 
    'TABLES WITH RLS ENABLED:' as section,
    '' as table_name,
    '' as rls_enabled
UNION ALL
SELECT 
    '',
    tablename,
    CASE WHEN rowsecurity THEN 'YES' ELSE 'NO' END
FROM pg_tables t
JOIN pg_class c ON c.relname = t.tablename
WHERE schemaname = 'public'
ORDER BY section DESC, table_name;

-- Check table permissions for key roles
SELECT 
    'TABLE PERMISSIONS:' as section,
    '' as table_name,
    '' as grantee,
    '' as privilege_type
UNION ALL
SELECT 
    '',
    table_name,
    grantee::text,
    privilege_type
FROM information_schema.table_privileges
WHERE table_schema = 'public'
    AND grantee IN ('anon', 'authenticated', 'service_role', 'postgres')
ORDER BY section DESC, table_name, grantee;

-- Check if roles exist
SELECT 
    'AVAILABLE ROLES:' as section,
    '' as rolname
UNION ALL
SELECT 
    '',
    rolname::text
FROM pg_roles
WHERE rolname IN ('anon', 'authenticated', 'service_role', 'postgres', 'supabase_admin')
ORDER BY section DESC, rolname;

-- Check current role grants
SELECT 
    'CURRENT USER ROLE MEMBERSHIPS:' as section,
    '' as role_name
UNION ALL
SELECT 
    '',
    pg_get_userbyid(roleid)::text
FROM pg_auth_members
WHERE member = (SELECT oid FROM pg_roles WHERE rolname = current_user)
ORDER BY section DESC; 
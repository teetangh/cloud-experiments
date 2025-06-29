-- =============================================================================
-- SUPABASE DATABASE INITIALIZATION
-- =============================================================================
-- This file sets up the foundational database structure for a Supabase project
-- including schemas, extensions, and basic configuration.
--
-- Order of operations:
-- 1. Create necessary schemas
-- 2. Install required extensions  
-- 3. Configure search paths
--
-- Usage: Run this file first when setting up a new Supabase database
-- =============================================================================

-- -----------------------------------------------------------------------------
-- SCHEMA CREATION
-- -----------------------------------------------------------------------------
-- Create core schemas required by Supabase for authentication and extensions

-- Auth schema: Houses Supabase authentication tables and functions
-- This schema is managed by Supabase and contains user accounts, sessions, etc.
CREATE SCHEMA IF NOT EXISTS "auth";

-- Extensions schema: Contains PostgreSQL extensions to keep them organized
-- This prevents extension objects from cluttering the public schema
CREATE SCHEMA IF NOT EXISTS "extensions";

-- -----------------------------------------------------------------------------
-- EXTENSION INSTALLATION
-- -----------------------------------------------------------------------------
-- Install essential PostgreSQL extensions in the extensions schema

-- UUID-OSSP: Provides functions to generate universally unique identifiers (UUIDs)
-- Essential for creating unique primary keys and reference IDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;

-- PGCRYPTO: Provides cryptographic functions for password hashing, encryption
-- Used by Supabase auth system for secure password storage
CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;

-- PGJWT: Provides JSON Web Token (JWT) functions for authentication
-- Used by Supabase for token-based authentication and authorization
CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA extensions;

-- -----------------------------------------------------------------------------
-- SEARCH PATH CONFIGURATION
-- -----------------------------------------------------------------------------
-- Configure the search path for the supabase_admin user

-- Set search path to include public and extensions schemas
-- This allows the admin user to access extension functions without schema qualification
-- Note: We deliberately exclude the "auth" schema from the search path for security
ALTER USER supabase_admin SET search_path TO public, extensions; 
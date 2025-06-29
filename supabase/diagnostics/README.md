# Diagnostic Scripts

This folder contains troubleshooting and diagnostic tools for Supabase database permission issues.

## 📁 Files

### `diagnose_permissions.sql`
**Permission Diagnostic Tool**

**What it does:**
- Shows current user and database information
- Lists schema permissions for all roles
- Identifies tables with Row Level Security (RLS) enabled
- Displays table permissions for key roles
- Shows available roles and current user memberships

**When to use:**
- Getting "permission denied" errors
- Need to understand current permission state
- Before applying fixes
- Troubleshooting access issues

**Usage:**
```sql
-- In Supabase SQL Editor:
-- Copy and paste the entire contents of this file
-- Review the output to understand permission issues
```

---

### `fix_permissions_emergency.sql`
**Emergency Permission Fix**

**What it does:**
- Restores basic schema usage permissions
- Grants appropriate table/sequence/function permissions
- Sets up default privileges for future objects
- Identifies RLS-enabled tables without policies
- Uses error handling to work with limited privileges

**When to use:**
- After running diagnostic and finding permission issues
- Getting "permission denied for schema public" errors
- Need to quickly restore database access
- Emergency situations where app is broken

**Usage:**
```sql
-- In Supabase SQL Editor:
-- Copy and paste the entire contents of this file
-- Check the output messages for success/failure notices
```

## 🎯 Troubleshooting Workflow

### Step 1: Diagnose
```sql
-- Run this first to understand the problem:
-- Execute: diagnose_permissions.sql
```

Look for:
- ❌ Missing schema permissions
- ❌ Tables with RLS but no policies  
- ❌ Missing role permissions
- ❌ Incorrect user/database

### Step 2: Fix
```sql
-- Then apply the emergency fix:
-- Execute: fix_permissions_emergency.sql
```

Watch for:
- ✅ "permissions granted" messages
- ⚠️ "insufficient privileges" warnings
- ❌ Any error messages

### Step 3: Verify
```sql
-- Test your application or run diagnostic again
-- to confirm issues are resolved
```

## 🚨 Common Issues These Scripts Address

### "Permission denied for schema public"
**Cause:** Missing USAGE permission on public schema
**Fix:** Emergency script grants USAGE to all standard roles

### "Permission denied for table X"
**Cause:** Missing table-level permissions
**Fix:** Emergency script grants appropriate permissions per role

### RLS Blocking Access
**Cause:** Tables have RLS enabled but no policies defined
**Fix:** Diagnostic script identifies these tables, emergency script warns about them

### Missing Default Privileges
**Cause:** New objects don't inherit proper permissions
**Fix:** Emergency script sets up default privileges for future objects

## 📊 Understanding Diagnostic Output

### Schema Permissions Section
```sql
SCHEMA PERMISSIONS:
public     | anon          | USAGE
public     | authenticated | USAGE
```
- Should see USAGE for anon, authenticated, service_role

### Tables with RLS Section
```sql
TABLES WITH RLS ENABLED:
users      | YES
profiles   | YES
```
- RLS enabled tables need policies or they block all access

### Table Permissions Section
```sql
TABLE PERMISSIONS:
users      | anon          | SELECT
users      | authenticated | SELECT,INSERT,UPDATE,DELETE
```
- Shows what each role can do with each table

## 🔧 Emergency Fix Details

The emergency fix script uses this permission strategy:

### For `anon` role:
- **Schema**: USAGE
- **Tables**: SELECT (read-only)
- **Sequences**: USAGE, SELECT
- **Functions**: EXECUTE

### For `authenticated` role:
- **Schema**: USAGE
- **Tables**: SELECT, INSERT, UPDATE, DELETE
- **Sequences**: USAGE, SELECT, UPDATE
- **Functions**: EXECUTE

### For `service_role`:
- **Schema**: USAGE
- **Tables**: ALL PRIVILEGES
- **Sequences**: ALL PRIVILEGES
- **Functions**: ALL PRIVILEGES

## ⚠️ Important Notes

### These Scripts Are Safe
- Use error handling to prevent breaking your database
- Skip operations they don't have permission for
- Provide clear feedback about what succeeded/failed

### They Don't Fix Everything
- Can't create missing schemas (use setup scripts)
- Can't install extensions (requires admin)
- Can't create RLS policies (that's app-specific)

### They're Emergency Tools
- Designed for quick fixes, not comprehensive setup
- Use setup scripts for new databases
- Consider these as "first aid" for broken permissions

## 🔗 Related Files

- `../setup/` - For comprehensive database setup
- `../components/` - For individual permission components
- `../docs/` - For detailed documentation and guides

## 💡 Pro Tips

1. **Always diagnose first** - understand the problem before applying fixes
2. **Save diagnostic output** - helps with support requests
3. **Run emergency fix safely** - it won't break existing permissions
4. **Follow up with proper setup** - emergency fixes are temporary solutions 
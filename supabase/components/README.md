# Component Scripts

This folder contains individual numbered scripts that can be run separately for granular control over your Supabase database setup.

## 📁 Files (Run in Order)

### `01_database_initialization.sql`
**Database Foundation Setup**

**What it does:**
- Creates core schemas (`auth`, `extensions`)
- Installs essential PostgreSQL extensions
- Configures search paths

**Extensions installed:**
- `uuid-ossp` - UUID generation functions
- `pgcrypto` - Cryptographic functions
- `pgjwt` - JSON Web Token functions

**Requirements:** Admin/superuser privileges

---

### `02_role_permissions.sql`
**Role Permissions Configuration**

**What it does:**
- Grants schema usage permissions
- Sets permissions on existing tables, functions, sequences
- Configures default privileges for future objects
- Handles supabase_admin specific permissions

**Roles configured:**
- `postgres` - Superuser access
- `anon` - Anonymous/public access
- `authenticated` - Logged-in users
- `service_role` - Backend services
- `supabase_admin` - Platform administration

**Requirements:** Standard user privileges (usually works for everyone)

---

### `03_security_settings.sql`
**Security Configuration**

**What it does:**
- Sets statement timeouts (3s for anon, 8s for authenticated)
- Provides examples for additional security hardening
- Includes production security recommendations

**Requirements:** Role modification privileges (may require admin)

## 🎯 Usage Patterns

### Sequential Execution (Recommended)
Run all scripts in numbered order:
```sql
-- 1. First (requires admin privileges):
-- Run: 01_database_initialization.sql

-- 2. Second (works for most users):
-- Run: 02_role_permissions.sql

-- 3. Third (may require admin):
-- Run: 03_security_settings.sql
```

### Selective Execution
Run only the components you need:
```sql
-- Just permissions (most common need):
-- Run: 02_role_permissions.sql

-- Just security settings:
-- Run: 03_security_settings.sql
```

## 🚨 Handling Permission Errors

If you get permission errors:

1. **Skip problematic scripts**: Focus on what works for your privilege level
2. **Use diagnostics**: Run `../diagnostics/diagnose_permissions.sql`
3. **Apply fixes**: Use `../diagnostics/fix_permissions_emergency.sql`

## 📋 Component Details

### Database Initialization (01)
- **Safe to skip**: If schemas/extensions already exist
- **Critical for**: New databases or self-hosted PostgreSQL
- **Alternative**: Use `../setup/setup_database_limited.sql` instead

### Role Permissions (02)
- **Always important**: Core permissions for app functionality
- **Usually works**: Most users can run this successfully
- **Most critical**: This is the heart of Supabase permissions

### Security Settings (03)
- **Optional**: Timeouts are nice-to-have, not required
- **May fail**: Normal for standard users
- **Workaround**: Ask admin to apply timeout settings manually

## 🔄 Relationship to Setup Scripts

These components are the building blocks used by:
- `../setup/setup_database.sql` - Runs all three components
- `../setup/setup_database_limited.sql` - Runs modified versions with error handling

## 💡 Customization Tips

### Adjusting Timeouts (03_security_settings.sql)
```sql
-- Increase timeouts for your needs:
ALTER ROLE anon SET statement_timeout = '10s';
ALTER ROLE authenticated SET statement_timeout = '30s';
```

### Restricting Permissions (02_role_permissions.sql)
```sql
-- More restrictive permissions:
GRANT SELECT, INSERT ON ALL TABLES IN SCHEMA public TO authenticated;
-- Instead of: GRANT ALL PRIVILEGES
```

### Adding Extensions (01_database_initialization.sql)
```sql
-- Add your custom extensions:
CREATE EXTENSION IF NOT EXISTS "your_extension" WITH SCHEMA extensions;
```

## 🔗 Related Files

- `../setup/` - Pre-built combinations of these components
- `../diagnostics/` - Troubleshooting tools if components fail
- `../docs/` - Detailed documentation and guides 
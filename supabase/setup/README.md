# Setup Scripts

This folder contains the main database setup scripts for Supabase projects.

## 📁 Files

### `setup_database.sql`
**Complete Database Setup (Admin Privileges Required)**

- Creates schemas (`auth`, `extensions`)
- Installs PostgreSQL extensions
- Configures role permissions
- Sets security settings
- **Requirements**: Superuser or admin privileges

**Usage:**
```sql
-- In Supabase SQL Editor (as admin):
-- Copy and paste the entire contents of this file
```

### `setup_database_limited.sql`
**Limited Privileges Setup (Recommended for Most Users)**

- Works with standard Supabase user permissions
- Focuses on permissions and configurations you can control
- Skips schema/extension creation (assumes Supabase handles this)
- Gracefully handles permission limitations

**Usage:**
```sql
-- In Supabase SQL Editor:
-- Copy and paste the entire contents of this file
```

## 🎯 Which Script Should I Use?

### Use `setup_database_limited.sql` if:
- ✅ You're using Supabase's hosted service
- ✅ You're a standard user (not admin)
- ✅ You get permission errors with the full setup
- ✅ You want a safe, non-destructive setup

### Use `setup_database.sql` if:
- ✅ You have superuser/admin privileges
- ✅ You're setting up a self-hosted PostgreSQL instance
- ✅ You need to create schemas and extensions
- ✅ You want complete control over the setup

## 🚨 Common Issues

**Error: `permission denied for database postgres`**
- Switch to your Supabase project database
- Use `setup_database_limited.sql` instead

**Error: `must be owner of extension`**
- Use `setup_database_limited.sql` (extensions already installed by Supabase)

**Error: `permission denied to set role`**
- Normal for standard users - timeout settings are optional

## 🔄 What These Scripts Do

Both scripts perform these core functions:

1. **Schema Permissions**: Grant usage rights on public schema
2. **Role Permissions**: Configure permissions for anon, authenticated, service_role
3. **Default Privileges**: Set up automatic permissions for future objects
4. **Security Settings**: Apply timeout configurations (where possible)

The difference is that the full setup also:
- Creates schemas if they don't exist
- Installs PostgreSQL extensions
- Configures advanced admin settings

## 📋 Next Steps After Setup

1. **Test the Setup**: Try querying your database
2. **Enable RLS**: Consider Row Level Security for production
3. **Create Policies**: Define access policies for your tables
4. **Monitor Performance**: Review query performance and adjust timeouts

## 🔗 Related Files

- `../diagnostics/diagnose_permissions.sql` - If you have permission issues
- `../diagnostics/fix_permissions_emergency.sql` - Emergency permission fixes
- `../components/` - Individual component scripts for granular control 
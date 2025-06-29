# Supabase Database Management Scripts

This directory contains a comprehensive collection of SQL scripts for setting up, managing, and troubleshooting Supabase databases. The scripts are organized into logical folders for better maintainability and ease of use.

## 📁 Folder Structure

```
supabase/
├── README.md                    # This documentation
├── setup/                       # Main setup scripts
│   ├── setup_database.sql       # Complete setup (requires admin privileges)
│   └── setup_database_limited.sql # Setup for limited privileges
├── components/                  # Individual component scripts
│   ├── 01_database_initialization.sql
│   ├── 02_role_permissions.sql
│   └── 03_security_settings.sql
├── diagnostics/                 # Troubleshooting and diagnostic tools
│   ├── diagnose_permissions.sql
│   └── fix_permissions_emergency.sql
└── docs/                       # Documentation
    └── [detailed documentation files]
```

## 🚀 Quick Start

### For Most Users (Recommended)
```sql
-- Run this in your Supabase SQL Editor:
-- Copy and paste contents of: setup/setup_database_limited.sql
```

### For Database Administrators
```sql
-- If you have full admin privileges:
-- Copy and paste contents of: setup/setup_database.sql
```

### Having Permission Issues?
```sql
-- First diagnose the problem:
-- Run: diagnostics/diagnose_permissions.sql

-- Then apply the fix:
-- Run: diagnostics/fix_permissions_emergency.sql
```

## 📋 Folder Details

### 🛠️ **setup/**
Contains the main setup scripts for database initialization:
- **`setup_database.sql`** - Full setup requiring admin privileges
- **`setup_database_limited.sql`** - Setup for standard users with limited privileges

### 🔧 **components/**
Individual numbered scripts that can be run separately:
- **`01_database_initialization.sql`** - Schemas, extensions, basic configuration
- **`02_role_permissions.sql`** - Role permissions and privileges
- **`03_security_settings.sql`** - Security settings and timeouts

### 🔍 **diagnostics/**
Troubleshooting and repair tools:
- **`diagnose_permissions.sql`** - Diagnostic tool for permission issues
- **`fix_permissions_emergency.sql`** - Emergency fix for common permission errors

### 📚 **docs/**
Documentation and reference materials:
- Detailed setup guides
- Security best practices
- Troubleshooting guides

## ⚠️ Important Notes

### Database Selection
**ALWAYS run these scripts in your Supabase PROJECT database, NOT the default `postgres` database!**

### Permission Levels
- **Admin/Superuser**: Use scripts in `setup/`
- **Standard User**: Use `setup/setup_database_limited.sql`
- **Having Issues**: Use scripts in `diagnostics/`

## 🚨 Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| `permission denied for database postgres` | Switch to your project database + use limited setup |
| `permission denied for schema public` | Run diagnostic script, then emergency fix |
| `must be owner of extension` | Use limited setup (extensions already installed) |
| `permission denied to set role` | Normal for standard users, timeouts are optional |

## 🎯 Usage Patterns

### New Database Setup
1. Start with `setup/setup_database_limited.sql`
2. If you get errors, check `diagnostics/diagnose_permissions.sql`
3. Apply fixes with `diagnostics/fix_permissions_emergency.sql`

### Granular Control
1. Run `components/01_database_initialization.sql`
2. Run `components/02_role_permissions.sql`  
3. Run `components/03_security_settings.sql`

### Troubleshooting Existing Setup
1. Run `diagnostics/diagnose_permissions.sql`
2. Review the output to identify issues
3. Apply `diagnostics/fix_permissions_emergency.sql` if needed

## 🔐 Security Considerations

- **Development**: Current permissions are suitable for development environments
- **Production**: Consider implementing Row Level Security (RLS) policies
- **Monitoring**: Review timeout settings and query performance regularly

## 📚 Additional Resources

- [Supabase Documentation](https://supabase.io/docs)
- [PostgreSQL Role Management](https://www.postgresql.org/docs/current/user-manag.html)
- [Row Level Security Guide](https://supabase.io/docs/guides/auth/row-level-security)

---

**Need help?** Check the individual folder README files for detailed information about each script category. 
# Documentation

This folder contains detailed documentation and guides for the Supabase database management scripts.

## 📚 Available Documentation

### Quick Reference Guides
- **Setup Guide**: Step-by-step instructions for different setup scenarios
- **Troubleshooting Guide**: Common issues and their solutions
- **Security Best Practices**: Production security recommendations
- **Role Management Guide**: Understanding Supabase roles and permissions

### Script Reference
- **Component Scripts Reference**: Detailed explanation of each component script
- **Setup Scripts Reference**: When and how to use different setup scripts
- **Diagnostic Scripts Reference**: How to interpret diagnostic output

### Advanced Topics
- **Row Level Security (RLS)**: Implementing fine-grained access control
- **Custom Extensions**: Adding and managing PostgreSQL extensions
- **Performance Tuning**: Optimizing timeout settings and query performance
- **Migration Strategies**: Moving from development to production

## 🎯 Getting Started

If you're new to these scripts, start with:

1. **Main README**: `../README.md` - Overview and quick start
2. **Setup Folder**: `../setup/README.md` - Choose the right setup script
3. **Troubleshooting**: `../diagnostics/README.md` - If you encounter issues

## 🔍 Finding What You Need

### I want to...

**Set up a new database**
→ Check `../setup/README.md`

**Fix permission errors**
→ Check `../diagnostics/README.md`

**Understand individual components**
→ Check `../components/README.md`

**Learn about security**
→ See "Security Best Practices" section below

**Customize for production**
→ See "Production Configuration" section below

## 🛡️ Security Best Practices

### Development Environment
- Use permissive permissions for rapid development
- Focus on functionality over strict security
- Enable logging for debugging

### Production Environment
- **Enable Row Level Security (RLS)** on all user-facing tables
- **Create specific policies** rather than broad permissions
- **Monitor query performance** and set appropriate timeouts
- **Regular security audits** of permissions and access patterns

### Example RLS Setup
```sql
-- Enable RLS on user table
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Policy: Users can only see their own data
CREATE POLICY "Users can view own data" ON users
  FOR SELECT USING (auth.uid() = id);

-- Policy: Users can update their own data
CREATE POLICY "Users can update own data" ON users
  FOR UPDATE USING (auth.uid() = id);
```

## 🚀 Production Configuration

### Recommended Changes for Production

1. **Tighten Permissions**:
   ```sql
   -- Instead of ALL PRIVILEGES, use specific permissions:
   GRANT SELECT, INSERT, UPDATE ON specific_table TO authenticated;
   ```

2. **Adjust Timeouts**:
   ```sql
   -- Increase timeouts for production workloads:
   ALTER ROLE authenticated SET statement_timeout = '30s';
   ```

3. **Enable Monitoring**:
   ```sql
   -- Log slow queries:
   ALTER ROLE authenticated SET log_min_duration_statement = '1000';
   ```

4. **Implement RLS Policies**:
   - Enable RLS on sensitive tables
   - Create restrictive policies
   - Test policies thoroughly

## 🔧 Customization Examples

### Adding Custom Roles
```sql
-- Create a custom role for API access
CREATE ROLE api_user;
GRANT USAGE ON SCHEMA public TO api_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO api_user;
```

### Custom Extensions
```sql
-- Install additional extensions
CREATE EXTENSION IF NOT EXISTS "postgis" WITH SCHEMA extensions;
CREATE EXTENSION IF NOT EXISTS "pg_cron" WITH SCHEMA extensions;
```

### Environment-Specific Settings
```sql
-- Development: More permissive, longer timeouts
ALTER ROLE authenticated SET statement_timeout = '60s';

-- Production: Stricter, shorter timeouts
ALTER ROLE authenticated SET statement_timeout = '10s';
```

## 🎓 Learning Resources

### Supabase Official Documentation
- [Getting Started](https://supabase.io/docs)
- [Database Guide](https://supabase.io/docs/guides/database)
- [Auth Guide](https://supabase.io/docs/guides/auth)

### PostgreSQL Documentation
- [Role Management](https://www.postgresql.org/docs/current/user-manag.html)
- [Access Control](https://www.postgresql.org/docs/current/ddl-priv.html)
- [Row Security Policies](https://www.postgresql.org/docs/current/ddl-rowsecurity.html)

### Security Resources
- [OWASP Database Security](https://owasp.org/www-community/vulnerabilities/SQL_Injection)
- [PostgreSQL Security](https://www.postgresql.org/docs/current/security.html)

## 💡 Pro Tips

1. **Always test in development first** - Never run untested scripts in production
2. **Use version control** - Track changes to your database scripts
3. **Document your customizations** - Keep notes on what you've changed and why
4. **Regular backups** - Always have backups before making permission changes
5. **Monitor after changes** - Watch for performance impacts after permission updates

## 🤝 Contributing

Have improvements or additional documentation? Consider:
- Adding examples for common use cases
- Documenting edge cases you've encountered
- Sharing production configuration patterns
- Contributing troubleshooting scenarios

---

**Remember**: These scripts are tools to help you manage your Supabase database effectively. Always understand what each script does before running it, and customize them for your specific needs. 
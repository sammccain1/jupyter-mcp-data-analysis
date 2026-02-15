# MCP Configuration Template

## Basic Configuration

Copy this configuration to your AI IDE's MCP settings file:

```json
{
    "mcpServers": {
        "postgres": {
            "command": "npx",
            "args": [
                "-y",
                "@modelcontextprotocol/server-postgres",
                "postgresql://postgres:postgres@localhost:5432/customerdb"
            ]
        },
        "jupyter": {
            "command": "uvx",
            "args": [
                "mcp-server-jupyter"
            ],
            "env": {
                "JUPYTER_PATH": "/path/to/jupyter-mcp-data-analysis"
            }
        }
    }
}
```

## Customization

### Update These Values

1. **JUPYTER_PATH**: Replace `/path/to/jupyter-mcp-data-analysis` with your actual project directory
2. **Database name**: Change `customerdb` if using a different database
3. **Database credentials**: Update username/password if changed from defaults

### Connection String Format

```
postgresql://[username]:[password]@[host]:[port]/[database]
```

Example with custom credentials:
```
postgresql://myuser:mypassword@localhost:5432/mydb
```

## Security Notes

### ✅ Safe for Development (Current Setup)

- **Username**: `postgres` (default)
- **Password**: `postgres` (default)
- **Host**: `localhost` (only accessible from your machine)
- **Safe to commit**: Yes, for local development

These credentials are:
- Standard development defaults
- Only accessible on localhost
- Not exposed to the internet
- Safe for public GitHub repositories

### 🔒 For Production Deployment

If deploying to production, **you MUST**:

1. **Change database password** in `docker-compose.yml`:
   ```yaml
   environment:
     POSTGRES_PASSWORD: your_secure_password_here
   ```

2. **Use environment variables**:
   ```json
   {
     "postgres": {
       "command": "npx",
       "args": [
         "-y",
         "@modelcontextprotocol/server-postgres",
         "${DATABASE_URL}"
       ]
     }
   }
   ```

3. **Create read-only user** for MCP:
   ```sql
   CREATE USER mcp_readonly WITH PASSWORD 'secure_password';
   GRANT CONNECT ON DATABASE customerdb TO mcp_readonly;
   GRANT SELECT ON ALL TABLES IN SCHEMA public TO mcp_readonly;
   ```

4. **Enable SSL/TLS**:
   ```
   postgresql://user:pass@host:5432/db?sslmode=require
   ```

5. **Restrict by IP** in PostgreSQL's `pg_hba.conf`

6. **Never commit** production credentials to Git

## Additional Options

### Connection Parameters

Add parameters to the connection string:

```
postgresql://postgres:postgres@localhost:5432/customerdb?sslmode=disable&connect_timeout=10
```

Common parameters:
- `sslmode`: `disable`, `require`, `verify-ca`, `verify-full`
- `connect_timeout`: Connection timeout in seconds
- `application_name`: Name shown in PostgreSQL logs

### Multiple Databases

Configure multiple PostgreSQL MCP servers:

```json
{
  "mcpServers": {
    "postgres-customers": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-postgres",
        "postgresql://postgres:postgres@localhost:5432/customerdb"
      ]
    },
    "postgres-analytics": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-postgres",
        "postgresql://postgres:postgres@localhost:5432/analyticsdb"
      ]
    }
  }
}
```

## IDE-Specific Locations

### Antigravity
- Check Antigravity settings or documentation
- Common locations:
  - `~/.config/antigravity/mcp-config.json`
  - `~/Library/Application Support/Antigravity/mcp-config.json`

### Cursor
- Open Cursor Settings
- Navigate to MCP Servers section
- Add configuration there

### Claude Desktop
- Edit: `~/Library/Application Support/Claude/claude_desktop_config.json`
- Add under `mcpServers` key

## Resources

- **Detailed PostgreSQL MCP Guide**: [docs/POSTGRES_MCP.md](docs/POSTGRES_MCP.md)
- **General MCP Setup**: [docs/MCP_SETUP.md](docs/MCP_SETUP.md)
- **MCP Documentation**: https://modelcontextprotocol.io/
- **PostgreSQL MCP Server**: https://github.com/modelcontextprotocol/servers/tree/main/src/postgres

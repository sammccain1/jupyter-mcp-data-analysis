# PostgreSQL MCP Server Guide

## Overview

The PostgreSQL MCP (Model Context Protocol) server enables AI assistants to interact with your PostgreSQL database through natural language queries. This allows you to ask questions like "Show me all customers from the Northeast region" and have the AI generate and execute the appropriate SQL.

## What is MCP?

Model Context Protocol (MCP) is an open protocol that standardizes how AI applications interact with external data sources and tools. The PostgreSQL MCP server specifically allows AI assistants to:

- Query database tables
- Analyze data patterns
- Generate SQL queries from natural language
- Retrieve schema information
- Execute read operations safely

## Configuration

### Current Setup

The PostgreSQL MCP server is configured in [`mcp-config.json`](file:///path/to/jupyter-mcp-data-analysis/mcp-config.json):

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
    }
  }
}
```

### Connection String Breakdown

```
postgresql://[username]:[password]@[host]:[port]/[database]
```

- **Username**: `postgres` (default PostgreSQL user)
- **Password**: `postgres` (development-only password)
- **Host**: `localhost` (only accessible from your machine)
- **Port**: `5432` (default PostgreSQL port)
- **Database**: `customerdb` (our sample database)

## Installation

### Prerequisites

1. **Node.js and npm** - Required to run `npx`
   ```bash
   node --version  # Should be v14 or higher
   npm --version
   ```

2. **PostgreSQL Database** - Running via Docker
   ```bash
   docker ps | grep postgres
   ```

### No Installation Needed!

The PostgreSQL MCP server uses `npx`, which automatically downloads and runs the package on first use. The `-y` flag auto-confirms the installation.

## Usage with AI Assistants

### For Antigravity

1. Add the configuration from `mcp-config.json` to Antigravity's MCP settings
2. Restart Antigravity
3. The PostgreSQL MCP server will be available

### Example Queries

Once configured, you can ask your AI assistant:

**Data Retrieval**:
- "Show me all customers from the West region"
- "List the top 5 customers by total spending"
- "How many orders were placed in January 2024?"

**Analysis**:
- "What's the average order amount by product category?"
- "Which customer segment has the highest lifetime value?"
- "Show me revenue trends by month"

**Schema Information**:
- "What tables are in the database?"
- "Describe the customers table structure"
- "What are the foreign key relationships?"

## Security Considerations

### ⚠️ Development vs Production

**Current Setup (Development)**:
- ✅ Safe for local development
- ✅ Safe for public GitHub (localhost only)
- ✅ No external network access
- ❌ NOT suitable for production

**Why These Credentials Are Safe to Share**:
1. Database only accessible on `localhost` (your computer)
2. Docker container not exposed to the internet
3. Standard development credentials used in tutorials
4. No sensitive data in the sample database

### 🔒 For Production Use

If you deploy this to production, **you MUST**:

1. **Change the password**:
   ```bash
   # In docker-compose.yml
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

3. **Restrict database access**:
   - Use firewall rules
   - Limit connections by IP
   - Enable SSL/TLS
   - Use read-only database users for MCP

4. **Never commit** production credentials to Git

## Capabilities

### What the PostgreSQL MCP Can Do

✅ **Read Operations**:
- SELECT queries
- JOIN operations
- Aggregations (COUNT, SUM, AVG, etc.)
- Filtering and sorting
- Schema inspection

✅ **Safe Queries**:
- Read-only access (by default)
- Query result limiting
- Timeout protection

### What It Cannot Do (By Default)

❌ **Write Operations**:
- INSERT, UPDATE, DELETE (requires configuration)
- CREATE, DROP tables
- ALTER schema
- User management

This is a safety feature to prevent accidental data modification.

## Troubleshooting

### MCP Server Not Connecting

**Check Docker is running**:
```bash
docker ps | grep postgres
```

**Verify database is accessible**:
```bash
psql postgresql://postgres:postgres@localhost:5432/customerdb -c "SELECT 1;"
```

**Check npx is available**:
```bash
npx --version
```

### Connection Refused

**Ensure PostgreSQL is running**:
```bash
docker-compose up -d
```

**Check port 5432 is not blocked**:
```bash
lsof -i :5432
```

### Permission Denied

The default `postgres` user has full access. If you created a custom user, ensure they have SELECT permissions:

```sql
GRANT SELECT ON ALL TABLES IN SCHEMA public TO your_user;
```

## Advanced Configuration

### Custom Connection Options

You can add PostgreSQL connection parameters:

```json
{
  "postgres": {
    "command": "npx",
    "args": [
      "-y",
      "@modelcontextprotocol/server-postgres",
      "postgresql://postgres:postgres@localhost:5432/customerdb?sslmode=disable&connect_timeout=10"
    ]
  }
}
```

### Multiple Databases

You can configure multiple PostgreSQL MCP servers for different databases:

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

## Testing the Setup

### Manual Test

1. **Start PostgreSQL**:
   ```bash
   docker-compose up -d
   ```

2. **Test connection**:
   ```bash
   psql postgresql://postgres:postgres@localhost:5432/customerdb
   ```

3. **Run a query**:
   ```sql
   SELECT COUNT(*) FROM customers;
   ```

4. **Exit**:
   ```
   \q
   ```

### With AI Assistant

Ask your AI assistant:
- "Connect to the PostgreSQL database"
- "Show me the customers table"
- "How many customers do we have?"

## Resources

- **MCP Documentation**: https://modelcontextprotocol.io/
- **PostgreSQL MCP Server**: https://github.com/modelcontextprotocol/servers/tree/main/src/postgres
- **PostgreSQL Docs**: https://www.postgresql.org/docs/
- **Connection String Format**: https://www.postgresql.org/docs/current/libpq-connect.html#LIBPQ-CONNSTRING

## Best Practices

1. **Use read-only users** for MCP in production
2. **Enable query logging** to monitor AI-generated queries
3. **Set query timeouts** to prevent long-running queries
4. **Limit result set sizes** to avoid memory issues
5. **Review generated SQL** before executing in production
6. **Use connection pooling** for better performance
7. **Monitor database load** when using AI queries

## FAQ

**Q: Is it safe to have database credentials in the config file?**  
A: For local development with `localhost`, yes. For production, use environment variables.

**Q: Can the AI modify my data?**  
A: By default, no. The MCP server is read-only unless explicitly configured otherwise.

**Q: Do I need to install anything?**  
A: Just Node.js/npm. The MCP server downloads automatically via `npx`.

**Q: Can I use this with other databases?**  
A: Yes! There are MCP servers for MySQL, SQLite, and other databases.

**Q: Will this work with cloud databases?**  
A: Yes, just update the connection string to point to your cloud database (ensure proper security).

---

**Need help?** Check the [main MCP setup guide](MCP_SETUP.md) or open an issue on GitHub.

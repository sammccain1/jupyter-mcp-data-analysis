# MCP Server Setup Guide

This guide explains how to configure the MCP servers for use with Antigravity or other AI IDEs.

## What are MCP Servers?

Model Context Protocol (MCP) servers enable AI assistants to interact with external tools and data sources. In this project, we use two MCP servers:

1. **PostgreSQL MCP Server** - Allows AI to query the database
2. **Jupyter MCP Server** - Enables AI-assisted notebook development

## Configuration File

The `mcp-config.json` file contains the server configurations:

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
        "JUPYTER_PATH": "/Users/sammccain/DATA-MCP"
      }
    }
  }
}
```

## Setup Instructions

### For Antigravity

1. **Locate Antigravity's MCP Configuration**
   - The exact location may vary
   - Check Antigravity's settings or documentation
   - Common locations might include:
     - `~/.config/antigravity/mcp-config.json`
     - `~/Library/Application Support/Antigravity/mcp-config.json`

2. **Add Server Configurations**
   - Copy the contents of `mcp-config.json`
   - Merge with existing MCP configuration (if any)
   - Update the `JUPYTER_PATH` to match your project location

3. **Restart Antigravity**
   - Close and reopen Antigravity
   - The MCP servers should now be available

### For Cursor IDE

If using Cursor instead:

1. Open Cursor Settings
2. Navigate to MCP Servers section
3. Add the server configurations from `mcp-config.json`
4. Restart Cursor

### For Claude Desktop

If using Claude Desktop:

1. Edit `~/Library/Application Support/Claude/claude_desktop_config.json`
2. Add the server configurations under `mcpServers`
3. Restart Claude Desktop

## Prerequisites

### PostgreSQL MCP Server

Requires Node.js and npm (uses `npx` to run):
- No installation needed - `npx` downloads on first use
- Automatically connects to the Docker PostgreSQL instance

### Jupyter MCP Server

Already installed via pip:
```bash
python3 -m pip install mcp-server-jupyter --user
```

The server is located at: `/Users/sammccain/Library/Python/3.11/bin/mcp-server-jupyter`

## Testing the Setup

### Test PostgreSQL MCP

Once configured, you should be able to ask your AI assistant:
- "Query the customers table"
- "Show me the total revenue by product category"
- "How many customers are in each region?"

### Test Jupyter MCP

You should be able to ask:
- "Create a new Jupyter notebook"
- "Add a cell to analyze customer data"
- "Generate a visualization of order trends"

## Troubleshooting

### PostgreSQL MCP Not Working

1. **Check Docker is running**:
   ```bash
   docker ps | grep postgres
   ```

2. **Verify database connection**:
   ```bash
   psql postgresql://postgres:postgres@localhost:5432/customerdb -c "SELECT 1;"
   ```

3. **Check npx is available**:
   ```bash
   npx --version
   ```

### Jupyter MCP Not Working

1. **Verify installation**:
   ```bash
   python3 -c "import mcp_server_jupyter; print('✅ Installed')"
   ```

2. **Check PATH** (if using uvx):
   ```bash
   which uvx
   ```
   
   If not found, you may need to use the full path:
   ```json
   "command": "/Users/sammccain/Library/Python/3.11/bin/mcp-server-jupyter"
   ```

3. **Verify Jupyter is accessible**:
   ```bash
   jupyter --version
   ```

## Security Notes

⚠️ **Important**: The database credentials in this configuration are for development only:
- Username: `postgres`
- Password: `postgres`

For production use:
1. Change the database password
2. Update the connection string in `mcp-config.json`
3. Use environment variables for sensitive data
4. Restrict database access by IP/network

## Alternative: Manual MCP Server Usage

If you prefer not to configure MCP servers in your IDE, you can still use the project:

1. **Direct Database Access**:
   ```bash
   psql postgresql://postgres:postgres@localhost:5432/customerdb
   ```

2. **Jupyter Notebooks**:
   ```bash
   jupyter notebook
   ```
   Then open `customer_analysis.ipynb`

## Additional Resources

- [Model Context Protocol Documentation](https://modelcontextprotocol.io/)
- [PostgreSQL MCP Server](https://github.com/modelcontextprotocol/servers/tree/main/src/postgres)
- [Jupyter MCP Server](https://github.com/modelcontextprotocol/servers/tree/main/src/jupyter)

## Support

If you encounter issues:
1. Check the troubleshooting section above
2. Verify all prerequisites are installed
3. Review the MCP server logs (if available in your IDE)
4. Ensure Docker and PostgreSQL are running

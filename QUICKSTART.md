# Quick Reference Guide

## 🚀 Common Commands

### Start the Project
```bash
# Navigate to project
cd /path/to/jupyter-mcp-data-analysis

# Start PostgreSQL
docker-compose up -d

# Launch Jupyter
jupyter notebook
```

### Stop the Project
```bash
# Stop PostgreSQL
docker-compose down

# Stop PostgreSQL and remove data
docker-compose down -v
```

### Database Access
```bash
# Connect to database
docker exec -it jupyter-mcp-postgres psql -U postgres -d customerdb

# Run a quick query
docker exec jupyter-mcp-postgres psql -U postgres -d customerdb -c "SELECT COUNT(*) FROM customers;"

# View all customers
docker exec jupyter-mcp-postgres psql -U postgres -d customerdb -c "SELECT * FROM customers;"
```

### Check Status
```bash
# Check if PostgreSQL is running
docker ps | grep postgres

# Check Python packages
python3 -m pip list | grep -E "jupyter|pandas|matplotlib|psycopg2"

# Verify Jupyter installation
jupyter --version
```

## 📁 Important Files

| File | Purpose |
|------|---------|
| `customer_analysis.ipynb` | Main Jupyter notebook |
| `docker-compose.yml` | PostgreSQL configuration |
| `init.sql` | Database initialization |
| `mcp-config.json` | MCP server configuration |
| `requirements.txt` | Python dependencies |
| `docs/MCP_SETUP.md` | MCP configuration guide |

## 🎯 Portfolio Documentation

| File | Use For |
|------|---------|
| `docs/LINKEDIN.md` | LinkedIn posts and profile |
| `docs/RESUME.md` | Resume bullet points |
| `docs/GITHUB.md` | GitHub repository setup |

## 🔧 Troubleshooting

### PostgreSQL won't start
```bash
# Check Docker is running
docker ps

# Restart Docker Desktop
open -a Docker

# Wait 15 seconds, then try again
docker-compose up -d
```

### Jupyter won't launch
```bash
# Reinstall Jupyter
python3 -m pip install --upgrade jupyter notebook --user

# Try launching again
jupyter notebook
```

### Database connection fails
```bash
# Verify PostgreSQL is running
docker ps | grep postgres

# Check port 5432
lsof -i :5432

# Restart container
docker-compose restart
```

## 📊 Sample Analyses

### Customer Distribution
```python
import psycopg2
import pandas as pd

conn = psycopg2.connect(
    host='localhost',
    database='customerdb',
    user='postgres',
    password='postgres'
)

df = pd.read_sql_query("SELECT region, COUNT(*) as count FROM customers GROUP BY region", conn)
print(df)
```

### Revenue by Category
```sql
SELECT 
    product_category,
    SUM(order_amount) as total_revenue,
    COUNT(*) as order_count
FROM orders
GROUP BY product_category
ORDER BY total_revenue DESC;
```

## 🎓 Learning Resources

- [PostgreSQL Tutorial](https://www.postgresql.org/docs/15/tutorial.html)
- [Jupyter Documentation](https://jupyter-notebook.readthedocs.io/)
- [Pandas User Guide](https://pandas.pydata.org/docs/user_guide/index.html)
- [Matplotlib Tutorials](https://matplotlib.org/stable/tutorials/index.html)
- [MCP Documentation](https://modelcontextprotocol.io/)

## 📞 Getting Help

1. Check `docs/MCP_SETUP.md` for MCP configuration
2. Review `README.md` for setup instructions
3. Check troubleshooting section above
4. Review Jupyter notebook comments
5. Check Docker logs: `docker logs jupyter-mcp-postgres`

## ⚡ Quick Tips

- **Save your work**: Jupyter auto-saves, but manually save with `Cmd+S`
- **Restart kernel**: If notebook acts weird, restart kernel (Kernel → Restart)
- **Clear output**: Keep notebook clean with Cell → All Output → Clear
- **Export notebook**: File → Download as → HTML/PDF
- **Database backups**: Data persists in Docker volume `data-mcp_postgres_data`

## 🎯 Next Steps After Setup

1. ✅ Run all cells in `customer_analysis.ipynb`
2. ✅ Modify queries to explore different insights
3. ✅ Add your own visualizations
4. ✅ Configure MCP servers (see `docs/MCP_SETUP.md`)
5. ✅ Share on LinkedIn (use `docs/LINKEDIN.md`)
6. ✅ Update resume (use `docs/RESUME.md`)
7. ✅ Push to GitHub (use `docs/GITHUB.md`)

---

**Need more help?** Check the full documentation in `README.md` or `docs/` folder.

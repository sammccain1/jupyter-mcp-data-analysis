# Jupyter MCP Data Analysis Pipeline

![Python](https://img.shields.io/badge/Python-3.11-blue)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue)
![Docker](https://img.shields.io/badge/Docker-Compose-blue)
![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-orange)
![License](https://img.shields.io/badge/License-MIT-green)

AI-powered data analysis pipeline integrating Jupyter notebooks with PostgreSQL through Model Context Protocol (MCP) servers for intelligent database queries and automated visualizations.

## 📊 Project Overview

This project demonstrates how to:
- Connect to PostgreSQL databases using MCP
- Create interactive Jupyter notebooks for data analysis
- Visualize customer data with Matplotlib and Seaborn
- Integrate everything with Antigravity IDE

## ✨ Features

- 🐘 **PostgreSQL Database**: Containerized database with automated initialization
- 📊 **Interactive Analytics**: 8 comprehensive Jupyter notebook sections
- 🤖 **AI Integration**: MCP servers for natural language database queries
- 📈 **Rich Visualizations**: Multiple chart types with Matplotlib & Seaborn
- 🐳 **Docker Deployment**: Fully containerized for reproducibility
- 📝 **Complete Documentation**: Detailed setup and usage guides

## 🏗️ Architecture

```
┌─────────────────┐
│   Antigravity   │
│   (AI IDE)      │
└────────┬────────┘
         │
         │ MCP Protocol
         │
    ┌────┴────┐
    │         │
┌───▼──┐  ┌──▼────┐
│ PG   │  │Jupyter│
│ MCP  │  │ MCP   │
└───┬──┘  └──┬────┘
    │        │
┌───▼────────▼───┐
│   PostgreSQL   │
│   (Docker)     │
└────────────────┘
         │
    ┌────▼────┐
    │ Jupyter │
    │Notebook │
    └─────────┘
```

## 🚀 Quick Start

### 1. Start PostgreSQL Database

```bash
cd /path/to/jupyter-mcp-data-analysis
docker-compose up -d
```

This will start a PostgreSQL container with sample customer data (15 customers, 20 orders).

### 2. Verify Database

```bash
docker exec jupyter-mcp-postgres psql -U postgres -d customerdb -c "SELECT COUNT(*) FROM customers;"
```

Expected output: `15`

### 3. Launch Jupyter Notebook

```bash
jupyter notebook
```

This will open Jupyter in your browser. Open `customer_analysis.ipynb` to start analyzing data.

## 📁 Project Structure

```
DATA-MCP/
├── docker-compose.yml          # PostgreSQL container configuration
├── init.sql                    # Database initialization with sample data
├── requirements.txt            # Python dependencies
├── customer_analysis.ipynb     # Main Jupyter notebook
├── mcp-config.json            # MCP server configuration
└── README.md                  # This file
```

## 🗄️ Database Schema

### Customers Table
- `customer_id` (Primary Key)
- `first_name`, `last_name`, `email`
- `region` (Northeast, West, South, Midwest)
- `signup_date`
- `customer_segment` (Premium, Standard, Budget)

### Orders Table
- `order_id` (Primary Key)
- `customer_id` (Foreign Key)
- `order_date`
- `order_amount`
- `product_category` (Electronics, Books, Clothing, Home & Garden)

## 📈 Notebook Features

The `customer_analysis.ipynb` notebook includes:

1. **Database Connection** - Connect to PostgreSQL using psycopg2
2. **Customer Data Queries** - Query and display customer information
3. **Regional Distribution** - Bar chart showing customers by region
4. **Customer Segments** - Pie chart of segment distribution
5. **Order Trends** - Line chart of orders over time
6. **Revenue Analysis** - Revenue breakdown by product category
7. **Customer Lifetime Value** - CLV analysis by customer segment

## 🔧 MCP Configuration

The `mcp-config.json` file configures two MCP servers:

### PostgreSQL MCP Server
- Connects to the local PostgreSQL database
- Allows AI assistants to query the database
- Connection string: `postgresql://postgres:postgres@localhost:5432/customerdb`

### Jupyter MCP Server
- Integrates Jupyter notebooks with Antigravity
- Enables AI-assisted notebook development
- Workspace path: `/path/to/jupyter-mcp-data-analysis`

## 🛠️ Setup Instructions

### Prerequisites
- Docker Desktop (installed ✅)
- Python 3.11+ (installed ✅)

### Installation Steps

1. **Clone or navigate to project directory**
   ```bash
   cd /path/to/jupyter-mcp-data-analysis
   ```

2. **Install Python dependencies**
   ```bash
   python3 -m pip install -r requirements.txt --user
   ```

3. **Start PostgreSQL**
   ```bash
   docker-compose up -d
   ```

4. **Configure MCP servers in Antigravity**
   - Copy the contents of `mcp-config.json`
   - Add to Antigravity's MCP configuration
   - Restart Antigravity to load the servers

## 📊 Sample Queries

Here are some useful SQL queries you can run:

```sql
-- Get all customers from a specific region
SELECT * FROM customers WHERE region = 'Northeast';

-- Calculate total revenue
SELECT SUM(order_amount) as total_revenue FROM orders;

-- Find top customers by spending
SELECT 
    c.first_name, 
    c.last_name, 
    SUM(o.order_amount) as total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 5;
```

## 🧹 Cleanup

To stop and remove the PostgreSQL container:

```bash
docker-compose down
```

To remove the data volume as well:

```bash
docker-compose down -v
```

## 📚 Technologies Used

- **PostgreSQL 15** - Relational database
- **Docker** - Container platform
- **Jupyter** - Interactive notebooks
- **Python 3.11** - Programming language
- **psycopg2** - PostgreSQL adapter
- **Pandas** - Data manipulation
- **Matplotlib** - Data visualization
- **Seaborn** - Statistical visualization
- **MCP** - Model Context Protocol
- **Antigravity** - AI-powered IDE

## 🎯 Next Steps

- Add more complex queries and joins
- Create additional visualizations
- Implement predictive analytics
- Add data export functionality
- Integrate with other MCP servers (DBT, Grafana)

## 📝 Notes

- Database credentials are for development only (user: `postgres`, password: `postgres`)
- PostgreSQL runs on port 5432
- Sample data includes 15 customers and 20 orders
- All data is automatically initialized when the container starts

---

**Part of the NextWork Data Engineering with MCP tutorial series**

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Part of the [NextWork Data Engineering with MCP](https://learn.nextwork.org/projects/mcp-data-engineer3) tutorial series
- Built with [Model Context Protocol](https://modelcontextprotocol.io/)
- Inspired by modern data engineering best practices

## 📧 Contact

Sam McCain - [LinkedIn](https://linkedin.com/in/yourprofile) - [Email](mailto:smccain43@yahoo.com)

Project Link: [https://github.com/sammccain1/jupyter-mcp-data-analysis](https://github.com/sammccain1/jupyter-mcp-data-analysis)

## ⭐ Show Your Support

If you found this project helpful, please consider:
- ⭐ Starring this repository
- 🍴 Forking it for your own use
- 📢 Sharing it with others
- 🐛 Reporting issues or suggesting improvements

Your support helps make this project better!

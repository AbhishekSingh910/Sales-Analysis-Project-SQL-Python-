# 🛒 Retail Orders Data Analysis Project

## 📌 Project Overview

**Goal:**  
To help a retail business understand its **sales performance**, **customer behavior**, and **profitability trends** across different dimensions like **time**, **location**, and **product category**.

---

## 🎯 Why This Analysis?

| Analysis Block | Purpose |
|----------------|---------|
| **Revenue Trends / Avg Order Value** | Understand overall business health and customer spending patterns. |
| **Top Products & Profitable Orders** | Identify best-sellers to inform inventory and marketing. |
| **Sales by Region & City** | Discover regional demand to guide supply chain & local promotions. |
| **Time-Based Trends (Year, Quarter, Month)** | Detect seasonality and assist in forecasting. |
| **Sub-Category Growth & MoM Sales** | Highlight rising or declining products to inform strategy. |
| **Shipping & Order Patterns** | Evaluate logistics and customer preferences for better service. |

---

## 🧮 Dataset Info

- **Total Records:** 9,994
- **Initial Columns:** 16
- **Primary Data Points:** Order details, shipping info, prices, product categories, locations (mostly US-based)

---

## 🧑‍💻 Steps Performed

### 1. Data Loading & Exploration
- Downloaded dataset using **Kaggle API**.
- Initial inspection using `.info()`, `.describe()`, `.head()`, `.unique()`, etc.

### 2. Data Cleaning
- Treated `"Not Available"` and `"unknown"` as missing.
- Renamed columns (e.g., `Profit → Unit_Profit`)
- Dropped redundant columns (`Cost Price`, `List Price`, etc.)

### 3. Feature Engineering
- Created new metrics:
  - `Selling Price`, `Unit Profit`, `Total Sales`, `Total Profit`
  - Extracted `Month`, `Quarter` from `Order Date`

### 4. Database Integration
- Exported cleaned data (`df1`) to both **MySQL** and **PostgreSQL** using **SQLAlchemy**
- Ran validation SQL queries to ensure structure and data accuracy.

### 5. SQL + Python Analysis
- Performed deep-dive analysis with business-oriented queries:
  - Top cities by quantity
  - Regional revenue
  - Profitability of products
  - Quarter-over-quarter growth
  - Month-over-month YoY comparisons
  - Category and sub-category trends
  - Shipping method behaviors

---

## 📊 Key Insights

### 🏙️ City & Regional
- **New York City** had the highest quantity ordered: **3,417 units**
- **West** region leads in sales: **$3.47M**

### 💰 Revenue & Orders
- **Average Order Value:** ~$1,108.60
- **Top Profit Order:** #2698 earned **$21.7K profit** on **$130K sales**

### 🚚 Shipping Trends
- **Technology + Second Class** is a frequent combo — optimize for electronics.

### 🧾 Product Insights
- **Top Product (Profit):** `TEC-CO-10004722` — $24.8K
- Consistent high sellers across regions.

---

## 🔄 Month-over-Month YoY Comparison

| Month | 2022 Sales | 2023 Sales | YoY Growth (%) |
|-------|------------|------------|----------------|
| Jan   | $437,401   | $434,767   | -0.60%         |
| Feb   | $444,025   | $731,625   | +64.78%        |
| Jun   | $511,209   | $361,153   | -29.31%        |

- **Biggest Spike:** Feb 2023 (+64.78%)
- **Biggest Drop:** Jun 2023 (-29.31%)

---

## 📆 Quarter-wise Total Sales

| Year | Quarter | Sales |
|------|---------|--------|
| 2022 | Q1 | $1.28M |
| 2022 | Q4 | $1.50M |
| 2023 | Q1 | $1.56M |
| 2023 | Q4 | $1.57M |
- 🔼 **Best Quarter:** Q3 2023 — $1.59M  
- 🔽 **Weakest Quarter:** Q2 2023 — $1.22M

---

## 🗓️ Category-Wise Best Month (2023)

| Category         | Best Month | Sales     |
|------------------|------------|-----------|
| Furniture         | Aug        | $230.5K   |
| Office Supplies   | Feb        | $287.2K   |
| Technology        | Oct        | $295.6K   |

---

## 🔎 Sub-Category Performance

- **Machines** showed the **highest YoY growth**:
  - From **$335.3K** (2022) to **$548.2K** (2023)
  - 📈 Growth: **+63.49%**

---

## 💼 Key Business Takeaways

- 🕒 Sales peak in **February and Q4** — leverage this for seasonal promotions.
- 📦 **Technology & Machines** are booming — push them with ads & bundles.
- 🗽 **New York** is a top-performing city — continue investing in it.
- 📈 **Machines** saw a sharp rise — explore combo deals or upgrades.
- 🚚 **Second Class shipping** is widely used — consider optimizing it.

---




## 📌 Tags

`Retail` `SQL` `Python` `Data Analysis` `Feature Engineering` `Sales Insights` `E-commerce` `Profitability`


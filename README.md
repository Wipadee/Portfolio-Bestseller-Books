# Bestseller Books Dashboard

A data analysis and interactive dashboard project exploring Amazon's bestselling books (2009–2019) — focusing on trends, genres, user ratings, and pricing patterns.

![Power BI](https://img.shields.io/badge/Tool-Power%20BI-yellow?logo=powerbi)
![SQL](https://img.shields.io/badge/Tool-SQL-blue?logo=mysql)

---

## Project Overview

This project covers the end-to-end process of data preparation using SQL and dashboard building with Power BI. It aims to uncover insights such as:

- Which genres perform best?
- How do prices and ratings evolve over time?
- Who are the most frequent bestselling authors?

---

## Folder Structure
Portfolio-Bestseller-Books/
│

├── 📂 Data/

│ ├── bestsellers_summary.csv

│ └── bestsellers_per_year.csv
│

├── 📂 PowerBI/

│ └── Bestseller Books Dashboard.pbix
│

├── 📂 Raw data/

│ └── bestsellers with categories.csv
│

├── 📂 SQL/

│ └── prepare_data.sql
│

├── 📂 assets/

│ └── Preview Dashboard.zip
├

README.md


---

## Data Preparation (SQL)

- Tool: **MySQL via XAMPP/phpMyAdmin**
- Source: `bestsellers_with_categories.csv` (from Kaggle)
- Steps in `prepare_data.sql`:
  - Removed extra rows and renamed headers
  - Removed exact duplicates (same name + year + price)
  - Aggregated by book name:
    - `AVG(User_Rating)`, `AVG(Price)`, `AVG(Reviews)`
    - `Years_List`: list of years as bestseller
    - `Years_Count`: total years on list
  - books by year

🔗 [SQL Script](./SQL/prepare_data.sql)

---

## Power BI Dashboard

### 1. Cover Page
- Title, author name, project description
- Background image of books

### 2. Summary by Book
📄 From: `bestsellers_summary.csv`  
**Includes:**
- Slicer: Name, Years Count, Genre
- Bar: Average Price by Genre
- Donut: Average Rating by Genre
- Tooltip: Name, Author, Years List

*Shows book-level overview and genre comparison*

### 3. Trend by Year
📄 From: `bestsellers_per_year.csv`  
**Includes:**
- Line: Rating trend by Genre
- Line: Price trend by Genre
- Column: Bestseller count by Year & Genre
- Scatter: Price vs Rating vs Reviews
- Tooltip: Name, Author
- Slicer: Name, Year, Genre, Reviews

*Shows changes in popularity and value over time*

### 🟥 4. Insights & Highlight
**Includes:**
- Top Rated Book (KPI)
- Most Reviewed Book (KPI)
- Most Frequent Author (KPI)
- Heatmap: Genre vs Year

*Summarizes standout performers and genre trends*
### Dashboard Preview

![Dashboard Preview](./PowerBI/dashboard_preview.png)

## How to View the Dashboard
⚠️ *Note: GitHub may not preview large PDF or PBIX files — download them to view.*

- Open Power BI folder.
- Open `Bestseller Books.pbix` with Power BI Desktop (Free download from Microsoft)
- Click "View raw" to download `Bestseller Books.pbix`

## Full Dashboard Preview 
⚠️ *Note: GitHub may not preview large PDF or PBIX files — download them to view.*

- Open assets folder.
- Click "View raw" to download `Preview Dashboard.zip` to view preview dashboard pdf


---

## 🔑 Key Questions Answered

- Which genres consistently have high ratings?
- Which books stayed on the list for many years?
- Are prices increasing over time?
- Which authors frequently appear as bestsellers?
- What’s the relationship between reviews, ratings, and price?

---


---

## 🧰 Tools Used

| Tool         | Purpose                        |
|--------------|--------------------------------|
| SQL (MySQL)  | Data cleaning & transformation |
| Power BI     | Dashboard creation             |
| Excel        | Quick file check               |

---

## Dataset Source

[Kaggle – Amazon Top 50 Bestselling Books (2009–2019)](https://www.kaggle.com/datasets/sootersaalu/amazon-top-50-bestselling-books-2009-2019)

---

## Author

**Wipadee S.**  
Email: *wipadees@hotmail.com*  
Job: Entry-level Data Analyst (Open to work)

---

## Quick Access to Files

### File 
**1.Raw data File**: https://github.com/Wipadee/Portfolio-Bestseller-Books/tree/main/Raw%20data

**2.SQL Script File**: https://github.com/Wipadee/Portfolio-Bestseller-Books/blob/main/SQL/prepare_data.sql 

**3.Data:** https://github.com/Wipadee/Portfolio-Bestseller-Books/tree/main/Data

**4.Power BI File:** https://github.com/Wipadee/Portfolio-Bestseller-Books/tree/main/Power%20BI

**5.Dashboard PDF:** https://github.com/Wipadee/Portfolio-Bestseller-Books/tree/main/assets


## Future Improvements

- Connect live Power BI to database for auto-refresh
- Add more KPIs and dynamic user interaction
- Expand dataset to include sales numbers or international bestsellers

---

## Like this project?

If this project helped you or inspired your portfolio:
> Give it a ⭐ star or fork the repo to share!


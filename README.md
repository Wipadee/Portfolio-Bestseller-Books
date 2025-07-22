# Bestseller Books Dashboard

A Data Analysis and Dashboard Project based on bestseller book data (2009–2019), focusing on trends, genres, ratings, and pricing.

---

## Project Overview

This project explores the bestselling books dataset from Amazon between 2009–2019. It covers data cleaning using SQL, dataset restructuring, and building a professional Power BI dashboard to uncover key insights.

---

## Folder Structure
**Portfolio-Bestseller-Books/**
├── SQL/
│ └── prepare_data.sql
├── CSV/
│ ├── bestsellers_summary.csv
│ └── bestsellers_per_year.csv
├── PowerBI/
│ └── Bestseller Books.pbix
---

## Data Preparation (SQL)

- Tool: **MySQL / phpMyAdmin (XAMPP)**
- Dataset: `bestsellers_with_categories.csv`
- Actions:
  - Removed unnecessary rows (e.g., column names in first row)
  - Renamed all column headers
  - Removed exact duplicates (price + year)
  - Grouped books by name to calculate:
    - `AVG(User_Rating)`, `AVG(Price)`, `AVG(Reviews)`
    - `Years_List` → list of years the book was a bestseller
    - `Count_Years` → how many years it was on the list
- Exported 2 datasets for Power BI:
  - 📄 `bestsellers_summary.csv`
  - 📄 `bestsellers_per_year.csv`

🔗 [SQL Script](./SQL/prepare_data.sql)

---

## Power BI Dashboard

### Dashboard Pages:

1. **Dashboard overview**
   - Project title, Project details
3. **Summary by Book**
   - Table: AVG Rating / Price / Reviews per book
   - Tooltip: Book details
   - Bar chart: Average Rating per Genre
   - Bar chart: Average Price per Genre
   - Donut chart: Fiction vs Non-Fiction
4. **Trend by Year 1**
   - Line: Rating trend by Genre
   - Column: Bestseller count per Year
5. **Trend by Year 2**
   - Scatter Chart: Reviews vs Price and Rating
   - Line: Price trend by Genre
6. **Insights & Highlight**
   - Top-rated book
   - Most reviewed book
   - Most frequent author
   - Heatmap: Genre x Year
7. **Cover Page**
   - Project title, author info

🔗 [Power BI File](./Power BI/Bestseller Books Dashboard.pbix)

---

## Key Insights

- **Fiction consistently outperformed Non-Fiction** in terms of rating.
- **Business and Self-Help genres** had higher prices.
- **Jeff Kinney** were the most frequent authors.
- **Highest reviewed book** had reviewed close to 88K for multiple years.

---

## 🧰 Tools Used

| Tool            | Purpose                        |
|-----------------|--------------------------------|
| **SQL (MySQL)** | Data cleaning & transformation |
| **Power BI**    | Interactive visualization      |
| **Excel**       | Quick data inspection          |

---

## Dataset Source

- [Amazon Bestsellers Dataset (2009–2019) – Kaggle](https://www.kaggle.com/datasets/sootersaalu/amazon-top-50-bestselling-books-2009-2019)

---

## Author

**Wipadee S.**  
Emai:*wipadees@hotmail.com*  
Job: Entry-level Data Analyst  
Status: Open to work 

---

## Ready to Explore?

Click below to view the main files:

-  [SQL Script](./SQL/prepare_data.sql)
-  [CSV: Summary Table](./CSV/bestsellers_summary.csv)
-  [CSV: Yearly Detail Table](./CSV/bestsellers_per_year.csv)
-  [Power BI Dashboard](./PowerBI/Bestseller%20Books.pbix)

---

**> If you find this project helpful, feel free to star or fork the repo!**

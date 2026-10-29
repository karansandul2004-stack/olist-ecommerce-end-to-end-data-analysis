# Olist E-commerce End-to-End Data Analysis
### Python | SQL | Power BI

## Project Overview

This project analyses the Olist Brazilian e-commerce dataset to investigate sales performance, product categories, customer behavior, order fulfilment, payments, and customer reviews.

The project follows an end-to-end data analytics workflow:

- **Python:** Data quality checks, data cleaning validation, and exploratory data analysis (EDA).
- **SQL:** Business-question analysis, aggregations, joins, and analytical queries.
- **Power BI:** Data modelling, DAX measures, interactive dashboards, and business insights.

The objective is to transform raw e-commerce data into meaningful, evidence-based findings that can support business decision-making.

## Business Objectives

- Understand sales trends and order activity.
- Identify product categories contributing the most to item sales.
- Analyse customer distribution and repeat-order behavior.
- Investigate delivery duration and freight values.
- Understand payment-method usage.
- Examine customer review scores.
- Present findings through interactive Power BI dashboards.

## Tools & Technologies

| Tool | Purpose |
|---|---|
| Python | Data inspection, cleaning validation, and EDA |
| Pandas | Data manipulation and analysis |
| NumPy | Numerical operations |
| Jupyter Notebook | Interactive analysis and documentation |
| MySQL | SQL-based business analysis |
| Power Query | Data transformation and preparation |
| DAX | Measures and KPI calculations |
| Power BI | Interactive dashboards and reporting |
| GitHub | Version control and portfolio presentation |

## Dataset

The project uses the Olist Brazilian e-commerce dataset, consisting of nine related CSV tables:

1. Customers
2. Orders
3. Order Items
4. Products
5. Payments
6. Reviews
7. Sellers
8. Product Category Translation
9. Geolocation

**Dataset source:** [Add the original dataset source link]

The tables contain information about customers, orders, purchased items, products, sellers, payments, reviews, and geographic locations.

The dataset is analysed across multiple related tables to preserve the appropriate level of detail for each business question.

Dataset files are not included by default. Please refer to the original source and its applicable terms for access and permitted use.

## Project Workflow

### Phase 1 — Python: Data Cleaning Validation & EDA

Python and Jupyter Notebook are used to inspect and understand the dataset before business analysis.

Key activities:

- Inspect dataset dimensions, column names, and data types.
- Identify missing values and duplicate records.
- Validate identifiers and relationships between tables.
- Investigate inconsistent or suspicious values.
- Examine order statuses and timestamp completeness.
- Analyse product categories, payment methods, and review scores.
- Explore patterns and potential business questions through visualisations.
- Document cleaning decisions and data limitations.

**Deliverables:**
- Jupyter notebooks
- Data quality checks
- Exploratory analysis and visualisations
- Documented observations and data limitations

### Phase 2 — SQL: Business Questions

MySQL is used to answer business questions by querying the relevant tables and aggregating data at the correct level.

Areas of analysis include:

- Sales and order trends
- Orders by status
- Product category performance
- Customer ordering behavior
- Payment-method analysis
- Delivery duration
- Review-score analysis
- Repeat-customer analysis

SQL techniques used, where applicable:

- SELECT, WHERE, GROUP BY, and HAVING
- Aggregate functions
- JOIN operations
- CASE statements
- Subqueries and Common Table Expressions (CTEs)
- Window functions
- Date-based analysis
- Data validation queries

**Deliverables:**
- SQL table setup and validation scripts
- Business-question queries
- Query results and documented findings

### Phase 3 — Power BI: Interactive Dashboard

Power BI is used to model the related tables and present key metrics and findings through interactive reports.

The report contains four analytical pages.

#### Page 1 — Sales Overview

Focus:
- Total item sales
- Total orders
- Average order value
- Customer count
- Monthly sales trends
- Order-status distribution

#### Page 2 — Product Analysis

Focus:
- Item sales by product category
- Average item price by category
- Product-level sales analysis
- Category comparisons

#### Page 3 — Customer Analysis

Focus:
- Customers by state
- Repeat customers and repeat-customer rate
- Review-score distribution
- Customer ordering behavior

#### Page 4 — Delivery & Payments

Focus:
- Average delivery time in calendar days
- Total freight value
- Payment value by payment method
- Average review score
- Review and order-status analysis

**Deliverables:**
- Power BI report (`.pbix`)
- Data model and relationship design
- DAX measures
- Dashboard screenshots

## Data Modelling & Validation

The project uses separate tables for customers, orders, order items, products, sellers, payments, and reviews.

Key modelling considerations:

- Use distinct order counts when counting orders.
- Calculate average order value from order-level totals rather than averaging item prices.
- Keep raw payment and review records separate from order-item records to prevent duplicated totals.
- Validate relationship keys and cardinality.
- Avoid directly joining raw geolocation records where multiple coordinates exist for one ZIP-code prefix.
- Document missing timestamps and other data limitations before interpreting results.

See `powerbi/data-model.md` for the implemented model and its validation notes.

## Key Metrics

| Metric | Definition |
|---|---|
| Total Item Sales | Sum of item prices; not profit |
| Total Orders | Distinct count of order IDs |
| Average Order Value | Average item-price total per order, excluding freight |
| Total Customers | Distinct customer unique IDs, where available |
| Repeat Customer Rate | Customers with multiple distinct orders divided by distinct customers in the selected scope |
| Average Item Price | Average price across order-item records |
| Total Freight | Sum of freight values in order-item records |
| Average Delivery Days | Average elapsed calendar days from purchase to customer delivery for eligible delivered orders |
| Total Payment Value | Sum of payment records |
| Average Review Score | Average of review scores |

Metric definitions should match the final DAX measures and SQL queries in the project.

## Business Insights & Recommendations

This section will contain findings verified through Python, SQL, and Power BI.

Examples of questions to investigate:

1. How does item sales value change over time?
2. Which product categories contribute the most to item sales?
3. What proportion of customers place more than one order?
4. Which payment methods account for the largest recorded payment value?
5. What is the average delivery time for delivered orders?
6. How are review scores distributed?

**Verified findings:**
- [Add a finding supported by a query or dashboard, including its date range.]
- [Add a product or category finding with the relevant metric.]
- [Add a customer behavior finding with its definition and scope.]
- [Add a delivery or payment finding supported by the analysis.]

**Recommendations:**
Add recommendations only after investigating the results. Explain the evidence behind each recommendation and avoid presenting correlation as causation.

## Dashboard Screenshots

### Sales Overview
![Sales Overview](screenshots/01-sales-overview.png)

### Product Analysis
![Product Analysis](screenshots/02-product-analysis.png)

### Customer Analysis
![Customer Analysis](screenshots/03-customer-analysis.png)

### Delivery & Payments
![Delivery & Payments](screenshots/04-delivery-payments.png)

### Power BI Data Model
![Power BI Data Model](screenshots/05-powerbi-data-model.png)

## Repository Structure

```text
olist-ecommerce-end-to-end-data-analysis/
├── README.md
├── requirements.txt
├── .gitignore
├── data/
│   └── README.md
├── screenshots/
│   ├── 01-sales-overview.png
│   ├── 02-product-analysis.png
│   ├── 03-customer-analysis.png
│   ├── 04-delivery-payments.png
│   └── 05-powerbi-data-model.png
└── docs/
    ├── business-questions.md
    ├── key-findings.md
    └── data-cleaning-decisions.md
```

## Skills Demonstrated

- Exploratory Data Analysis (EDA)
- Data quality assessment and cleaning validation
- Python and Pandas
- SQL querying and business analysis
- Relational data modelling
- Power Query and DAX
- Interactive dashboard development
- KPI definition and validation
- Business insight communication
- Documentation and version control

## Author

**Karandeep Sandul**

GitHub: [@karansandul2004-stack](https://github.com/karansandul2004-stack)


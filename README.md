# Blinkit Sales Data Engineering Project

An end-to-end data engineering project that builds a scalable analytics pipeline for Blinkit sales data using **Databricks, dbt, and Power BI**.

The project demonstrates how raw retail data can be ingested, transformed, and served as an analytical dataset following the **Medallion Architecture**.

---

## 📌 Project Overview

This project aims to build an end-to-end data pipeline for processing Blinkit sales and operational data.

The pipeline starts from raw data sources and transforms them into structured analytical datasets that can be consumed by BI tools and used for business analysis.

### Main Objectives

* Build an end-to-end data pipeline.
* Implement the Medallion Architecture.
* Ingest multiple source tables into Databricks.
* Transform raw data using dbt.
* Implement incremental data processing.
* Maintain historical changes using dbt snapshots.
* Perform data quality testing.
* Produce a final analytical dataset / One Big Table (OBT).
* Prepare data for business intelligence and visualization.

---

## 🏗️ Architecture

<img width="6103" height="1712" alt="Untitled-2026-09-22-1451" src="https://github.com/user-attachments/assets/2d4486c6-36ba-4084-a589-7487772e1514" />

---

## 🛠️ Tech Stack

| Technology     | Purpose                                         |
| -------------- | ----------------------------------------------- |
| Databricks     | Data processing and analytical platform         |
| SQL            | Data transformation and analysis                |
| dbt            | Data transformation, testing, and documentation |
| PostgreSQL     | Optional OLTP / source database                 |
| Power BI       | Data visualization                              |
| Git & GitHub   | Version control                                 |

---

# 📂 Dataset

The source dataset is the **Blinkit Sales Dataset** from Kaggle.

**Source:** [Blinkit Sales Dataset on Kaggle](https://www.kaggle.com/datasets/akxiit/blinkit-sales-dataset)

The dataset contains multiple CSV/XLSX files covering sales, customers, products, orders, inventory, delivery, and marketing data. The available files include:

```text
blinkit_customers.csv
blinkit_orders.csv
blinkit_order_items.csv
blinkit_products.csv
blinkit_inventory.csv
blinkit_inventoryNew.csv
blinkit_delivery_performance.csv
blinkit_marketing_performance.csv
blinkit_customer_feedback.csv
```

The dataset repository lists 9 files in total.

---

# 🥉 Bronze Layer

The Bronze layer stores data as close as possible to the original source.

### Responsibilities

* Ingest raw files.
* Preserve source information.
* Add ingestion metadata.
* Maintain source file information.
* Avoid heavy business transformations.

---

# 🥈 Silver Layer

The Silver layer contains cleaned and standardized data.

### Transformation examples

* Remove duplicate records.
* Standardize column names.
* Cast data types.
* Handle NULL values.
* Validate relationships.
* Normalize date/time fields.
* Apply business rules.
* Create calculated fields.

---

# 🥇 Gold Layer

The Gold layer contains business-ready analytical datasets.

The project creates dimensional models and a final **One Big Table (OBT)** for analytical consumption.

The OBT combines relevant dimensions and facts into a single analytical dataset.

---

# Dimensional Modelling
<img width="493" height="329" alt="image" src="https://github.com/user-attachments/assets/81ba979a-6fa5-4f0c-9eb4-bd87f281495c" />

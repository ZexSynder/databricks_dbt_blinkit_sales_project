# Blinkit Sales Data Engineering Project

An end-to-end data engineering project that builds a scalable analytics pipeline for Blinkit sales data using **Databricks, dbt, airflow and Power BI**.

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
* Orchestrate the pipeline using Apache Airflow.
* Produce a final analytical dataset / One Big Table (OBT).
* Prepare data for business intelligence and visualization.

---

## 🏗️ Architecture

<img width="6103" height="1866" alt="Untitled-2026-09-22-1452" src="https://github.com/user-attachments/assets/5ede731d-a9f6-4b17-91fe-2cf130a3d277" />


---

## 🛠️ Tech Stack

| Technology     | Purpose                                         |
| -------------- | ----------------------------------------------- |
| Python         | Data processing and automation                  |
| Databricks     | Data processing and analytical platform         |
| SQL            | Data transformation and analysis                |
| dbt            | Data transformation, testing, and documentation |
| PostgreSQL     | Optional OLTP / source database                 |
| Power BI       | Data visualization                              |
| Apache Airflow | Pipeline orchestration                          |
| Docker         | Local development and Airflow environment       |
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
Star Schema

<img width="493" height="329" alt="image" src="https://github.com/user-attachments/assets/81ba979a-6fa5-4f0c-9eb4-bd87f281495c" />

---

# Dashboard Using Power BI
<img width="584" height="328" alt="image" src="https://github.com/user-attachments/assets/08a69bc2-c3e7-4ef6-b568-440e5cc2da04" />

---

# ⚙️ Pipeline Orchestration

Apache Airflow is used to orchestrate the entire workflow.

<img width="959" height="445" alt="Screenshot 2026-10-04 211644" src="https://github.com/user-attachments/assets/b393f824-538a-404f-b88b-420a2f5c1c0b" />

This allows the pipeline to execute automatically according to a defined schedule.

---

# 📁 Project Structure

```text
databricks_dbt_blinkit_sales_project/
│
├── airflow/
│   ├── config/
│   │   └── airflow.cfg
│   ├── dags/
│   │   ├── ingest_data.py
│   │   └── orchestrate.py
│   ├── logs/
│   ├── plugins/
|   ├── main_project/
│   │   ├── analyses/
│   │   │   ├── analisis.sql
│   │   │   └── describe.sql
│   │   ├── macros/
│   │   │   └── generate_schema_name.sql
│   │   ├── models/
│   │   │   ├── gold/
│   │   │   │   ├── ephemeral/
│   │   │   │   │   ├── customers_feedback.sql
│   │   │   │   │   ├── customers.sql
│   │   │   │   │   ├── date.sql
│   │   │   │   │   ├── delivery_performance.sql
│   │   │   │   │   ├── inventory.sql
│   │   │   │   │   ├── orders.sql
│   │   │   │   │   └── products.sql
│   │   │   │   ├── obt.sql
│   │   │   │   └── fact.sql
│   │   │   ├── silver/
│   │   │   │   ├── s_customer_feedback.sql
│   │   │   │   ├── s_customers.sql
│   │   │   │   ├── s_delivery_performance.sql
│   │   │   │   ├── s_inventory.sql
│   │   │   │   ├── s_orders.sql
│   │   │   │   ├── s_products.sql
│   │   │   │   ├── s_marketing_performance.sql
│   │   │   │   └── s_order_items.sql
│   │   │   └── source/
│   │   │   │   └── sources.yml
│   │   ├── seeds/
│   │   ├── snapshots/
│   │   │   ├── dim_customers_feedback.yml
│   │   │   ├── dim_customers.yml
│   │   │   ├── dim_delivery_performance.yml
│   │   │   ├── dim_inventory.yml
│   │   │   ├── dim_orders.yml
│   │   │   └── dim_products.yml
│   │   ├── tests/
│   │   ├── dbt_project.yml
│   │   └── packages.yml
│   ├── docker-compose.yml
│   ├── .env
│   ├── Dockerfile
│   └── requirements.txt
├── DDL.sql
├── .python-version
├── pyproject.toml
├── .gitignore
├── uv.lock
└── README.md
```

---

# 🚀 How to Run

## 1. Clone Repository

```bash
git clone https://github.com/ZexSynder/databricks_dbt_blinkit_sales_project.git

cd databricks_dbt_blinkit_sales_project
```

## 2. Configure Environment

Create:

```text
.env
```

Example:

```env
DATABRICKS_HOST=
DATABRICKS_TOKEN=
```

---

## 3. Run Data Ingestion

Upload or ingest the source data into the Databricks Bronze layer.

Example:

```text
Source
  ↓
Databricks
  ↓
blinkit.bronze.*
```

---

## 4. Run dbt

Install dependencies:

```bash
dbt deps
```

Run models:

```bash
dbt run
```

Run tests:

```bash
dbt test
```

Generate documentation:

```bash
dbt docs generate
```

---

## 5. Run Airflow

Start Airflow using Docker:

```bash
docker compose up -d
```

Open the Airflow UI and trigger:

```text
orchestrate
```

---


# 📌 Project Results

The completed pipeline provides:

* End-to-end data ingestion.
* Medallion Architecture implementation.
* Bronze, Silver, and Gold data layers.
* Incremental data processing.
* Historical data tracking using snapshots.
* Automated data quality testing.
* dbt-based transformation.
* Airflow orchestration.
* Business-ready Gold tables.
* One Big Table for analytical workloads.
* Data ready for Power BI visualization.

---

# ⚠️ Data Limitations

The Kaggle dataset is used as a learning and portfolio dataset.

---

# 🔮 Future Improvements

Potential improvements include:

* [ ] Implement automated CI/CD for dbt.
* [ ] Add Great Expectations or additional data quality checks.
* [ ] Implement Databricks Workflows.
* [ ] Add data lineage.
* [ ] Add monitoring and alerting.
* [ ] Implement Slowly Changing Dimensions Type 2.
* [ ] Add partitioning and optimization.
* [ ] Implement Delta Lake OPTIMIZE / VACUUM strategy.
* [ ] Add Power BI incremental refresh.
* [ ] Add pipeline performance monitoring.
* [ ] Deploy infrastructure using Terraform.

---

# 👨‍💻 Author

**Fathur Rahman**

Data Engineering | Data Analytics | Machine Learning

---

# 📚 Dataset Reference

Original dataset:

https://www.kaggle.com/datasets/akxiit/blinkit-sales-dataset

The dataset is attributed to its original Kaggle source. The publicly mirrored copy confirms the dataset contains 11 source files covering customers, orders, order items, products, inventory, delivery, marketing, and customer feedback.

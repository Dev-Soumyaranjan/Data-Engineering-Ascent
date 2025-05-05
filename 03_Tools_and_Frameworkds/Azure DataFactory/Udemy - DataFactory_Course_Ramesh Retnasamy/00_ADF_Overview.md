# 📘 Section: ADF Overview (5 videos)

## 🧠 What I Understood

- Azure Data Factory (ADF) is Microsoft’s **fully managed, serverless data integration service**.
- It supports **ingesting, preparing, and transforming data at scale** across hybrid environments.
- ADF is used for building **orchestrated data pipelines**, enabling both no-code and code-based data engineering.
- It simplifies the data movement from source to destination and integrates well with multiple Azure storage and compute services.

### 📂 Project Context

This project revolves around building a modern data integration platform to support:

- COVID-19 Spread Prediction (for Data Scientists), and
- COVID-19 Trend Reporting (for Data Analysts via Power BI).

The goal is to ingest and process EU and UK COVID-related datasets (confirmed cases, mortality, hospitalizations, and test numbers), making the data available in:

- Azure Data Lake Storage (ADLS) for machine learning modeling.
- Azure SQL Database for reporting purposes.

🏗️ Solution Architecture Overview

- Data Sources:
  - OVID-19 stats fetched via HTTP connector from the ECDC website.
  - Population data manually uploaded to Azure Blob Storage.
- Ingestion:
  - All raw data is moved into Azure Data Lake Storage (ADLS) for centralized storage.
- Transformations:
  - Conducted using a mix of:
    - ADF Mapping Data Flows (no/low-code).
    - Azure HDInsight and Databricks for complex transformations.
- Data Output:
  - Transformed data is stored in:
    - ADLS → for the Data Science team to build ML models.
    - Azure SQL DB → for the Reporting team to create dashboards via Power BI.

➡️ Note: The course concludes with a Power BI demo using this data, though the primary focus remains on ADF pipeline development and integration.

![Project Solution Architecture Diagram](<Assets/Solution Architecture Diagram.png>)

### 📂 Azure Storage Options

- **Azure SQL Database** – for structured, transactional workloads and reports.
- **Azure Blob Storage / ADLS** – best for object-based, big data lake scenarios.
- Other options: **Cosmos DB**, **PostgreSQL**, etc.

---

### 📌 Storage Decision Factors

When choosing the right Azure storage service, consider:

1. **Data Structure**:
   - Is the data **structured**, **semi-structured**, or **unstructured**?

2. **Operational Needs**:
   - How frequently will data be accessed?
   - Do you need **fast reads/writes**?
   - Is it for **transactional queries** or **analytical workloads**?
   - Will it be accessed across **multiple regions**?
   - Is low latency critical?

📢 **Insight**: There’s no one-size-fits-all. As a data engineer, selecting the right storage is crucial based on **data type**, **access pattern**, and **query needs**.

---

### ❓ When should you use ADF Mapping Data Flows vs Databricks vs HDInsight in a real project?

💡 Instructor Insight:

- ADF Mapping Data Flows: Ideal for no-code or low-complexity transformations; easy to build and maintain.
- Databricks / HDInsight: Use when transformations are complex, performance-intensive, or require custom Spark logic; offers more control and scalability.

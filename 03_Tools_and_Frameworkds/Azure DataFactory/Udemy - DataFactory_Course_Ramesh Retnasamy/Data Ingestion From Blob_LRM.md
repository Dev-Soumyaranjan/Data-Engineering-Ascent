# 🔁 LRM Framework: Blob to ADLS Ingestion

## 🔹 Learned (Concepts)

- Setting up a data ingestion pipeline using **Copy Activity** from Blob Storage to ADLS.
- Understanding and creating key ADF components:
  - **Linked Services** (for connection configuration)
  - **Datasets** (for defining file format and path)
  - **Pipelines** (for orchestrating activities)
- Handling real-world ingestion scenarios:
  - File existence checks
  - Metadata validation before processing
  - Post-copy cleanup using Delete activity
- Using **Triggers** (Schedule, Storage Event, Tumbling Window) to automate execution

---

## 🔍 Reflect

i. **What are Linked Services?**

- Think of it as your “connection string”. It holds authentication details and tells ADF how to reach your data source/destination.
- Types include Azure Blob, Azure SQL DB, REST APIs, etc.
- You're essentially saying: “Hey ADF, here’s how you get access.”
  
ii. **What is a Dataset?**

- Think of it like a pointer + schema guide to the data file/table.
- For blob: tells ADF the file format (.tsv), compression (.gz), folder path, delimiter, etc.
- Dataset doesn’t contain data—it just describes what data looks like and where it is.
  
iii. **Why use Copy Activity for data movement?**

- It's the simplest and most efficient way to move data between storage systems in ADF.
- Supports schema mapping and source/destination transformations if needed.

iv. **Why use Validation and Get Metadata Activities?**

- Prevents pipeline failure or bad data processing by validating file existence and structure before ingestion.
- Promotes robustness in enterprise pipelines.

v. **What is the significance of naming conventions?**

- Increases maintainability and team collaboration.
- Makes debugging and monitoring easier at scale.

vi. **Which trigger should I use when?**

| Scenario                                 | Trigger Type            |
|------------------------------------------|-------------------------|
| Ingest file as soon as uploaded          | Storage Event Trigger   |
| Run pipeline every day/hour              | Schedule Trigger        |
| Time-sliced, batch-based data pipelines  | Tumbling Window Trigger |

> Tumbling triggers are more advanced and useful when you want **guaranteed once-only execution per time slice**.

---

## 🧠 Master

✅ **Scenario: Robust Ingestion Flow**

You receive `.gz` files via FTP daily. You must ingest them only if:

- They arrive in time
- The content structure is as expected
- Once ingested, the file should be deleted from the source

**Solution Flow:**

1. **Validation Activity** – It ensures the pipeline only continues execution once it validates the attached dataset reference exists, that it meets the specified criteria, or times out.
2. **Get Metadata Activity** – Inspect file size, format, etc.
3. **If Condition Activity** – Proceed only if metadata is valid
4. **Copy Activity** – Ingest data from Blob to ADLS
5. **Delete Activity** – Clean up source if copy is successful
6. **Trigger** – Use Storage Event Trigger to automate on upload

---

## 🗣️ Interview Questions

**1. How does Copy Activity work in ADF and what are its limitations?**

- Copy Activity moves data from source to sink with optional mapping.
- Supports multiple formats (CSV, Parquet, JSON, etc.).
- Limitations: Not suited for complex row-level logic; no loop iteration within Copy itself.

---

**2. What is the role of Linked Services and Datasets in ADF?**

- **Linked Service** defines the connection to a data source (e.g., Blob, ADLS, Azure SQL).
- **Dataset** defines the metadata (schema, path, file format) for the data being accessed.

---

**3. Why use Validation and Metadata activities before Copy?**

- To make your pipeline fault-tolerant.
- Avoids unnecessary processing or failure when files are missing or malformed.

---

**4. What is the difference between Storage Event Trigger and Tumbling Window Trigger?**

- **Storage Event Trigger**: Event-based; fires when file is uploaded.
- **Tumbling Window Trigger**: Time-windowed; ensures exactly-once execution; best for scheduled batch jobs with state tracking.

---

## ✅ Key Takeaways

- Use **Copy Activity** for data ingestion with light transformation.
- Combine **Validation**, **Metadata**, and **Condition** to create robust pipelines.
- Choose **trigger types** based on your scheduling vs event-driven needs.
- Focus on understanding real-world use cases over memorizing UI-level details.

> This section built foundational confidence in designing **intelligent ingestion pipelines** using low-code tools in ADF.

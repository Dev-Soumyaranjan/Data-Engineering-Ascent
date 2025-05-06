# Learning Log - Azure Data Factory

## 📅 2025-05-05

---

### 📚 Topics Covered - ADF Overview

- What is ADF & Why it exists
- ADF definition breakdown (fully managed, serverless, scale, etc.)
- ADF course project: COVID-19 reporting & prediction platform
- Solution architecture: Data ingestion → ADLS → Transform (Data Flow, HDInsight, Databricks) → Output (ADLS & Azure SQL)
- Azure Storage services overview (Blob, ADLS, Azure SQL, Cosmos DB)
- Storage selection criteria (structure, access, latency, query needs)
- When to use Data Flow vs Databricks vs HDInsight

---

### 🎯 Course / Resources

- **Primary Course**:  
Azure Data Factory For Data Engineers - Project on Covid19

---

### 🔎 Personal Notes

🔎 Personal Notes :

- Concepts and use-case scenarios are documented in the respective markdown file i.e `00_ADF_Overview.md`.
- The solution architecture diagram is added to visually represent the pipeline flow.

---

### 🏷️ Tags

- `#ADF`, `#AzureStorage`, `#Covid19Project`, `#DataPipeline`, `#TransformationTools`, `#ProjectContext`,`#Ramesh Retnasamy`

## 📅 2025-05-06

---

### 📚 Topics Covered - Environment Setup & ADLS Gen2 Advanced Settings

- Provisioned key Azure resources for the COVID-19 data pipeline:
  - Azure Data Factory
  - Azure Blob Storage
  - Azure Data Lake Storage Gen2 (Hierarchical Namespace enabled)
  - Azure SQL Database

- Explored **Advanced Settings in ADLS Gen2**:
  - Security configurations (secure transfer, anonymous access, key-based access, Entra ID)
  - Hierarchical namespace purpose and significance
  - Access protocol options (SFTP, NFS)
  - Storage access tiers (Hot, Cool, Cold)
  - Differences between Blob and ADLS
  - How SFTP turns ADLS into a secure drop zone (removes need for on-prem SFTP server)

---

### 🎯 Course / Resources - Environment Setup & ADLS Gen2 Advanced Settings

- **Primary Course**:  
Azure Data Factory For Data Engineers - Project on Covid19

- **Personal Supplement**:  
Preparing for Azure Data Engineer Associate (DP-203) — will revisit each resource in-depth via another Azure-focused course.

---

### 🔎 Personal Notes - Environment Setup & ADLS Gen2 Advanced Settings

- Markdown file `01_Environment_Setup.md` created to document:
  - Resource creation steps
  - Clean, beginner-friendly explanation of each ADLS advanced setting
  - Use-case reasoning behind enabling/disabling options (e.g., SFTP, Hierarchical Namespace)
  - Clear separation between "what was done" and "why it matters"

- **Insight**: While the resource setup doesn’t require full LRM, the ADLS advanced options deepened understanding and will likely recur in interviews, especially SFTP and Hierarchical Namespace.

---

### 🏷️ Tags - Environment Setup & ADLS Gen2 Advanced Settings

- `#ADF`, `#AzureStorage`, `#ADLSGen2`, `#SFTP`, `#Security`, `#EnvironmentSetup`, `#Covid19Project`,`#Ramesh Retnasamy`

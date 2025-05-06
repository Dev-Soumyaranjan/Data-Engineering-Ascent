# 🧱 Section: Environment Setup

## ✅ Resources Created

As per the guided project setup, the following Azure resources were provisioned:

1. **Azure Data Factory (ADF)**  
   - The main orchestrator for building and managing pipelines.

2. **Storage Account (Blob)**  
   - Used for generic blob storage scenarios. Initially created to show the difference with ADLS Gen2.

3. **Storage Account (ADLS Gen2 Enabled)**  
   - Used for hierarchical namespace and Data Lake workloads.
   - Will serve as the main data ingestion and staging area for the pipeline.

4. **Azure SQL Database**  
   - Destination for storing structured, transformed data.
   - Will be used for Power BI reporting and dashboard integration later in the project.

---

### 🧠 Personal Note

> This setup is part of the hands-on COVID Data Engineering project. However, I also plan to take the **Azure Data Engineer Associate Certification (DP-203)** in the coming month.  
> I already have access to a comprehensive Azure course that will cover all these services (ADF, ADLS, Azure SQL, etc.) in deeper detail. For now, I’m staying focused only on what's needed in this specific ADF project.

---

## 🔍 Light Reflection

- Each Azure service plays a unique role in the data pipeline:
  - ADF orchestrates everything.
  - ADLS stores raw and transformed data.
  - Azure SQL supports structured querying and reporting.
- No deep LRM required here, as this phase is mostly provisioning—concepts will come alive in future steps when we build the pipeline.

## ⚙️ Additional Info - Advanced Settings : ADLS Gen2 Explained Simply

### 🔐 Security

| Option                                      | Meaning in Simple Terms                                                                                 |
|--------------------------------------------|----------------------------------------------------------------------------------------------------------|
| ✅ Require secure transfer                  | Forces all data to be transferred over HTTPS (encrypted). Like saying: “Only allow secure doors for data.” **Always ON**. |
| ✅ Allow enabling anonymous access          | Lets containers be publicly accessible without login. Risky for sensitive data. Keep **OFF** unless needed for public files. |
| ✅ Enable storage account key access        | Allows connecting via secret access keys (like passwords). Needed for apps/tools like ADF to connect. Usually **ON**. |
| ✅ Default to Microsoft Entra authorization | Uses Entra ID (formerly AAD) for managing access instead of just keys. **Turn ON** if using role-based access control. |
| 🔐 Minimum TLS version                     | TLS is the encryption layer. Set it to **1.2 or higher**. Never use outdated 1.0/1.1. |
| 🧪 Permitted scope for copy operations      | Advanced setting to control which scopes can copy data from/to. Leave as default unless specific compliance required. |

---

### 📂 Hierarchical Namespace (Very Important)

| Option                       | Meaning                                                                                      |
|-----------------------------|----------------------------------------------------------------------------------------------|
| ✅ Enable hierarchical namespace | **Turns on folder/file structure** in storage. This is what makes it "Data Lake Gen2." Enables ACLs and directory-level access. **Always ON** for data engineering work. |

---

### 🔌 Access Protocols

| Option             | Meaning                                                                                                           |
|--------------------|--------------------------------------------------------------------------------------------------------------------|
| ✅ Enable SFTP      | 🔥 **Makes your ADLS Gen2 behave like an SFTP server.** Useful when third parties/vendors send files via SFTP. ✅ **No need to manage on-prem SFTP infra anymore**—files land directly into your container.  💡 Use **only if** you work with legacy vendors or external partners relying on SFTP. **Note**: Extra cost. |
| ✅ Enable NFS v3    | Allows mounting storage on Linux systems like a drive (via NFS protocol). Mostly for advanced use cases or HPC. Leave **OFF** unless required. |

---

### 📦 Blob Storage Options

| Option                          | Meaning                                                                                                  |
|----------------------------------|----------------------------------------------------------------------------------------------------------|
| 🔁 Allow cross-tenant replication | Lets you copy data across different Azure tenants (orgs). Not allowed with hierarchical namespace ON. Skip it. |
| 📊 Access Tier (Hot/Cool/Cold)   | Affects cost + speed: - **Hot**: Fast & frequent access (ADF pipelines)  - **Cool**: Infrequent access  - **Cold**: Archival only. **Use Hot** unless you're doing backup/archive pipelines. |

---

### 📁 Azure Files

| Option                     | Meaning                                                                                             |
|---------------------------|-----------------------------------------------------------------------------------------------------|
| ✅ Enable large file shares | Needed for storing very large files via Azure Files (not Blob/ADLS). Useful in file-server migrations. Not relevant to ADLS pipelines. Leave **OFF** unless explicitly needed. |

---

### 🔄 Real-Life SFTP Use Case Clarified

Imagine this:

🧑‍💼 **Vendor A** can only send files through traditional SFTP.  
📁 Previously, you hosted an **on-prem SFTP server** to receive the files.

Now with **"Enable SFTP" on ADLS**, that whole setup simplifies:

>Vendor A → (SFTP) → ADLS Gen2 (SFTP-enabled)

✅ No need for separate server  
✅ Secure file transfer directly into your Azure storage  
✅ Can automate further processing using ADF after file lands  

💡 You still control **authentication, permissions, and folder structure** using Azure RBAC or Access Control Lists.

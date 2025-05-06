# 🔁 LRM Framework: Environment Setup

## 🔹 Learned

- Created core resources for the COVID-19 ADF project: ADF, ADLS, Blob, and Azure SQL DB.
- Understood advanced ADLS settings: security, namespace, access protocols, and storage tiering.

---

## 🔍 Reflect

1. **Why does ADLS Gen2 need hierarchical namespace?**
   - It enables folder/file structure and analytics-specific features like ACLs—vital for Big Data.

2. **Why might someone enable SFTP in ADLS?**
   - To allow 3rd-party systems to push data using legacy secure protocols, avoiding external SFTP servers.

3. **What happens if secure transfer is off?**
   - You risk exposing your data via unencrypted HTTP—a huge security risk.

---

## 🧠 Master

✅ **Real Scenario**  
Your team receives data from a healthcare vendor who only supports SFTP. By enabling SFTP on ADLS, you avoid setting up and managing a separate on-prem SFTP server.

✅ **Interview Questions**

**1. What’s the purpose of enabling hierarchical namespace in ADLS Gen2?**  
– It enables directory-like structures, file-level ACLs, and big data analytics features.

**2. When would you enable SFTP access in ADLS Gen2?**  
– When legacy systems need to push data securely via SFTP without needing your own SFTP server.

**3. Why is ‘Require secure transfer’ critical in production setups?**  
– It forces all data transfers to use HTTPS, preventing data leakage or MITM attacks.

✅ **Summary**

- Treat storage setup not as a formality—but as **data architecture groundwork**.
- Security and protocol decisions affect your **entire pipeline flow and compliance** posture.

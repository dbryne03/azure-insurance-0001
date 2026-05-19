# azure-insurance-0001

Insurance data migration and validation pipeline on Microsoft Azure.

**Live output:** [Validation Dashboard](#) · [Reconciliation Reports](#)  
**Portfolio:** [davidbryneadedeji.com/docs/projects/azure](https://davidbryneadedeji.com/docs/projects/azure)

---

Infrastructure is deployed and runs entirely on Microsoft Azure, provisioned via Pulumi. Source code is version-controlled here; live outputs are accessible via the links above.

A Technical Design Document is available on request at [davidbryneadedeji.com](https://davidbryneadedeji.com).

## Stack

| Layer | Technology |
|:---|:---|
| Source DB | Azure Database for PostgreSQL |
| SFTP | Azure Container Apps (atmoz/sftp) |
| Orchestration | Azure Data Factory |
| Landing Zone | Azure Data Lake Storage Gen2 |
| Target DB | Azure SQL Database |
| Validation Engine | Azure Functions (Python 3.12) |
| Comparison Logic | T-SQL Stored Procedures |
| Secrets | Azure Key Vault |
| IaC | Pulumi (TypeScript) |
| CI/CD | GitHub Actions |

## Structure

```
validation/      Azure Function — SHA-256 hash engine (Python)
sql/
  schema/        Table DDL — policyholders, policies, claims, broker_submissions
  procedures/    T-SQL stored procedures — hash generation and comparison
  reconciliation/ Reconciliation table DDL
adf/
  pipelines/     ADF pipeline JSON definitions
  linked_services/ ADF linked service templates
seed/            Synthetic personal data generator (Faker)
infra/           Pulumi TypeScript — Azure infrastructure
.github/
  workflows/     CI/CD
```

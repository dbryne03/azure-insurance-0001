# azure-insurance-0001

Insurance data migration and validation pipeline on Microsoft Azure.

**Sources:** Azure Database for PostgreSQL (3 tables) · SFTP broker submissions (CSV)  
**Stack:** Azure Data Factory · ADLS Gen2 · Azure SQL · Azure Functions · Azure Container Apps · Azure Key Vault · Pulumi (TypeScript)

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
seed/            Synthetic PII data generator (Faker)
infra/           Pulumi TypeScript — Azure infrastructure
.github/
  workflows/     CI/CD
```

## Setup

```bash
cp .env.example .env
# populate secrets

# Pulumi
cd infra && npm install && pulumi up

# Seed synthetic data
cd seed && pip install -r requirements.txt && python generate.py

# Validation function (local testing)
cd validation && pip install -r requirements.txt
```

## Environment Variables

See `.env.example` for required configuration.

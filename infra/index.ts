import * as pulumi from "@pulumi/pulumi";
import * as azure from "@pulumi/azure-native";

const config = new pulumi.Config();
const location = azure.config.location ?? "uksouth";

// ── Resource Group ────────────────────────────────────────────────────────────

const rg = new azure.resources.ResourceGroup("insurance-rg", {
    location,
    resourceGroupName: "insurance-pipeline-rg",
});

// ── Key Vault ─────────────────────────────────────────────────────────────────

const keyVault = new azure.keyvault.Vault("key-vault", {
    resourceGroupName: rg.name,
    location,
    vaultName: "insurance-kv",
    properties: {
        sku: { family: "A", name: "standard" },
        tenantId: config.require("tenantId"),
        enableSoftDelete: true,
        // TODO: add access policies for ADF managed identity, Function App
    },
});

// ── Storage — ADLS Gen2 ───────────────────────────────────────────────────────

const storageAccount = new azure.storage.StorageAccount("adls", {
    resourceGroupName: rg.name,
    location,
    accountName: "insurancedatalake",
    sku: { name: "Standard_LRS" },
    kind: "StorageV2",
    isHnsEnabled: true, // hierarchical namespace — ADLS Gen2
});

const rawContainer = new azure.storage.BlobContainer("raw", {
    resourceGroupName: rg.name,
    accountName: storageAccount.name,
    containerName: "raw",
    publicAccess: "None",
});

// ── Azure Database for PostgreSQL ─────────────────────────────────────────────

const postgres = new azure.dbforpostgresql.Server("postgres", {
    resourceGroupName: rg.name,
    location,
    serverName: "insurance-postgres",
    // TODO: configure sku, storage, admin credentials via Key Vault
});

// ── Azure SQL Database ────────────────────────────────────────────────────────

const sqlServer = new azure.sql.Server("sql-server", {
    resourceGroupName: rg.name,
    location,
    serverName: "insurance-sql",
    // TODO: configure admin credentials via Key Vault
});

const sqlDb = new azure.sql.Database("sql-db", {
    resourceGroupName: rg.name,
    serverName: sqlServer.name,
    databaseName: "insurance",
    location,
    sku: { name: "S0", tier: "Standard" },
});

// ── Azure Container Apps — SFTP ───────────────────────────────────────────────
// TODO: provision Container App environment and SFTP Container App (atmoz/sftp)

// ── Azure Function App ────────────────────────────────────────────────────────
// TODO: provision Function App (Python 3.12), App Service Plan, storage account

// ── Azure Data Factory ────────────────────────────────────────────────────────

const adf = new azure.datafactory.Factory("adf", {
    resourceGroupName: rg.name,
    location,
    factoryName: "insurance-adf",
    identity: { type: "SystemAssigned" },
});

// ── Exports ───────────────────────────────────────────────────────────────────

export const resourceGroupName = rg.name;
export const storageAccountName = storageAccount.name;
export const sqlServerName = sqlServer.name;
export const adfName = adf.name;
export const keyVaultName = keyVault.name;

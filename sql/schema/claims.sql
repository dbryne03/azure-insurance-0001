CREATE TABLE dbo.claims (
    id                  INT             IDENTITY(1,1) PRIMARY KEY,
    policy_id           INT             NOT NULL REFERENCES dbo.policies(id),
    claim_reference     NVARCHAR(50)    NOT NULL UNIQUE,
    incident_date       DATE            NOT NULL,
    description         NVARCHAR(1000)  NOT NULL,
    settlement_amount   DECIMAL(12,2)   NULL,
    status              NVARCHAR(20)    NOT NULL,
    created_at          DATETIME2       NOT NULL DEFAULT GETUTCDATE(),
    updated_at          DATETIME2       NOT NULL DEFAULT GETUTCDATE()
);

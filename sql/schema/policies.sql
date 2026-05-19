CREATE TABLE dbo.policies (
    id                  INT             IDENTITY(1,1) PRIMARY KEY,
    policyholder_id     INT             NOT NULL REFERENCES dbo.policyholders(id),
    policy_number       NVARCHAR(50)    NOT NULL UNIQUE,
    product_type        NVARCHAR(50)    NOT NULL,
    inception_date      DATE            NOT NULL,
    expiry_date         DATE            NOT NULL,
    annual_premium      DECIMAL(10,2)   NOT NULL,
    status              NVARCHAR(20)    NOT NULL,
    created_at          DATETIME2       NOT NULL DEFAULT GETUTCDATE(),
    updated_at          DATETIME2       NOT NULL DEFAULT GETUTCDATE()
);

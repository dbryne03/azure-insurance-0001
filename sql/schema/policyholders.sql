CREATE TABLE dbo.policyholders (
    id                INT             IDENTITY(1,1) PRIMARY KEY,
    full_name         NVARCHAR(255)   NOT NULL,
    date_of_birth     DATE            NOT NULL,
    ni_number         NVARCHAR(10)    NOT NULL,
    address_line_1    NVARCHAR(255)   NOT NULL,
    city              NVARCHAR(100)   NOT NULL,
    postcode          NVARCHAR(10)    NOT NULL,
    email             NVARCHAR(255)   NOT NULL,
    telephone         NVARCHAR(20)    NOT NULL,
    created_at        DATETIME2       NOT NULL DEFAULT GETUTCDATE(),
    updated_at        DATETIME2       NOT NULL DEFAULT GETUTCDATE()
);

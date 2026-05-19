CREATE TABLE dbo.validation_mismatch (
    mismatch_id         UNIQUEIDENTIFIER    DEFAULT NEWID() PRIMARY KEY,
    run_id              UNIQUEIDENTIFIER    NOT NULL REFERENCES dbo.validation_run(run_id),
    table_name          NVARCHAR(100)       NOT NULL,
    primary_key_value   NVARCHAR(255)       NOT NULL,
    source_hash         NVARCHAR(64)        NOT NULL,
    target_hash         NVARCHAR(64)        NOT NULL,
    differing_columns   NVARCHAR(MAX)       NULL -- JSON array of column names
);

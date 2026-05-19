CREATE TABLE dbo.validation_run (
    run_id              UNIQUEIDENTIFIER    DEFAULT NEWID() PRIMARY KEY,
    run_timestamp       DATETIME2           NOT NULL DEFAULT GETUTCDATE(),
    tables_validated    INT                 NOT NULL,
    total_rows          INT                 NOT NULL,
    pass_rate           DECIMAL(5,4)        NOT NULL,
    status              NVARCHAR(20)        NOT NULL -- 'passed' | 'failed' | 'partial'
);

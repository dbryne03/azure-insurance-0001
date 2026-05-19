CREATE TABLE dbo.validation_result (
    result_id           UNIQUEIDENTIFIER    DEFAULT NEWID() PRIMARY KEY,
    run_id              UNIQUEIDENTIFIER    NOT NULL REFERENCES dbo.validation_run(run_id),
    table_name          NVARCHAR(100)       NOT NULL,
    row_count           INT                 NOT NULL,
    matched             INT                 NOT NULL,
    mismatched          INT                 NOT NULL,
    missing_in_target   INT                 NOT NULL,
    missing_in_source   INT                 NOT NULL
);

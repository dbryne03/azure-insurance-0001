-- Compares source and target hash staging tables and writes results
-- to the reconciliation tables.
CREATE OR ALTER PROCEDURE dbo.usp_compare_hashes
    @run_id         UNIQUEIDENTIFIER,
    @table_name     NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    -- TODO: join source_hashes and target_hashes staging tables on pk
    -- Insert matched, mismatched, and missing rows into:
    --   dbo.validation_result  (summary per table)
    --   dbo.validation_mismatch (row-level detail for mismatches)

    RAISERROR('Not implemented', 16, 1);
END;

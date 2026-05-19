-- Generates SHA-256 row signatures for a given table.
-- Called by the Azure Function per table before comparison.
-- TODO: implement dynamic column concatenation using HASHBYTES
CREATE OR ALTER PROCEDURE dbo.usp_generate_hashes
    @table_name     NVARCHAR(100),
    @pk_column      NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    -- TODO: build dynamic SQL to concatenate all columns in sorted order
    -- and compute HASHBYTES('SHA2_256', ...) per row
    -- write results to a staging hash table for comparison
    RAISERROR('Not implemented', 16, 1);
END;

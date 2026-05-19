CREATE TABLE dbo.broker_submissions (
    id                  INT             IDENTITY(1,1) PRIMARY KEY,
    submission_ref      NVARCHAR(50)    NOT NULL UNIQUE,
    broker_code         NVARCHAR(20)    NOT NULL,
    applicant_name      NVARCHAR(255)   NOT NULL,
    applicant_dob       DATE            NOT NULL,
    cover_type          NVARCHAR(50)    NOT NULL,
    premium_band        NVARCHAR(20)    NOT NULL,
    submission_date     DATE            NOT NULL,
    source_file         NVARCHAR(255)   NOT NULL,
    loaded_at           DATETIME2       NOT NULL DEFAULT GETUTCDATE()
);

CREATE TABLE [dbo].[issuerChg] (
    [id]           INT            NOT NULL,
    [code]         NVARCHAR (128) NOT NULL,
    [sysVersionId] ROWVERSION     NOT NULL,
    [sysAppName]   NVARCHAR (255) NOT NULL,
    [sysUserName]  NVARCHAR (255) NOT NULL,
    [sysStartTime] DATETIME2 (7)  NOT NULL,
    [sysEndTime]   DATETIME2 (7)  NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_issuerChg]
    ON [dbo].[issuerChg]([sysEndTime] ASC, [sysStartTime] ASC);


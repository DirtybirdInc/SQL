CREATE TABLE [dbo].[quoteChg] (
    [id]             INT            NOT NULL,
    [code]           NVARCHAR (128) NOT NULL,
    [issueId]        INT            NOT NULL,
    [firstTradeDate] DATE           NOT NULL,
    [delistDate]     DATE           NULL,
    [sysVersionId]   ROWVERSION     NOT NULL,
    [sysAppName]     NVARCHAR (255) NOT NULL,
    [sysUserName]    NVARCHAR (255) NOT NULL,
    [sysStartTime]   DATETIME2 (7)  NOT NULL,
    [sysEndTime]     DATETIME2 (7)  NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_quoteChg]
    ON [dbo].[quoteChg]([sysEndTime] ASC, [sysStartTime] ASC);


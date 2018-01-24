CREATE TABLE [dbo].[quotePriceChg] (
    [quoteId]      INT            NOT NULL,
    [date]         DATE           NOT NULL,
    [close_]       FLOAT (53)     NULL,
    [sysVersionId] ROWVERSION     NOT NULL,
    [sysAppName]   NVARCHAR (255) NOT NULL,
    [sysUserName]  NVARCHAR (255) NOT NULL,
    [sysStartTime] DATETIME2 (7)  NOT NULL,
    [sysEndTime]   DATETIME2 (7)  NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_quotePriceChg]
    ON [dbo].[quotePriceChg]([sysEndTime] ASC, [sysStartTime] ASC);


CREATE TABLE [dbo].[portfolioConsChg] (
    [portfolioId]  INT            NOT NULL,
    [quoteId]      INT            NOT NULL,
    [validFrom]    DATE           NOT NULL,
    [validTo]      DATE           NOT NULL,
    [sysVersionId] ROWVERSION     NOT NULL,
    [sysAppName]   NVARCHAR (255) NOT NULL,
    [sysUserName]  NVARCHAR (255) NOT NULL,
    [sysStartTime] DATETIME2 (7)  NOT NULL,
    [sysEndTime]   DATETIME2 (7)  NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_portfolioConsChg]
    ON [dbo].[portfolioConsChg]([sysEndTime] ASC, [sysStartTime] ASC);


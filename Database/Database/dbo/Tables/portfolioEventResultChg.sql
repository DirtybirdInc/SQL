CREATE TABLE [dbo].[portfolioEventResultChg] (
    [portfolioEventId]    INT            NOT NULL,
    [priceCurrencyCode]   CHAR (3)       NULL,
    [closePrice]          FLOAT (53)     NULL,
    [closeCurrencyRate]   FLOAT (53)     NULL,
    [closeShareFactor]    FLOAT (53)     NULL,
    [closeFreefloat]      FLOAT (53)     NULL,
    [openShareFactor]     FLOAT (53)     NULL,
    [openFreefloatFactor] FLOAT (53)     NULL,
    [openPrice]           FLOAT (53)     NULL,
    [sysVersionId]        ROWVERSION     NOT NULL,
    [sysAppName]          NVARCHAR (255) NOT NULL,
    [sysUserName]         NVARCHAR (255) NOT NULL,
    [sysStartTime]        DATETIME2 (7)  NOT NULL,
    [sysEndTime]          DATETIME2 (7)  NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_portfolioEventResultChg]
    ON [dbo].[portfolioEventResultChg]([sysEndTime] ASC, [sysStartTime] ASC);


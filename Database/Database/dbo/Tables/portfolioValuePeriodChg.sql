CREATE TABLE [dbo].[portfolioValuePeriodChg] (
    [portfolioId]  INT            NOT NULL,
    [date]         DATE           NOT NULL,
    [dateUTC]      DATETIME       NOT NULL,
    [nextDate]     DATE           NOT NULL,
    [nextDateUTC]  DATETIME       NOT NULL,
    [prevDate]     DATE           NOT NULL,
    [prevDateUTC]  DATETIME       NOT NULL,
    [sysVersionId] ROWVERSION     NOT NULL,
    [sysAppName]   NVARCHAR (128) NOT NULL,
    [sysUserName]  NVARCHAR (128) NOT NULL,
    [sysStartTime] DATETIME2 (7)  NOT NULL,
    [sysEndTime]   DATETIME2 (7)  NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_portfolioValuePeriodChg]
    ON [dbo].[portfolioValuePeriodChg]([sysEndTime] ASC, [sysStartTime] ASC);


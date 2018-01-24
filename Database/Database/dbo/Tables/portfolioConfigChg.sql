CREATE TABLE [dbo].[portfolioConfigChg] (
    [portfolioId]           INT            NOT NULL,
    [calculationCalendarId] INT            NOT NULL,
    [reviewCalendarId]      INT            NOT NULL,
    [currencyRateTypeId]    INT            NOT NULL,
    [valuationTimeZone]     NVARCHAR (128) NOT NULL,
    [validFrom]             DATE           NOT NULL,
    [validTo]               DATE           NOT NULL,
    [sysVersionId]          ROWVERSION     NOT NULL,
    [sysAppName]            NVARCHAR (255) NOT NULL,
    [sysUserName]           NVARCHAR (255) NOT NULL,
    [sysStartTime]          DATETIME2 (7)  NOT NULL,
    [sysEndTime]            DATETIME2 (7)  NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_portfolioConfigChg]
    ON [dbo].[portfolioConfigChg]([sysEndTime] ASC, [sysStartTime] ASC);


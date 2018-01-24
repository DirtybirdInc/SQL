CREATE TABLE [dbo].[currencyRateChg] (
    [currencyRateTypeId] INT            NOT NULL,
    [toCode]             CHAR (3)       NOT NULL,
    [date]               DATE           NOT NULL,
    [rate]               FLOAT (53)     NOT NULL,
    [sysVersionId]       ROWVERSION     NOT NULL,
    [sysAppName]         NVARCHAR (255) NOT NULL,
    [sysUserName]        NVARCHAR (255) NOT NULL,
    [sysStartTime]       DATETIME2 (7)  NOT NULL,
    [sysEndTime]         DATETIME2 (7)  NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_currencyRateChg]
    ON [dbo].[currencyRateChg]([sysEndTime] ASC, [sysStartTime] ASC);


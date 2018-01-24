CREATE TABLE [dbo].[currencyRateTypeChg] (
    [id]           INT            NOT NULL,
    [code]         NVARCHAR (128) NOT NULL,
    [baseCode]     CHAR (3)       NOT NULL,
    [name]         NVARCHAR (128) NOT NULL,
    [timeZone]     NVARCHAR (128) NOT NULL,
    [descript]     NVARCHAR (255) NOT NULL,
    [validFrom]    DATE           NOT NULL,
    [validTo]      DATE           NOT NULL,
    [sysVersionId] ROWVERSION     NOT NULL,
    [sysAppName]   NVARCHAR (128) NOT NULL,
    [sysUserName]  NVARCHAR (128) NOT NULL,
    [sysStartTime] DATETIME2 (7)  NOT NULL,
    [sysEndTime]   DATETIME2 (7)  NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_currencyRateTypeChg]
    ON [dbo].[currencyRateTypeChg]([sysEndTime] ASC, [sysStartTime] ASC);


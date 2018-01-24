CREATE TABLE [dbo].[exchangeDescriptChg] (
    [exchangeId]   INT            NOT NULL,
    [name]         NVARCHAR (255) NOT NULL,
    [countryCode]  CHAR (2)       NOT NULL,
    [timeZone]     VARCHAR (55)   NOT NULL,
    [validFrom]    DATE           NOT NULL,
    [validTo]      DATE           NOT NULL,
    [sysVersionId] ROWVERSION     NOT NULL,
    [sysAppName]   NVARCHAR (255) NOT NULL,
    [sysUserName]  NVARCHAR (255) NOT NULL,
    [sysStartTime] DATETIME2 (7)  NOT NULL,
    [sysEndTime]   DATETIME2 (7)  NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_exchangeDescriptChg]
    ON [dbo].[exchangeDescriptChg]([sysEndTime] ASC, [sysStartTime] ASC);


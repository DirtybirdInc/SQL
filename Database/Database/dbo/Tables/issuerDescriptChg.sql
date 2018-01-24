CREATE TABLE [dbo].[issuerDescriptChg] (
    [issuerId]     INT            NOT NULL,
    [name]         NVARCHAR (255) NOT NULL,
    [industryCode] VARCHAR (25)   NULL,
    [countryCode]  CHAR (2)       NULL,
    [validFrom]    DATE           NOT NULL,
    [validTo]      DATE           NOT NULL,
    [sysVersionId] ROWVERSION     NOT NULL,
    [sysAppName]   NVARCHAR (255) NOT NULL,
    [sysUserName]  NVARCHAR (255) NOT NULL,
    [sysStartTime] DATETIME2 (7)  NOT NULL,
    [sysEndTime]   DATETIME2 (7)  NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_issuerDescriptChg]
    ON [dbo].[issuerDescriptChg]([sysEndTime] ASC, [sysStartTime] ASC);


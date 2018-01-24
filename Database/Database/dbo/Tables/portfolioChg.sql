CREATE TABLE [dbo].[portfolioChg] (
    [id]           INT            NOT NULL,
    [code]         NVARCHAR (128) NOT NULL,
    [name]         NVARCHAR (128) NOT NULL,
    [validFrom]    DATE           NOT NULL,
    [validTo]      DATE           NOT NULL,
    [sysVersionId] ROWVERSION     NOT NULL,
    [sysAppName]   NVARCHAR (255) NOT NULL,
    [sysUserName]  NVARCHAR (255) NOT NULL,
    [sysStartTime] DATETIME2 (7)  NOT NULL,
    [sysEndTime]   DATETIME2 (7)  NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_portfolioChg]
    ON [dbo].[portfolioChg]([sysEndTime] ASC, [sysStartTime] ASC);


CREATE TABLE [dbo].[issueDescriptChg] (
    [issueId]      INT            NOT NULL,
    [name]         NVARCHAR (255) NOT NULL,
    [ISIN]         CHAR (12)      NULL,
    [validFrom]    DATE           NOT NULL,
    [validTo]      DATE           NOT NULL,
    [sysVersionId] ROWVERSION     NOT NULL,
    [sysAppName]   NVARCHAR (255) NOT NULL,
    [sysUserName]  NVARCHAR (255) NOT NULL,
    [sysStartTime] DATETIME2 (7)  NOT NULL,
    [sysEndTime]   DATETIME2 (7)  NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_issueDescriptChg]
    ON [dbo].[issueDescriptChg]([sysEndTime] ASC, [sysStartTime] ASC);


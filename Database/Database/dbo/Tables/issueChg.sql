CREATE TABLE [dbo].[issueChg] (
    [id]           INT            NOT NULL,
    [code]         NVARCHAR (128) NOT NULL,
    [issuerId]     INT            NOT NULL,
    [type]         NVARCHAR (128) NOT NULL,
    [class]        NVARCHAR (128) NOT NULL,
    [sysVersionId] ROWVERSION     NOT NULL,
    [sysAppName]   NVARCHAR (255) NOT NULL,
    [sysUserName]  NVARCHAR (255) NOT NULL,
    [sysStartTime] DATETIME2 (7)  NOT NULL,
    [sysEndTime]   DATETIME2 (7)  NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_issueChg]
    ON [dbo].[issueChg]([sysEndTime] ASC, [sysStartTime] ASC);


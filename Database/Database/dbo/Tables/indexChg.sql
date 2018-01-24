CREATE TABLE [dbo].[indexChg] (
    [id]           INT            NOT NULL,
    [code]         NVARCHAR (128) NOT NULL,
    [portfolioId]  INT            NOT NULL,
    [baseDate]     DATE           NOT NULL,
    [baseValue]    FLOAT (53)     NOT NULL,
    [launchDate]   DATE           NOT NULL,
    [delistDate]   DATE           NOT NULL,
    [sysVersionId] ROWVERSION     NOT NULL,
    [sysAppName]   NVARCHAR (255) NOT NULL,
    [sysUserName]  NVARCHAR (255) NOT NULL,
    [sysStartTime] DATETIME2 (7)  NOT NULL,
    [sysEndTime]   DATETIME2 (7)  NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_indexChg]
    ON [dbo].[indexChg]([sysEndTime] ASC, [sysStartTime] ASC);


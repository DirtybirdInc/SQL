CREATE TABLE [dbo].[portfolioValueChg] (
    [portfolioId]  INT            NOT NULL,
    [date]         DATE           NOT NULL,
    [openMcap]     FLOAT (53)     NOT NULL,
    [closeMcap]    FLOAT (53)     NOT NULL,
    [sysVersionId] ROWVERSION     NOT NULL,
    [sysAppName]   NVARCHAR (255) NOT NULL,
    [sysUserName]  NVARCHAR (255) NOT NULL,
    [sysStartTime] DATETIME2 (7)  NOT NULL,
    [sysEndTime]   DATETIME2 (7)  NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_portfolioValueChg]
    ON [dbo].[portfolioValueChg]([sysEndTime] ASC, [sysStartTime] ASC);


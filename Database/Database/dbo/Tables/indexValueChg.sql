CREATE TABLE [dbo].[indexValueChg] (
    [indexId]       INT            NOT NULL,
    [date]          DATE           NOT NULL,
    [cumCostFactor] FLOAT (53)     NOT NULL,
    [value]         FLOAT (53)     NOT NULL,
    [sysVersionId]  ROWVERSION     NOT NULL,
    [sysAppName]    NVARCHAR (255) NOT NULL,
    [sysUserName]   NVARCHAR (255) NOT NULL,
    [sysStartTime]  DATETIME2 (7)  NOT NULL,
    [sysEndTime]    DATETIME2 (7)  NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_indexValueChg]
    ON [dbo].[indexValueChg]([sysEndTime] ASC, [sysStartTime] ASC);


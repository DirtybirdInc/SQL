CREATE TABLE [dbo].[reviewPeriodChg] (
    [id]               INT            NOT NULL,
    [reviewCalendarId] INT            NOT NULL,
    [validFrom]        DATE           NOT NULL,
    [validTo]          DATE           NOT NULL,
    [sysVersionId]     ROWVERSION     NOT NULL,
    [sysAppName]       NVARCHAR (255) NOT NULL,
    [sysUserName]      NVARCHAR (255) NOT NULL,
    [sysStartTime]     DATETIME2 (7)  NOT NULL,
    [sysEndTime]       DATETIME2 (7)  NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_reviewPeriodChg]
    ON [dbo].[reviewPeriodChg]([sysEndTime] ASC, [sysStartTime] ASC);


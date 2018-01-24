CREATE TABLE [dbo].[reviewCalendarChg] (
    [id]           INT            NOT NULL,
    [code]         NVARCHAR (128) NOT NULL,
    [name]         NVARCHAR (255) NOT NULL,
    [descript]     NVARCHAR (MAX) NULL,
    [sysVersionId] ROWVERSION     NOT NULL,
    [sysAppName]   NVARCHAR (255) NOT NULL,
    [sysUserName]  NVARCHAR (255) NOT NULL,
    [sysStartTime] DATETIME2 (7)  NOT NULL,
    [sysEndTime]   DATETIME2 (7)  NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_reviewCalendarChg]
    ON [dbo].[reviewCalendarChg]([sysEndTime] ASC, [sysStartTime] ASC);


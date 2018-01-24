CREATE TABLE [dbo].[calculationHolidayChg] (
    [calculationCalendarId] INT            NOT NULL,
    [date]                  DATE           NOT NULL,
    [descript]              NVARCHAR (255) NOT NULL,
    [sysVersionId]          ROWVERSION     NOT NULL,
    [sysAppName]            NVARCHAR (128) NOT NULL,
    [sysUserName]           NVARCHAR (128) NOT NULL,
    [sysStartTime]          DATETIME2 (7)  NOT NULL,
    [sysEndTime]            DATETIME2 (7)  NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_calculationHolidayChg]
    ON [dbo].[calculationHolidayChg]([sysEndTime] ASC, [sysStartTime] ASC);


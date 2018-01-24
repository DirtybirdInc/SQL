CREATE TABLE [dbo].[calculationCalendar] (
    [id]           INT                                         IDENTITY (1, 1) NOT NULL,
    [code]         NVARCHAR (128)                              NOT NULL,
    [name]         NVARCHAR (255)                              NOT NULL,
    [descript]     NVARCHAR (MAX)                              NOT NULL,
    [sysVersionId] ROWVERSION                                  NOT NULL,
    [sysAppName]   NVARCHAR (255)                              DEFAULT (app_name()) NOT NULL,
    [sysUserName]  NVARCHAR (255)                              DEFAULT (user_name()) NOT NULL,
    [sysStartTime] DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_calculationCalendar_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]   DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_calculationCalendar_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    UNIQUE NONCLUSTERED ([code] ASC),
    UNIQUE NONCLUSTERED ([name] ASC),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[calculationCalendarChg], DATA_CONSISTENCY_CHECK=ON));


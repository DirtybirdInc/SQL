CREATE TABLE [dbo].[reviewPeriod] (
    [id]               INT                                         IDENTITY (1, 1) NOT NULL,
    [reviewCalendarId] INT                                         NOT NULL,
    [validFrom]        DATE                                        NOT NULL,
    [validTo]          DATE                                        NOT NULL,
    [sysVersionId]     ROWVERSION                                  NOT NULL,
    [sysAppName]       NVARCHAR (255)                              CONSTRAINT [DF__reviewPer__sysAp__5F7E2DAC] DEFAULT (app_name()) NOT NULL,
    [sysUserName]      NVARCHAR (255)                              CONSTRAINT [DF__reviewPer__sysUs__607251E5] DEFAULT (user_name()) NOT NULL,
    [sysStartTime]     DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_reviewPeriod_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]       DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_reviewPeriod_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK_reviewPeriod] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_reviewPeriod_revieCalendar] FOREIGN KEY ([reviewCalendarId]) REFERENCES [dbo].[reviewCalendar] ([id]),
    CONSTRAINT [UQ_reviewPeriod] UNIQUE NONCLUSTERED ([reviewCalendarId] ASC, [validFrom] ASC),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[reviewPeriodChg], DATA_CONSISTENCY_CHECK=ON));


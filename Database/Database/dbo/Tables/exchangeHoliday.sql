CREATE TABLE [dbo].[exchangeHoliday] (
    [exchangeId]   INT                                         NOT NULL,
    [date]         DATE                                        NOT NULL,
    [descript]     NVARCHAR (255)                              NOT NULL,
    [sysVersionId] ROWVERSION                                  NOT NULL,
    [sysAppName]   NVARCHAR (128)                              DEFAULT (app_name()) NOT NULL,
    [sysUserName]  NVARCHAR (128)                              DEFAULT (suser_name()) NOT NULL,
    [sysStartTime] DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_exchangeHoliday_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]   DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_exchangeHoliday_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK_exchangeHoliday] PRIMARY KEY CLUSTERED ([date] ASC, [exchangeId] ASC),
    CONSTRAINT [FK_exchangeHoliday_exchange] FOREIGN KEY ([exchangeId]) REFERENCES [dbo].[exchange] ([id]),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[exchangeHolidayChg], DATA_CONSISTENCY_CHECK=ON));


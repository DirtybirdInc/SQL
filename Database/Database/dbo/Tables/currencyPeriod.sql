CREATE TABLE [dbo].[currencyPeriod] (
    [currencyRateTypeId] INT                                         NOT NULL,
    [date]               DATE                                        NOT NULL,
    [dateUTC]            DATETIME                                    NOT NULL,
    [nextDate]           DATE                                        NOT NULL,
    [nextDateUTC]        DATETIME                                    NOT NULL,
    [prevDate]           DATE                                        NOT NULL,
    [prevDateUTC]        DATETIME                                    NOT NULL,
    [sysVersionId]       ROWVERSION                                  NOT NULL,
    [sysAppName]         NVARCHAR (128)                              CONSTRAINT [DF__currencyP__sysAp__4AB81AF0] DEFAULT (app_name()) NOT NULL,
    [sysUserName]        NVARCHAR (128)                              CONSTRAINT [DF__currencyP__sysUs__4BAC3F29] DEFAULT (suser_name()) NOT NULL,
    [sysStartTime]       DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_currencyPeriod_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]         DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_currencyPeriod_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK_currencyPeriod] PRIMARY KEY CLUSTERED ([date] ASC, [currencyRateTypeId] ASC),
    CONSTRAINT [FK_currencyPeriod_currenyRateType] FOREIGN KEY ([currencyRateTypeId]) REFERENCES [dbo].[currencyRateType] ([id]),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[currencyPeriodChg], DATA_CONSISTENCY_CHECK=ON));


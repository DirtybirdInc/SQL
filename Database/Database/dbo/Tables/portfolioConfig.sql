CREATE TABLE [dbo].[portfolioConfig] (
    [portfolioId]           INT                                         NOT NULL,
    [calculationCalendarId] INT                                         NOT NULL,
    [reviewCalendarId]      INT                                         NOT NULL,
    [currencyRateTypeId]    INT                                         CONSTRAINT [DF_portfolioConfig_currencyRateTypeId] DEFAULT ((1)) NOT NULL,
    [valuationTimeZone]     NVARCHAR (128)                              NOT NULL,
    [validFrom]             DATE                                        NOT NULL,
    [validTo]               DATE                                        NOT NULL,
    [sysVersionId]          ROWVERSION                                  NOT NULL,
    [sysAppName]            NVARCHAR (255)                              CONSTRAINT [DF__portfolio__sysAp__2610A626] DEFAULT (app_name()) NOT NULL,
    [sysUserName]           NVARCHAR (255)                              CONSTRAINT [DF__portfolio__sysUs__2704CA5F] DEFAULT (user_name()) NOT NULL,
    [sysStartTime]          DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_portfolioConfig_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]            DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_portfolioConfig_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK_portfolioConfig] PRIMARY KEY CLUSTERED ([portfolioId] ASC, [validFrom] ASC),
    CONSTRAINT [CK_portfolioConfig] CHECK ((getdate() AT TIME ZONE [valuationTimeZone]) IS NOT NULL OR [valuationTimeZone] IS NULL),
    CONSTRAINT [FK_portfolioConfig_calculationCalendar] FOREIGN KEY ([calculationCalendarId]) REFERENCES [dbo].[calculationCalendar] ([id]),
    CONSTRAINT [FK_portfolioConfig_currencyRateType] FOREIGN KEY ([currencyRateTypeId]) REFERENCES [dbo].[currencyRateType] ([id]),
    CONSTRAINT [FK_portfolioConfig_portfolio] FOREIGN KEY ([portfolioId]) REFERENCES [dbo].[portfolio] ([id]),
    CONSTRAINT [FK_portfolioConfig_reviewCalendar] FOREIGN KEY ([reviewCalendarId]) REFERENCES [dbo].[reviewCalendar] ([id]),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[portfolioConfigChg], DATA_CONSISTENCY_CHECK=ON));


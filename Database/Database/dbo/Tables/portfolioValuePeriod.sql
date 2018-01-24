CREATE TABLE [dbo].[portfolioValuePeriod] (
    [portfolioId]  INT                                         NOT NULL,
    [date]         DATE                                        NOT NULL,
    [dateUTC]      DATETIME                                    NOT NULL,
    [nextDate]     DATE                                        NOT NULL,
    [nextDateUTC]  DATETIME                                    NOT NULL,
    [prevDate]     DATE                                        CONSTRAINT [DF_portfolioValuePeriod_prevDate] DEFAULT (getdate()) NOT NULL,
    [prevDateUTC]  DATETIME                                    CONSTRAINT [DF_portfolioValuePeriod_prevDateUTC] DEFAULT (getdate()) NOT NULL,
    [sysVersionId] ROWVERSION                                  NOT NULL,
    [sysAppName]   NVARCHAR (128)                              CONSTRAINT [DF__portfolio__sysAp__1F2E9E6D] DEFAULT (app_name()) NOT NULL,
    [sysUserName]  NVARCHAR (128)                              CONSTRAINT [DF__portfolio__sysUs__2022C2A6] DEFAULT (suser_name()) NOT NULL,
    [sysStartTime] DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_portfolioValuePeriod_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]   DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_portfolioValuePeriod_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK_portfolioValuePeriod] PRIMARY KEY CLUSTERED ([portfolioId] ASC, [date] ASC),
    CONSTRAINT [FK_portfolioValuePeriod_portfolio] FOREIGN KEY ([portfolioId]) REFERENCES [dbo].[portfolio] ([id]),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[portfolioValuePeriodChg], DATA_CONSISTENCY_CHECK=ON));


GO
CREATE NONCLUSTERED INDEX [UIX_portfolioValuePeriod]
    ON [dbo].[portfolioValuePeriod]([date] ASC, [prevDate] ASC, [portfolioId] ASC)
    INCLUDE([dateUTC], [nextDate], [nextDateUTC], [prevDateUTC]);


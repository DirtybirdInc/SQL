CREATE TABLE [dbo].[exchangePeriod] (
    [exchangeId]   INT                                         NOT NULL,
    [date]         DATE                                        NOT NULL,
    [dateUTC]      DATETIME                                    CONSTRAINT [DF_exchangePeriod_dateUTC] DEFAULT (getdate()) NOT NULL,
    [nextDate]     DATE                                        NOT NULL,
    [nextDateUTC]  DATETIME                                    CONSTRAINT [DF_exchangePeriod_nextDateUTC] DEFAULT (getdate()) NOT NULL,
    [sysVersionId] ROWVERSION                                  NOT NULL,
    [sysAppName]   NVARCHAR (128)                              CONSTRAINT [DF__exchangeP__sysAp__4AB81AF0] DEFAULT (app_name()) NOT NULL,
    [sysUserName]  NVARCHAR (128)                              CONSTRAINT [DF__exchangeP__sysUs__4BAC3F29] DEFAULT (suser_name()) NOT NULL,
    [sysStartTime] DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_exchangePeriod_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]   DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_exchangePeriod_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK_exchangePeriod] PRIMARY KEY CLUSTERED ([date] ASC, [exchangeId] ASC),
    CONSTRAINT [FK_exchangePeriod_exchange] FOREIGN KEY ([exchangeId]) REFERENCES [dbo].[exchange] ([id]),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[exchangePeriodChg], DATA_CONSISTENCY_CHECK=ON));


GO
CREATE NONCLUSTERED INDEX [IX_exchangePeriod]
    ON [dbo].[exchangePeriod]([dateUTC] ASC, [nextDateUTC] ASC)
    INCLUDE([exchangeId], [date]);


GO
CREATE NONCLUSTERED INDEX [UIX_exchangePeriod]
    ON [dbo].[exchangePeriod]([exchangeId] ASC, [dateUTC] ASC, [nextDateUTC] ASC);


CREATE TABLE [dbo].[currencyRate] (
    [currencyRateTypeId] INT                                         CONSTRAINT [DF_currencyRate_currencyRateType] DEFAULT ((1)) NOT NULL,
    [toCode]             CHAR (3)                                    NOT NULL,
    [date]               DATE                                        NOT NULL,
    [rate]               FLOAT (53)                                  NOT NULL,
    [sysVersionId]       ROWVERSION                                  NOT NULL,
    [sysAppName]         NVARCHAR (255)                              CONSTRAINT [DF_currencyRate_sysAppName] DEFAULT (app_name()) NOT NULL,
    [sysUserName]        NVARCHAR (255)                              CONSTRAINT [DF_currencyRate_sysUserName] DEFAULT (suser_name()) NOT NULL,
    [sysStartTime]       DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_currencyRate_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]         DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_currencyRate_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK_currencyRate] PRIMARY KEY CLUSTERED ([currencyRateTypeId] ASC, [date] ASC, [toCode] ASC),
    CONSTRAINT [FK_currencyRate_currencyRateType] FOREIGN KEY ([currencyRateTypeId]) REFERENCES [dbo].[currencyRateType] ([id]),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[currencyRateChg], DATA_CONSISTENCY_CHECK=ON));


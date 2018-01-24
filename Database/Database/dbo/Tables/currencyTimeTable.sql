CREATE TABLE [dbo].[currencyTimeTable] (
    [currencyRateTypeId] INT                                         NOT NULL,
    [weekDay]            NVARCHAR (12)                               NOT NULL,
    [closeTimeLocal]     TIME (7)                                    NOT NULL,
    [validFrom]          DATE                                        NOT NULL,
    [validTo]            DATE                                        NOT NULL,
    [sysVersionId]       ROWVERSION                                  NOT NULL,
    [sysAppName]         NVARCHAR (255)                              CONSTRAINT [DF__currencyT__sysAp__3D2915A8] DEFAULT (app_name()) NOT NULL,
    [sysUserName]        NVARCHAR (255)                              CONSTRAINT [DF__currencyT__sysUs__3E1D39E1] DEFAULT (suser_name()) NOT NULL,
    [sysStartTime]       DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_currencyTimeTable_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]         DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_currencyTimeTable_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK_currencyTimeTable] PRIMARY KEY CLUSTERED ([currencyRateTypeId] ASC, [weekDay] ASC, [validFrom] ASC),
    CONSTRAINT [CK_currencyTimeTable] CHECK ([weekDay]='Sunday' OR [weekDay]='Saturday' OR [weekDay]='Friday' OR [weekDay]='Thursday' OR [weekDay]='Wednesday' OR [weekDay]='Tuesday' OR [weekDay]='Monday'),
    CONSTRAINT [FK__currencyT__excha__3B40CD36] FOREIGN KEY ([currencyRateTypeId]) REFERENCES [dbo].[currencyRateType] ([id]),
    CONSTRAINT [UQ__currency__F2694849D40D825A] UNIQUE NONCLUSTERED ([currencyRateTypeId] ASC, [weekDay] ASC, [validFrom] ASC),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[currencyTimeTableChg], DATA_CONSISTENCY_CHECK=ON));


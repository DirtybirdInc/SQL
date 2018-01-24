CREATE TABLE [dbo].[exchangeTimeTable] (
    [exchangeId]     INT                                         NOT NULL,
    [weekDay]        NVARCHAR (12)                               NOT NULL,
    [closeTimeLocal] TIME (7)                                    NOT NULL,
    [validFrom]      DATE                                        NOT NULL,
    [validTo]        DATE                                        NOT NULL,
    [sysVersionId]   ROWVERSION                                  NOT NULL,
    [sysAppName]     NVARCHAR (255)                              CONSTRAINT [DF__exchangeT__sysAp__3D2915A8] DEFAULT (app_name()) NOT NULL,
    [sysUserName]    NVARCHAR (255)                              CONSTRAINT [DF__exchangeT__sysUs__3E1D39E1] DEFAULT (suser_name()) NOT NULL,
    [sysStartTime]   DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_exchangeTimeTable_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]     DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_exchangeTimeTable_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK_exchangeTimeTable] PRIMARY KEY CLUSTERED ([exchangeId] ASC, [weekDay] ASC, [validFrom] ASC),
    CONSTRAINT [CK_exchangeTimeTable] CHECK ([weekDay]='Sunday' OR [weekDay]='Saturday' OR [weekDay]='Friday' OR [weekDay]='Thursday' OR [weekDay]='Wednesday' OR [weekDay]='Tuesday' OR [weekDay]='Monday'),
    CONSTRAINT [FK_exchangeTimeTable_exchange] FOREIGN KEY ([exchangeId]) REFERENCES [dbo].[exchange] ([id]),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[exchangeTimeTableChg], DATA_CONSISTENCY_CHECK=ON));


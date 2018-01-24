CREATE TABLE [dbo].[portfolioTimeTable] (
    [portfolioId]        INT                                         NOT NULL,
    [weekDay]            NVARCHAR (12)                               NOT NULL,
    [valuationTimeLocal] TIME (7)                                    NOT NULL,
    [validFrom]          DATE                                        NOT NULL,
    [validTo]            DATE                                        NOT NULL,
    [sysVersionId]       ROWVERSION                                  NOT NULL,
    [sysAppName]         NVARCHAR (255)                              CONSTRAINT [DF__portfolioT__sysAp__3D2915A8] DEFAULT (app_name()) NOT NULL,
    [sysUserName]        NVARCHAR (255)                              CONSTRAINT [DF__portfolioT__sysUs__3E1D39E1] DEFAULT (suser_name()) NOT NULL,
    [sysStartTime]       DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_portfolioTimeTable_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]         DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_portfolioTimeTable_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK_portfolioTimeTable] PRIMARY KEY CLUSTERED ([portfolioId] ASC, [weekDay] ASC, [validFrom] ASC),
    CONSTRAINT [CK_portfolioTimeTable] CHECK ([weekDay]='Sunday' OR [weekDay]='Saturday' OR [weekDay]='Friday' OR [weekDay]='Thursday' OR [weekDay]='Wednesday' OR [weekDay]='Tuesday' OR [weekDay]='Monday'),
    CONSTRAINT [FK_portfolioTimeTable_portfolioId] FOREIGN KEY ([portfolioId]) REFERENCES [dbo].[portfolio] ([id]),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[portfolioTimeTableChg], DATA_CONSISTENCY_CHECK=ON));


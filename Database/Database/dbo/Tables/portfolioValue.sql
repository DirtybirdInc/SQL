CREATE TABLE [dbo].[portfolioValue] (
    [portfolioId]  INT                                         NOT NULL,
    [date]         DATE                                        NOT NULL,
    [openMcap]     FLOAT (53)                                  NOT NULL,
    [closeMcap]    FLOAT (53)                                  NOT NULL,
    [sysVersionId] ROWVERSION                                  NOT NULL,
    [sysAppName]   NVARCHAR (255)                              CONSTRAINT [DF__portfolio__sysAp__3BFFE745] DEFAULT (app_name()) NOT NULL,
    [sysUserName]  NVARCHAR (255)                              CONSTRAINT [DF__portfolio__sysUs__3CF40B7E] DEFAULT (suser_name()) NOT NULL,
    [sysStartTime] DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_portfolioValue_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]   DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_portfolioValue_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK_portfolioValue] PRIMARY KEY CLUSTERED ([portfolioId] ASC, [date] ASC),
    CONSTRAINT [FK_portfolioValue_portfolio] FOREIGN KEY ([portfolioId]) REFERENCES [dbo].[portfolio] ([id]),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[portfolioValueChg], DATA_CONSISTENCY_CHECK=ON));


GO
CREATE UNIQUE NONCLUSTERED INDEX [UIX_vw_portfolioValue]
    ON [dbo].[portfolioValue]([date] ASC, [portfolioId] ASC)
    INCLUDE([openMcap], [closeMcap]);


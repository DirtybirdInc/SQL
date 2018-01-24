CREATE TABLE [dbo].[portfolioEventResult] (
    [portfolioEventId]    INT                                         NOT NULL,
    [priceCurrencyCode]   CHAR (3)                                    NULL,
    [closePrice]          FLOAT (53)                                  NULL,
    [closeCurrencyRate]   FLOAT (53)                                  NULL,
    [closeShareFactor]    FLOAT (53)                                  NULL,
    [closeFreefloat]      FLOAT (53)                                  NULL,
    [openShareFactor]     FLOAT (53)                                  NULL,
    [openFreefloatFactor] FLOAT (53)                                  NULL,
    [openPrice]           FLOAT (53)                                  NULL,
    [sysVersionId]        ROWVERSION                                  NOT NULL,
    [sysAppName]          NVARCHAR (255)                              CONSTRAINT [DF__portfolio__sysAp__4A8310C6] DEFAULT (app_name()) NOT NULL,
    [sysUserName]         NVARCHAR (255)                              CONSTRAINT [DF__portfolio__sysUs__4B7734FF] DEFAULT (suser_name()) NOT NULL,
    [sysStartTime]        DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_portfolioEventResult_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]          DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_portfolioEventResult_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK_portfolioEventResult_1] PRIMARY KEY CLUSTERED ([portfolioEventId] ASC),
    CONSTRAINT [FK_portfolioEventResult_portfolioEvent] FOREIGN KEY ([portfolioEventId]) REFERENCES [dbo].[portfolioEvent] ([id]),
    CONSTRAINT [UQ_portfolioEventResult] UNIQUE NONCLUSTERED ([portfolioEventId] ASC),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[portfolioEventResultChg], DATA_CONSISTENCY_CHECK=ON));


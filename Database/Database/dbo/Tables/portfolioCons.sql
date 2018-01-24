CREATE TABLE [dbo].[portfolioCons] (
    [portfolioId]  INT                                         NOT NULL,
    [quoteId]      INT                                         NOT NULL,
    [validFrom]    DATE                                        NOT NULL,
    [validTo]      DATE                                        NOT NULL,
    [sysVersionId] ROWVERSION                                  NOT NULL,
    [sysAppName]   NVARCHAR (255)                              CONSTRAINT [DF__portfolio__sysAp__2F4FF79D] DEFAULT (app_name()) NOT NULL,
    [sysUserName]  NVARCHAR (255)                              CONSTRAINT [DF__portfolio__sysUs__30441BD6] DEFAULT (suser_name()) NOT NULL,
    [sysStartTime] DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_portfolioCons_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]   DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_portfolioCons_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK_portfolioCons] PRIMARY KEY CLUSTERED ([portfolioId] ASC, [quoteId] ASC, [validFrom] ASC),
    CONSTRAINT [FK_portfolioCons_portfolio] FOREIGN KEY ([portfolioId]) REFERENCES [dbo].[portfolio] ([id]),
    CONSTRAINT [FK_portfolioCons_quote] FOREIGN KEY ([quoteId]) REFERENCES [dbo].[quote] ([id]),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[portfolioConsChg], DATA_CONSISTENCY_CHECK=ON));


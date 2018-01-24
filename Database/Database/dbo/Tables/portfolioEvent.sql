CREATE TABLE [dbo].[portfolioEvent] (
    [id]                    INT                                         IDENTITY (1, 1) NOT NULL,
    [portfolioId]           INT                                         NOT NULL,
    [quoteId]               INT                                         NOT NULL,
    [effectiveDate]         DATE                                        NOT NULL,
    [actionType]            VARCHAR (128)                               NOT NULL,
    [currencyCode]          CHAR (3)                                    NULL,
    [formula_openPrice]     NVARCHAR (MAX)                              NULL,
    [formula_openShares]    NVARCHAR (MAX)                              NULL,
    [formula_openFreefloat] NVARCHAR (MAX)                              NULL,
    [formula_parameter]     NVARCHAR (MAX)                              NULL,
    [sysVersionId]          ROWVERSION                                  NOT NULL,
    [sysAppName]            NVARCHAR (255)                              CONSTRAINT [DF__portfolio__sysAp__0E391C95] DEFAULT (app_name()) NOT NULL,
    [sysUserName]           NVARCHAR (255)                              CONSTRAINT [DF__portfolio__sysUs__0F2D40CE] DEFAULT (suser_name()) NOT NULL,
    [sysStartTime]          DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_portfolioEvent_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]            DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_portfolioEvent_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK_portfolioEvent] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [CK__portfolio__actio__10216507] CHECK ([actionType]='DELETION' OR [actionType]='ADDITION' OR [actionType]='ADJUSTMENT'),
    CONSTRAINT [FK_portfolioEvent_portfolio] FOREIGN KEY ([portfolioId]) REFERENCES [dbo].[portfolio] ([id]),
    CONSTRAINT [FK_portfolioEvent_quote] FOREIGN KEY ([quoteId]) REFERENCES [dbo].[quote] ([id]),
    CONSTRAINT [UQ_portfolioEvent] UNIQUE NONCLUSTERED ([portfolioId] ASC, [quoteId] ASC, [effectiveDate] ASC),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[portfolioEventChg], DATA_CONSISTENCY_CHECK=ON));


GO
CREATE NONCLUSTERED INDEX [IX_portfolioEvent]
    ON [dbo].[portfolioEvent]([effectiveDate] ASC, [portfolioId] ASC, [actionType] ASC);


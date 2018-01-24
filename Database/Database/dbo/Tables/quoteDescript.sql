CREATE TABLE [dbo].[quoteDescript] (
    [quoteId]         INT                                         NOT NULL,
    [name]            NVARCHAR (255)                              NOT NULL,
    [SEDOL]           CHAR (7)                                    NULL,
    [RIC]             VARCHAR (38)                                NOT NULL,
    [bloombergTicker] VARCHAR (38)                                NOT NULL,
    [ticker]          VARCHAR (38)                                NOT NULL,
    [currencyCode]    CHAR (3)                                    NOT NULL,
    [exchangeId]      INT                                         NOT NULL,
    [validFrom]       DATE                                        NOT NULL,
    [validTo]         DATE                                        NOT NULL,
    [sysVersionId]    ROWVERSION                                  NOT NULL,
    [sysAppName]      NVARCHAR (128)                              CONSTRAINT [DF_quoteDescript_sysAppName] DEFAULT (app_name()) NOT NULL,
    [sysUserName]     NVARCHAR (128)                              CONSTRAINT [DF_quoteDescript_sysUserName] DEFAULT (suser_name()) NOT NULL,
    [sysStartTime]    DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_quoteDescript_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]      DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_quoteDescript_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK_quoteDescript] PRIMARY KEY CLUSTERED ([quoteId] ASC, [validFrom] ASC),
    CONSTRAINT [FK_quoteDescript_exchange] FOREIGN KEY ([exchangeId]) REFERENCES [dbo].[exchange] ([id]),
    CONSTRAINT [FK_quoteDescript_quote] FOREIGN KEY ([quoteId]) REFERENCES [dbo].[quote] ([id]),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[quoteDescriptChg], DATA_CONSISTENCY_CHECK=ON));


GO
CREATE NONCLUSTERED INDEX [IX_quoteDescript]
    ON [dbo].[quoteDescript]([exchangeId] ASC, [quoteId] ASC);


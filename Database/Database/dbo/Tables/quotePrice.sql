CREATE TABLE [dbo].[quotePrice] (
    [quoteId]      INT                                         NOT NULL,
    [date]         DATE                                        NOT NULL,
    [close_]       FLOAT (53)                                  NULL,
    [sysVersionId] ROWVERSION                                  NOT NULL,
    [sysAppName]   NVARCHAR (255)                              CONSTRAINT [DF__quotePric__sysAp__5629CD9C] DEFAULT (app_name()) NOT NULL,
    [sysUserName]  NVARCHAR (255)                              CONSTRAINT [DF__quotePric__sysUs__571DF1D5] DEFAULT (suser_name()) NOT NULL,
    [sysStartTime] DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_quotePrice_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]   DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_quotePrice_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK_quotePrice] PRIMARY KEY CLUSTERED ([quoteId] ASC, [date] ASC),
    CONSTRAINT [FK_quotePrice_quote] FOREIGN KEY ([quoteId]) REFERENCES [dbo].[quote] ([id]),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[quotePriceChg], DATA_CONSISTENCY_CHECK=ON));


CREATE TABLE [dbo].[quote] (
    [id]             INT                                         IDENTITY (1, 1) NOT NULL,
    [code]           NVARCHAR (128)                              NOT NULL,
    [issueId]        INT                                         NOT NULL,
    [firstTradeDate] DATE                                        NOT NULL,
    [delistDate]     DATE                                        NULL,
    [sysVersionId]   ROWVERSION                                  NOT NULL,
    [sysAppName]     NVARCHAR (255)                              CONSTRAINT [DF__quote__sysAppNam__55F4C372] DEFAULT (app_name()) NOT NULL,
    [sysUserName]    NVARCHAR (255)                              CONSTRAINT [DF__quote__sysUserNa__56E8E7AB] DEFAULT (suser_name()) NOT NULL,
    [sysStartTime]   DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_quote_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]     DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_quote_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK__quote__3213E83F58625685] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_quote_issue] FOREIGN KEY ([issueId]) REFERENCES [dbo].[issue] ([id]),
    CONSTRAINT [UQ__quote__357D4CF9AC84145D] UNIQUE NONCLUSTERED ([code] ASC),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[quoteChg], DATA_CONSISTENCY_CHECK=ON));


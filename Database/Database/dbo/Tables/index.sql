CREATE TABLE [dbo].[index] (
    [id]           INT                                         IDENTITY (1, 1) NOT NULL,
    [code]         NVARCHAR (128)                              NOT NULL,
    [portfolioId]  INT                                         NOT NULL,
    [baseDate]     DATE                                        NOT NULL,
    [baseValue]    FLOAT (53)                                  NOT NULL,
    [launchDate]   DATE                                        NOT NULL,
    [delistDate]   DATE                                        NOT NULL,
    [sysVersionId] ROWVERSION                                  NOT NULL,
    [sysAppName]   NVARCHAR (255)                              DEFAULT (app_name()) NOT NULL,
    [sysUserName]  NVARCHAR (255)                              DEFAULT (suser_name()) NOT NULL,
    [sysStartTime] DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_index_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]   DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_index_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_index_portfolio] FOREIGN KEY ([portfolioId]) REFERENCES [dbo].[portfolio] ([id]),
    UNIQUE NONCLUSTERED ([code] ASC),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[indexChg], DATA_CONSISTENCY_CHECK=ON));


CREATE TABLE [dbo].[portfolio] (
    [id]           INT                                         IDENTITY (1, 1) NOT NULL,
    [code]         NVARCHAR (128)                              NOT NULL,
    [name]         NVARCHAR (128)                              NOT NULL,
    [validFrom]    DATE                                        CONSTRAINT [DF_portfolio_validFrom] DEFAULT ('1900-01-01') NOT NULL,
    [validTo]      DATE                                        CONSTRAINT [DF_portfolio_validTo] DEFAULT ('9999-12-31') NOT NULL,
    [sysVersionId] ROWVERSION                                  NOT NULL,
    [sysAppName]   NVARCHAR (255)                              CONSTRAINT [DF__portfolio__sysAp__69FBBC1F] DEFAULT (app_name()) NOT NULL,
    [sysUserName]  NVARCHAR (255)                              CONSTRAINT [DF__portfolio__sysUs__6AEFE058] DEFAULT (user_name()) NOT NULL,
    [sysStartTime] DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_portfolio_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]   DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_portfolio_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK_portfolio] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [UQ_portfolio] UNIQUE NONCLUSTERED ([code] ASC),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[portfolioChg], DATA_CONSISTENCY_CHECK=ON));


GO
CREATE NONCLUSTERED INDEX [IX_portfolio]
    ON [dbo].[portfolio]([validFrom] ASC, [validTo] ASC);


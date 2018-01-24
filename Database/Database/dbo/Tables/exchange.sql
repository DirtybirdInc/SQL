CREATE TABLE [dbo].[exchange] (
    [id]           INT                                         IDENTITY (1, 1) NOT NULL,
    [code]         VARCHAR (12)                                NOT NULL,
    [validFrom]    DATE                                        NOT NULL,
    [validTo]      DATE                                        NOT NULL,
    [sysVersionId] ROWVERSION                                  NOT NULL,
    [sysAppName]   NVARCHAR (255)                              CONSTRAINT [DF__exchange__sysApp__2180FB33] DEFAULT (app_name()) NOT NULL,
    [sysUserName]  NVARCHAR (255)                              CONSTRAINT [DF__exchange__sysUse__22751F6C] DEFAULT (suser_name()) NOT NULL,
    [sysStartTime] DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_exchange_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]   DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_exchange_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK_exchange] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [UQ__exchange__357D4CF9482BED66] UNIQUE NONCLUSTERED ([code] ASC),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[exchangeChg], DATA_CONSISTENCY_CHECK=ON));


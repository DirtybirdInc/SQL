CREATE TABLE [dbo].[exchangeDescript] (
    [exchangeId]   INT                                         NOT NULL,
    [name]         NVARCHAR (255)                              NOT NULL,
    [countryCode]  CHAR (2)                                    NOT NULL,
    [timeZone]     VARCHAR (55)                                NOT NULL,
    [validFrom]    DATE                                        NOT NULL,
    [validTo]      DATE                                        NOT NULL,
    [sysVersionId] ROWVERSION                                  NOT NULL,
    [sysAppName]   NVARCHAR (255)                              DEFAULT (app_name()) NOT NULL,
    [sysUserName]  NVARCHAR (255)                              DEFAULT (suser_name()) NOT NULL,
    [sysStartTime] DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_exchangeDescript_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]   DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_exchangeDescript_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK_exchangeDescript] PRIMARY KEY CLUSTERED ([exchangeId] ASC, [validFrom] ASC),
    CHECK ((getdate() AT TIME ZONE [timeZone]) IS NOT NULL),
    CHECK ((getdate() AT TIME ZONE [timeZone]) IS NOT NULL),
    CONSTRAINT [FK_exchangeDescript_exchange] FOREIGN KEY ([exchangeId]) REFERENCES [dbo].[exchange] ([id]),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[exchangeDescriptChg], DATA_CONSISTENCY_CHECK=ON));


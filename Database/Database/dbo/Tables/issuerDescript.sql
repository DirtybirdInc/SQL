CREATE TABLE [dbo].[issuerDescript] (
    [issuerId]     INT                                         NOT NULL,
    [name]         NVARCHAR (255)                              NOT NULL,
    [industryCode] VARCHAR (25)                                NULL,
    [countryCode]  CHAR (2)                                    NULL,
    [validFrom]    DATE                                        NOT NULL,
    [validTo]      DATE                                        NOT NULL,
    [sysVersionId] ROWVERSION                                  NOT NULL,
    [sysAppName]   NVARCHAR (255)                              CONSTRAINT [DF__issuerDes__sysAp__52593CB8] DEFAULT (app_name()) NOT NULL,
    [sysUserName]  NVARCHAR (255)                              CONSTRAINT [DF__issuerDes__sysUs__534D60F1] DEFAULT (suser_name()) NOT NULL,
    [sysStartTime] DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_issuerDescript_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]   DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_issuerDescript_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK_issuerDescript] PRIMARY KEY CLUSTERED ([issuerId] ASC, [validFrom] ASC),
    CONSTRAINT [FK__issuerDes__issue__5CD6CB2B] FOREIGN KEY ([issuerId]) REFERENCES [dbo].[issuer] ([id]),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[issuerDescriptChg], DATA_CONSISTENCY_CHECK=ON));


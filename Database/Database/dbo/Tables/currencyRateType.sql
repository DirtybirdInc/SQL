CREATE TABLE [dbo].[currencyRateType] (
    [id]           INT                                         IDENTITY (1, 1) NOT NULL,
    [code]         NVARCHAR (128)                              NOT NULL,
    [baseCode]     CHAR (3)                                    CONSTRAINT [DF_currencyRateType_baseCode] DEFAULT ('EUR') NOT NULL,
    [name]         NVARCHAR (128)                              NOT NULL,
    [timeZone]     NVARCHAR (128)                              NOT NULL,
    [descript]     NVARCHAR (255)                              NOT NULL,
    [validFrom]    DATE                                        NOT NULL,
    [validTo]      DATE                                        NOT NULL,
    [sysVersionId] ROWVERSION                                  NOT NULL,
    [sysAppName]   NVARCHAR (128)                              CONSTRAINT [DF__currency__sysApp__6991A7CB] DEFAULT (app_name()) NOT NULL,
    [sysUserName]  NVARCHAR (128)                              CONSTRAINT [DF__currency__sysUse__6A85CC04] DEFAULT (suser_name()) NOT NULL,
    [sysStartTime] DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_currencyRateType_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]   DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_currencyRateType_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK_currencyRateType] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [CK_currencyRateType] CHECK ((getdate() AT TIME ZONE [timeZone]) IS NOT NULL),
    CONSTRAINT [UQ_currencyRateTypeCode] UNIQUE NONCLUSTERED ([code] ASC),
    CONSTRAINT [UQ_currencyRateTypeName] UNIQUE NONCLUSTERED ([name] ASC),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[currencyRateTypeChg], DATA_CONSISTENCY_CHECK=ON));


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_currencyRateType]
    ON [dbo].[currencyRateType]([code] ASC, [baseCode] ASC);


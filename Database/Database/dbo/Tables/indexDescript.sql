CREATE TABLE [dbo].[indexDescript] (
    [id]              INT                                         IDENTITY (1, 1) NOT NULL,
    [indexId]         INT                                         NOT NULL,
    [name]            NVARCHAR (255)                              NOT NULL,
    [ISIN]            CHAR (12)                                   NULL,
    [SEDOL]           CHAR (7)                                    NULL,
    [RIC]             VARCHAR (38)                                NOT NULL,
    [bloombergTicker] VARCHAR (38)                                NOT NULL,
    [currencyCode]    CHAR (3)                                    NOT NULL,
    [replCost]        NUMERIC (38, 15)                            NOT NULL,
    [validFrom]       DATE                                        NOT NULL,
    [validTo]         DATE                                        NOT NULL,
    [sysVersionId]    ROWVERSION                                  NOT NULL,
    [sysAppName]      NVARCHAR (128)                              CONSTRAINT [DF_indexDescript_sysAppName] DEFAULT (app_name()) NOT NULL,
    [sysUserName]     NVARCHAR (128)                              CONSTRAINT [DF_indexDescript_sysUserName] DEFAULT (suser_name()) NOT NULL,
    [sysStartTime]    DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_indexDescript_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]      DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_indexDescript_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK_indexDescript] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_indexDescript_index] FOREIGN KEY ([indexId]) REFERENCES [dbo].[index] ([id]),
    CONSTRAINT [UQ_indexDescript] UNIQUE NONCLUSTERED ([indexId] ASC, [validFrom] ASC),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[indexDescriptChg], DATA_CONSISTENCY_CHECK=ON));


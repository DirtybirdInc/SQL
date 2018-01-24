CREATE TABLE [dbo].[indexValue] (
    [indexId]       INT                                         NOT NULL,
    [date]          DATE                                        NOT NULL,
    [cumCostFactor] FLOAT (53)                                  NOT NULL,
    [value]         FLOAT (53)                                  NOT NULL,
    [sysVersionId]  ROWVERSION                                  NOT NULL,
    [sysAppName]    NVARCHAR (255)                              DEFAULT (app_name()) NOT NULL,
    [sysUserName]   NVARCHAR (255)                              DEFAULT (suser_name()) NOT NULL,
    [sysStartTime]  DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_indexValue_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]    DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_indexValue_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK_indexValue] PRIMARY KEY CLUSTERED ([date] ASC, [indexId] ASC),
    CONSTRAINT [FK_indexValue_index] FOREIGN KEY ([indexId]) REFERENCES [dbo].[index] ([id]),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[indexValueChg], DATA_CONSISTENCY_CHECK=ON));


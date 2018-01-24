CREATE TABLE [dbo].[issueDescript] (
    [issueId]      INT                                         NOT NULL,
    [name]         NVARCHAR (255)                              NOT NULL,
    [ISIN]         CHAR (12)                                   NULL,
    [validFrom]    DATE                                        NOT NULL,
    [validTo]      DATE                                        NOT NULL,
    [sysVersionId] ROWVERSION                                  NOT NULL,
    [sysAppName]   NVARCHAR (255)                              DEFAULT (app_name()) NOT NULL,
    [sysUserName]  NVARCHAR (255)                              DEFAULT (suser_name()) NOT NULL,
    [sysStartTime] DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_issueDescript_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]   DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_issueDescript_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    CONSTRAINT [PK_issueDescript] PRIMARY KEY CLUSTERED ([issueId] ASC, [validFrom] ASC),
    CONSTRAINT [FK_issueDescript_issue] FOREIGN KEY ([issueId]) REFERENCES [dbo].[issue] ([id]),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[issueDescriptChg], DATA_CONSISTENCY_CHECK=ON));


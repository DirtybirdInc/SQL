CREATE TABLE [dbo].[issue] (
    [id]           INT                                         IDENTITY (1, 1) NOT NULL,
    [code]         NVARCHAR (128)                              NOT NULL,
    [issuerId]     INT                                         NOT NULL,
    [type]         NVARCHAR (128)                              NOT NULL,
    [class]        NVARCHAR (128)                              NOT NULL,
    [sysVersionId] ROWVERSION                                  NOT NULL,
    [sysAppName]   NVARCHAR (255)                              DEFAULT (app_name()) NOT NULL,
    [sysUserName]  NVARCHAR (255)                              DEFAULT (suser_name()) NOT NULL,
    [sysStartTime] DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [DF_dbo_issue_sysStartTime] DEFAULT (getdate()) NOT NULL,
    [sysEndTime]   DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [DF_dbo_issue_sysEndTime] DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_issue_issuer] FOREIGN KEY ([issuerId]) REFERENCES [dbo].[issuer] ([id]),
    UNIQUE NONCLUSTERED ([code] ASC),
    PERIOD FOR SYSTEM_TIME ([sysStartTime], [sysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[issueChg], DATA_CONSISTENCY_CHECK=ON));


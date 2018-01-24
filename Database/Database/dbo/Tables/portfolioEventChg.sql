CREATE TABLE [dbo].[portfolioEventChg] (
    [id]                    INT            NOT NULL,
    [portfolioId]           INT            NOT NULL,
    [quoteId]               INT            NOT NULL,
    [effectiveDate]         DATE           NOT NULL,
    [actionType]            VARCHAR (128)  NOT NULL,
    [currencyCode]          CHAR (3)       NULL,
    [formula_openPrice]     NVARCHAR (MAX) NULL,
    [formula_openShares]    NVARCHAR (MAX) NULL,
    [formula_openFreefloat] NVARCHAR (MAX) NULL,
    [formula_parameter]     NVARCHAR (MAX) NULL,
    [sysVersionId]          ROWVERSION     NOT NULL,
    [sysAppName]            NVARCHAR (255) NOT NULL,
    [sysUserName]           NVARCHAR (255) NOT NULL,
    [sysStartTime]          DATETIME2 (7)  NOT NULL,
    [sysEndTime]            DATETIME2 (7)  NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_portfolioEventChg]
    ON [dbo].[portfolioEventChg]([sysEndTime] ASC, [sysStartTime] ASC);


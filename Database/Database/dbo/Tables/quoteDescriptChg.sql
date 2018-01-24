CREATE TABLE [dbo].[quoteDescriptChg] (
    [quoteId]         INT            NOT NULL,
    [name]            NVARCHAR (255) NOT NULL,
    [SEDOL]           CHAR (7)       NULL,
    [RIC]             VARCHAR (38)   NOT NULL,
    [bloombergTicker] VARCHAR (38)   NOT NULL,
    [ticker]          VARCHAR (38)   NOT NULL,
    [currencyCode]    CHAR (3)       NOT NULL,
    [exchangeId]      INT            NOT NULL,
    [validFrom]       DATE           NOT NULL,
    [validTo]         DATE           NOT NULL,
    [sysVersionId]    ROWVERSION     NOT NULL,
    [sysAppName]      NVARCHAR (128) NOT NULL,
    [sysUserName]     NVARCHAR (128) NOT NULL,
    [sysStartTime]    DATETIME2 (7)  NOT NULL,
    [sysEndTime]      DATETIME2 (7)  NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_quoteDescriptChg]
    ON [dbo].[quoteDescriptChg]([sysEndTime] ASC, [sysStartTime] ASC);


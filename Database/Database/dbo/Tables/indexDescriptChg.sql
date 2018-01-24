CREATE TABLE [dbo].[indexDescriptChg] (
    [id]              INT              NOT NULL,
    [indexId]         INT              NOT NULL,
    [name]            NVARCHAR (255)   NOT NULL,
    [ISIN]            CHAR (12)        NULL,
    [SEDOL]           CHAR (7)         NULL,
    [RIC]             VARCHAR (38)     NOT NULL,
    [bloombergTicker] VARCHAR (38)     NOT NULL,
    [currencyCode]    CHAR (3)         NOT NULL,
    [replCost]        NUMERIC (38, 15) NOT NULL,
    [validFrom]       DATE             NOT NULL,
    [validTo]         DATE             NOT NULL,
    [sysVersionId]    ROWVERSION       NOT NULL,
    [sysAppName]      NVARCHAR (128)   NOT NULL,
    [sysUserName]     NVARCHAR (128)   NOT NULL,
    [sysStartTime]    DATETIME2 (7)    NOT NULL,
    [sysEndTime]      DATETIME2 (7)    NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_indexDescriptChg]
    ON [dbo].[indexDescriptChg]([sysEndTime] ASC, [sysStartTime] ASC);


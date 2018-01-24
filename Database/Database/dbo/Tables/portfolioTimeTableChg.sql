CREATE TABLE [dbo].[portfolioTimeTableChg] (
    [portfolioId]        INT            NOT NULL,
    [weekDay]            NVARCHAR (12)  NOT NULL,
    [valuationTimeLocal] TIME (7)       NOT NULL,
    [validFrom]          DATE           NOT NULL,
    [validTo]            DATE           NOT NULL,
    [sysVersionId]       ROWVERSION     NOT NULL,
    [sysAppName]         NVARCHAR (255) NOT NULL,
    [sysUserName]        NVARCHAR (255) NOT NULL,
    [sysStartTime]       DATETIME2 (7)  NOT NULL,
    [sysEndTime]         DATETIME2 (7)  NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_portfolioTimeTableChg]
    ON [dbo].[portfolioTimeTableChg]([sysEndTime] ASC, [sysStartTime] ASC);


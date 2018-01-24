



CREATE VIEW [dbo].[vw_index]
AS
SELECT 
	a.date, 
	a.dateUTC, 
	a.nextDate, 
	a.nextDateUTC, 
	a.prevDate, 
	a.prevDateUTC, 
	a.portfolioId, 
	a.portfolioCode, 
	a.portfolioName, 
	a.portfolioValuationTimeZone, 
	a.portfolioOpenMcap, 
	a.portfolioCloseMcap, 
	a.reviewCalendarId, 
	a.reviewCalendarCode, 
	a.reviewCalendarName, 
	a.reviewCalendarDescript, 
	a.reviewPeriodId, 
	a.reviewPeriodStart, 
	a.reviewPeriodEnd, 
	a.calculationCalendarId, 
	a.calculationCalendarCode, 
	a.calculationCalendarName, 
	a.calculationCalendarDescript, 
	a.currencyRateTypeId, 
	a.currencyRateTypeCode, 
	a.currencyRateTypeBaseCode, 
	a.currencyRateTypeName, 
	a.currencyRateTypeDescript, 
	a.currencyRateDate, 
	a.currencyRatePrevDate,
	indexId = b.id,
	indexSymbol = b.code,
	indexName = c.name,
	indexISIN = c.ISIN,
	indexSEDOL = c.SEDOL,
	indexRIC = c.RIC,
	indexBloombergTicker = c.bloombergTicker,
	indexBaseDate = b.baseDate,
	indexBaseValue = b.baseValue,
	indexLaunchDate = b.launchDate,
	indexDelistDate = b.delistDate,
	indexReplCostPA = c.replCost,
	indexCurrencyCode = c.currencyCode,
	indexCumCostFactorT = CASE b.baseDate WHEN a.[date] THEN CAST(1 AS float) ELSE d.cumCostFactor END,
	indexCostFactorT = CASE b.baseDate WHEN a.[date] THEN CAST(1 AS float) ELSE CAST(1 AS float)-c.replCost*CAST(DATEDIFF(DAY,a.prevDate,a.[date]) AS float)/CAST(360 AS float) END,
	indexValue = CASE b.baseDate WHEN a.[date] THEN b.baseValue ELSE d.[value] END
FROM dbo.vw_portfolio AS a
JOIN dbo.[index] AS b ON a.portfolioId = b.portfolioId AND b.[baseDate] <= a.[date] AND b.[delistDate] > a.[date]
OUTER APPLY (SELECT TOP(1) e.name,e.bloombergTicker,e.ISIN,e.RIC,e.replCost,e.currencyCode,e.SEDOL FROM dbo.indexDescript AS e WHERE b.id = e.indexId AND e.validFrom <= a.[date] AND e.validTo > a.[date] ORDER BY e.validFrom) AS c
LEFT JOIN dbo.[indexValue] AS d ON b.id = d.indexId AND a.[date] = d.[date]








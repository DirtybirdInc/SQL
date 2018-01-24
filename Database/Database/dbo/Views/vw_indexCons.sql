








CREATE VIEW [dbo].[vw_indexCons]
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
	a.indexId, 
	a.indexSymbol, 
	a.indexName, 
	a.indexISIN, 
	a.indexSEDOL, 
	a.indexRIC, 
	a.indexBloombergTicker, 
	a.indexBaseDate, 
	a.indexBaseValue, 
	a.indexLaunchDate, 
	a.indexDelistDate, 
	a.indexReplCostPA, 
	a.indexCurrencyCode, 
	a.indexCumCostFactorT, 
	a.indexCostFactorT, 
	a.indexValue,
	b.issuerId, 
	b.issuerCode, 
	b.issuerName, 
	b.issuerCountryCode, 
	b.issuerIndustryCode, 
	b.issueId, 
	b.issueCode, 
	b.issueName, 
	b.issueISIN, 
	b.exchangeId, 
	b.exchangeCode, 
	b.exchangeName, 
	b.exchangeCountryCode, 
	b.exchangeTimeZone, 
	b.exchangeDate, 
	b.exchangeDateUTC, 
	b.quoteId, 
	b.quoteCode, 
	b.[quoteName], 
	b.quoteSEDOL, 
	b.quoteRIC, 
	b.quoteBloombergTicker, 
	b.quoteTicker, 
	b.quoteCurrencyCode, 
	b.quoteFirstTradeDate,
	b.quoteDelistDate,
	consShareFactor = b.consShareFactor*a.indexCumCostFactorT, 
	consFreefloatFactor, 
	consSharesInIndex = b.consSharesInPortfolio*a.indexCumCostFactorT, 
	consOpenLocal, 
	consCloseLocal, 
	consOpenMcapLocal, 
	consCloseMcapLocal, 
	consOpenIndexCurrencyRate = b.consOpenRollupRate*CASE a.currencyRateTypeBaseCode WHEN a.indexCurrencyCode THEN CAST(1 AS float) ELSE c.rate END, 
	consCloseIndexCurrencyRate = b.consCloseRollupRate*CASE a.currencyRateTypeBaseCode WHEN a.indexCurrencyCode THEN CAST(1 AS float) ELSE d.rate END, 
	consOpenIndexCurrency = b.consOpenRollup*CASE a.currencyRateTypeBaseCode WHEN a.indexCurrencyCode THEN CAST(1 AS float) ELSE c.rate END, 
	consCloseIndexCurrency = b.consCloseRollup*CASE a.currencyRateTypeBaseCode WHEN a.indexCurrencyCode THEN CAST(1 AS float) ELSE d.rate END, 
	consOpenMcapIndexCurrency = b.consOpenMcapRollup*a.indexCumCostFactorT*CASE a.currencyRateTypeBaseCode WHEN a.indexCurrencyCode THEN CAST(1 AS float) ELSE c.rate END, 
	consCloseMcapIndexCurrency = b.consCloseMcapRollup*a.indexCumCostFactorT*CASE a.currencyRateTypeBaseCode WHEN a.indexCurrencyCode THEN CAST(1 AS float) ELSE d.rate END,
	consOpenWeight = b.consOpenMcapRollup/SUM(b.consOpenMcapRollup) OVER(PARTITION BY a.date,a.indexId),
	consCloseWeight = b.consCloseMcapRollup/SUM(b.consCloseMcapRollup) OVER(PARTITION BY a.date,a.indexId)
FROM [dbo].[vw_index] AS a
JOIN [dbo].[vw_portfolioCons] AS b ON a.portfolioId = b.portfolioId AND a.[date] = b.[date]
LEFT JOIN [dbo].[vw_currencyRate] AS c ON c.rateType = 'BASE' AND a.currencyRateTypeId = c.currencyRateTypeId AND a.currencyRateTypeBaseCode = c.fromCode AND a.indexCurrencyCode = c.toCode AND a.currencyRatePrevDate = c.[date]
LEFT JOIN [dbo].[vw_currencyRate] AS d ON d.rateType = 'BASE' AND a.currencyRateTypeId = d.currencyRateTypeId AND a.currencyRateTypeBaseCode = d.fromCode AND a.indexCurrencyCode = d.toCode AND a.currencyRateDate = d.[date]






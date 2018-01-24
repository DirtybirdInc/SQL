













CREATE VIEW [dbo].[vw_portfolioCons]
AS
SELECT *,
	consOpenLocal = ISNULL(consLastCloseLocal*consLastCloseToLocalOpenRate,consLastOpenLocal*consLastOpenToLocalOpenRate),
	consCloseLocal = COALESCE(quoteCloseLocal,consLastCloseLocal*consLastCloseToLocalCloseRate,consLastOpenLocal*consLastOpenToLocalCloseRate),
	consOpenMcapLocal = consSharesInPortfolio*ISNULL(consLastCloseLocal*consLastCloseToLocalOpenRate,consLastOpenLocal*consLastOpenToLocalOpenRate),
	consCloseMcapLocal = consSharesInPortfolio*COALESCE(quoteCloseLocal,consLastCloseLocal*consLastCloseToLocalCloseRate,consLastOpenLocal*consLastOpenToLocalCloseRate),
	consOpenRollup = consOpenRollupRate*ISNULL(consLastCloseLocal*consLastCloseToLocalOpenRate,consLastOpenLocal*consLastOpenToLocalOpenRate),
	consCloseRollup = consCloseRollupRate*COALESCE(quoteCloseLocal,consLastCloseLocal*consLastCloseToLocalCloseRate,consLastOpenLocal*consLastOpenToLocalCloseRate),
	consOpenMcapRollup = consOpenRollupRate*consSharesInPortfolio*ISNULL(consLastCloseLocal*consLastCloseToLocalOpenRate,consLastOpenLocal*consLastOpenToLocalOpenRate),
	consCloseMcapRollup = consCloseRollupRate*consSharesInPortfolio*COALESCE(quoteCloseLocal,consLastCloseLocal*consLastCloseToLocalCloseRate,consLastOpenLocal*consLastOpenToLocalCloseRate)
FROM
(
SELECT 
	portfolio.date, 
	portfolio.dateUTC, 
	portfolio.nextDate, 
	portfolio.nextDateUTC, 
	portfolio.prevDate, 
	portfolio.prevDateUTC, 
	portfolio.portfolioId, 
	portfolio.portfolioCode, 
	portfolio.portfolioName, 
	portfolio.portfolioValuationTimeZone, 
	portfolio.portfolioOpenMcap, 
	portfolio.portfolioCloseMcap, 
	portfolio.reviewCalendarId, 
	portfolio.reviewCalendarCode, 
	portfolio.reviewCalendarName, 
	portfolio.reviewCalendarDescript, 
	portfolio.reviewPeriodId, 
	portfolio.reviewPeriodStart, 
	portfolio.reviewPeriodEnd, 
	portfolio.calculationCalendarId, 
	portfolio.calculationCalendarCode, 
	portfolio.calculationCalendarName, 
	portfolio.calculationCalendarDescript, 
	portfolio.currencyRateTypeId, 
	portfolio.currencyRateTypeCode, 
	portfolio.currencyRateTypeBaseCode, 
	portfolio.currencyRateTypeName, 
	portfolio.currencyRateTypeDescript, 
	portfolio.currencyRateDate, 
	portfolio.currencyRatePrevDate,
	quote.issuerId,
	quote.issuerCode,
	quote.issuerName,
	quote.issuerCountryCode,
	quote.issuerIndustryCode,
	quote.issueId,
	quote.issueCode,
	quote.issueName,
	quote.issueISIN,
	quote.exchangeId,
	quote.exchangeCode,
	quote.exchangeName,
	quote.exchangeCountryCode,
	quote.exchangeTimeZone,
	exchangeDate = quote.date,
	exchangeDateUTC = quote.dateUTC,
	portfolioEvent.quoteId,
	quote.quoteCode,
	quote.[quoteName],
	quote.quoteSEDOL,
	quote.quoteRIC,
	quote.quoteBloombergTicker,
	quote.quoteTicker,
	quote.quoteCurrencyCode,
	quote.quoteCloseLocal,
	quote.quoteFirstTradeDate,
	quote.quoteDelistDate,
	quote.quoteCloseIsMissing,
	quote.quoteCloseIsNoTrade,
	consLastOpenDate = portfolioEvent.effectiveDate,
	consLastOpenLocal = portfolioEvent.openPrice,
	consLastOpenCurrency = portfolioEvent.priceCurrencyCode,
	consLastOpenToLocalOpenRate = CASE quote.quoteCurrencyCode WHEN portfolioEvent.priceCurrencyCode THEN 1 ELSE openToCurrentLocalOpen.openRate END,
	consLastOpenToLocalCloseRate = CASE quote.quoteCurrencyCode WHEN portfolioEvent.priceCurrencyCode THEN 1 ELSE openToCurrentLocalClose.closeRate END,
	consLastCloseDate = lastPrice.[date],
	consLastCloseLocal = lastPrice.quoteCloseLocal,
	consLastCloseCurrency = lastPrice.quoteCurrencyCode,
	consLastCloseToLocalOpenRate = CASE quote.quoteCurrencyCode WHEN lastPrice.quoteCurrencyCode THEN 1 ELSE lastToCurrentLocalOpen.openRate END,
	consLastCloseToLocalCloseRate = CASE quote.quoteCurrencyCode WHEN lastPrice.quoteCurrencyCode THEN 1 ELSE lastToCurrentLocalClose.closeRate END,
	consShareFactor = portfolioEvent.openShareFactor,
	consFreefloatFactor = portfolioEvent.openfreefloatFactor,
	consSharesInPortfolio = portfolioEvent.openSharesInPortfolio,
	consOpenRollupRate = CASE portfolio.currencyRateTypeBaseCode WHEN quote.quoteCurrencyCode THEN 1 ELSE openRollupRate.openRate END,
	consCloseRollupRate = CASE portfolio.currencyRateTypeBaseCode WHEN quote.quoteCurrencyCode THEN 1 ELSE closeRollupRate.closeRate END
FROM dbo.vw_portfolio AS portfolio
JOIN dbo.vw_portfolioEvent AS portfolioEvent 
	ON portfolio.portfolioId = portfolioEvent.portfolioId
	AND portfolioEvent.effectiveDate <= portfolio.[date]
	AND portfolioEvent.sharesValidTo > portfolio.[date]
	AND portfolioEvent.actionType IN ('ADDITION','ADJUSTMENT')
OUTER APPLY(SELECT TOP(1) quote.* FROM dbo.vw_quote AS quote
	WHERE quote.quoteId = portfolioEvent.quoteId 
		AND quote.dateUTC <= portfolio.dateUTC
		AND quote.nextDateUTC > portfolio.dateUTC
	ORDER BY quote.[date]
	) AS quote
--select the last close price
OUTER APPLY(SELECT TOP(1) portfolioDate.[date],lastPrice.quoteCloseLocal,lastPrice.quoteCurrencyCode FROM dbo.vw_quote AS lastPrice
	JOIN dbo.portfolioValuePeriod AS portfolioDate 
	ON portfolio.portfolioId = portfolioDate.portfolioId 
		AND lastPrice.dateUTC <= portfolioDate.dateUTC 
		AND lastPrice.nextDateUTC > portfolioDate.dateUTC
		AND portfolioDate.[date] BETWEEN portfolioEvent.effectiveDate AND portfolio.prevDate
	WHERE portfolioEvent.quoteId = lastPrice.quoteId
		AND lastPrice.quoteCloseLocal IS NOT NULL
	ORDER BY lastPrice.[date] DESC
	) AS lastPrice
--select rollup currency rates
OUTER APPLY(SELECT TOP(1) openRate = currency.rate FROM dbo.vw_currencyRate AS currency
	WHERE portfolio.currencyRateTypeId = currency.currencyRateTypeId
		AND portfolio.currencyRateTypeBaseCode = currency.toCode
		AND portfolio.currencyRatePrevDate = currency.date
		AND quote.quoteCurrencyCode = currency.fromCode
		AND currency.rateType = 'BASE'
	ORDER BY currency.[date]) AS openRollupRate
OUTER APPLY(SELECT TOP(1) closeRate = currency.rate FROM dbo.vw_currencyRate AS currency
	WHERE portfolio.currencyRateTypeBaseCode != quote.quoteCurrencyCode
		AND portfolio.currencyRateTypeId = currency.currencyRateTypeId
		AND portfolio.currencyRateTypeBaseCode = currency.toCode
		AND portfolio.currencyRateDate = currency.[date]
		AND quote.quoteCurrencyCode = currency.fromCode
		AND currency.rateType = 'BASE'
	ORDER BY currency.[date]) AS closeRollupRate
--select last open price currency to current local currency
OUTER APPLY(SELECT TOP(1) openRate = currency.rate FROM dbo.vw_currencyRate AS currency
	WHERE portfolioEvent.priceCurrencyCode != quote.quoteCurrencyCode
		AND portfolio.currencyRateTypeId = currency.currencyRateTypeId
		AND quote.quoteCurrencyCode = currency.toCode
		AND portfolioEvent.priceCurrencyCode = currency.fromCode
		AND currency.[date] = portfolio.currencyRatePrevDate
		AND currency.rateType = 'ALL'
	ORDER BY currency.[date]) AS openToCurrentLocalOpen
OUTER APPLY(SELECT TOP(1) closeRate = currency.rate FROM dbo.vw_currencyRate AS currency
	WHERE portfolioEvent.priceCurrencyCode != quote.quoteCurrencyCode
		AND portfolio.currencyRateTypeId = currency.currencyRateTypeId
		AND quote.quoteCurrencyCode = currency.toCode
		AND portfolioEvent.priceCurrencyCode = currency.fromCode
		AND currency.[date] = portfolio.currencyRateDate
		AND currency.rateType = 'ALL'
	ORDER BY currency.date) AS openToCurrentLocalClose
--select last close price currency to current local currency
OUTER APPLY(SELECT TOP(1) openRate = currency.rate FROM dbo.vw_currencyRate AS currency
	WHERE lastPrice.quoteCurrencyCode != quote.quoteCurrencyCode
		AND portfolio.currencyRateTypeId = currency.currencyRateTypeId
		AND quote.quoteCurrencyCode = currency.toCode
		AND lastPrice.quoteCurrencyCode = currency.fromCode
		AND currency.date = portfolio.currencyRatePrevDate
		AND currency.rateType = 'ALL'
	ORDER BY currency.[date]) AS lastToCurrentLocalOpen
OUTER APPLY(SELECT TOP(1) closeRate = currency.rate FROM dbo.vw_currencyRate AS currency
	WHERE lastPrice.quoteCurrencyCode != quote.quoteCurrencyCode
		AND portfolio.currencyRateTypeId = currency.currencyRateTypeId
		AND quote.quoteCurrencyCode = currency.toCode
		AND lastPrice.quoteCurrencyCode = currency.fromCode
		AND currency.[date] = portfolio.currencyRateDate
		AND currency.rateType = 'ALL'
	ORDER BY currency.[date]) AS lastToCurrentLocalClose
) AS allFields

























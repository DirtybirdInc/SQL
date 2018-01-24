









CREATE VIEW [dbo].[vw_quote]
AS
SELECT 
	c.date,
	c.dateUTC,
	c.nextDate,
	c.nextDateUTC,
	c.exchangeId,
	exchangeCode = d.code,
	exchangeName = ex.[name],
	exchangeCountryCode = ex.countryCode,
	exchangeTimeZone = ex.timeZone,
	e.issuerId,
	issuerCode = f.code,
	issuerName = isr.name,
	issuerCountryCode = isr.countryCode,
	issuerIndustryCode = isr.industryCode,
	b.issueId,
	issueCode = e.code,
	issueName = iss.name,
	issueIsin = iss.isin,
	a.quoteId,
	quoteCode = b.code,
	quoteFirstTradeDate = b.firstTradeDate,
	quoteDelistDate = b.delistDate,
	[quoteName] = a.[name],
	quoteSedol = a.sedol,
	quoteBloombergTicker =  a.bloombergTicker,
	quoteTicker = a.ticker,
	quoteCurrencyCode = a.currencyCode,
	quoteRic = a.ric,
	quoteCloseLocal = px.close_,
	quoteCloseIsMissing = CAST(CASE WHEN px.[date] IS NULL THEN 1 ELSE 0 END AS bit),
	quoteCloseIsNoTrade = CAST(CASE WHEN px.[date] IS NOT NULL AND px.[date] IS NULL THEN 1 ELSE 0 END AS bit)
FROM dbo.quoteDescript AS a
JOIN dbo.quote AS b ON a.quoteId = b.id
JOIN dbo.exchangePeriod AS c ON a.exchangeId = c.exchangeId
JOIN dbo.exchange AS d ON a.exchangeId = d.id
JOIN dbo.issue AS e ON b.issueId = e.id
JOIN dbo.issuer AS f ON e.issuerId = f.id

OUTER APPLY (SELECT TOP(1) exchangeId, name, countryCode, timeZone, validFrom, validTo FROM dbo.exchangeDescript
	WHERE a.exchangeId = exchangeId 
		AND validFrom <= c.[date] 
		AND validTo > c.[date] 
	ORDER BY exchangeId) AS ex

OUTER APPLY (SELECT TOP(1) issueId, name, ISIN, validFrom, validTo FROM dbo.issueDescript
	WHERE b.issueId = issueId 
		AND validFrom <= c.[date] 
		AND validTo > c.[date]
	ORDER BY issueId) AS iss

OUTER APPLY (SELECT TOP(1) issuerId, name, industryCode, countryCode, validFrom, validTo FROM dbo.issuerDescript
	WHERE e.issuerId = issuerId 
		AND validFrom <= c.[date] 
		AND validTo > c.[date]
	ORDER BY issuerId) AS isr

LEFT JOIN dbo.quotePrice AS px ON a.quoteId = px.quoteId AND c.[date] = px.[date]

WHERE a.validFrom <= c.[date] 
	AND a.validTo > c.[date]
	AND b.firstTradeDate <= c.[date]
	AND b.delistDate > c.[date]
	--AND b.code = 'AAPL'




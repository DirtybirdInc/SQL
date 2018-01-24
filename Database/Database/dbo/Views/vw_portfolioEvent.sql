
















CREATE VIEW [dbo].[vw_portfolioEvent]
AS
SELECT 
	a.portfolioId,
	a.[effectiveDate],
	a.actionType,
	a.quoteId,
	CACurrencyCode = a.currencyCode,
	b.priceCurrencyCode,
	a.formula_openPrice,
	a.formula_openShares,
	a.formula_openFreefloat,
	a.formula_parameter,
	b.closeCurrencyRate,
	b.closePrice,
	b.closeShareFactor,
	closeFreefloatFactor = b.closeFreefloat,
	b.openPrice,
	b.openShareFactor,
	b.openFreefloatFactor,
	openSharesInPortfolio = b.openShareFactor*b.openFreefloatFactor,
	sharesValidTo = c.validTo
FROM dbo.portfolioEvent AS a
JOIN dbo.portfolioEventResult AS b
	ON a.id = b.portfolioEventId
LEFT JOIN dbo.portfolioCons AS c
	ON a.portfolioId = c.portfolioId
	AND a.quoteId = c.quoteId
	AND a.effectiveDate = c.validFrom 
	AND a.actionType IN ('ADDITION','ADJUSTMENT')








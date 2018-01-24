


CREATE VIEW [dbo].[vw_portfolio]
AS
SELECT 
	a.[date],
	a.dateUTC,
	a.nextDate,
	a.nextDateUTC,
	a.prevDate,
	a.prevDateUTC,
	a.portfolioId,
	portfolioCode = d.code,
	portfolioName = d.[name],
	portfolioValuationTimeZone = a.valuationTimeZone,
	portfolioOpenMcap = i.openMcap,
	portfolioCloseMcap = i.openMcap,
	a.reviewCalendarId,
	reviewCalendarCode = f.code,
	reviewCalendarName = f.[name],
	reviewCalendarDescript = f.descript,
	reviewPeriodId = a.reviewPeriodId,
	reviewPeriodStart = e.validFrom,
	reviewPeriodEnd = e.validTo,
	a.calculationCalendarId,
	calculationCalendarCode = g.code,
	calculationCalendarName = g.[name],
	calculationCalendarDescript = g.descript,
	currencyRateTypeId = a.currencyRateTypeId,
	currencyRateTypeCode = h.code,
	currencyRateTypeBaseCode = h.baseCode,
	currencyRateTypeName = h.name,
	currencyRateTypeDescript = h.descript,
	a.currencyRateDate,
	a.currencyRatePrevDate
FROM dbo.vw_portfolioValuePeriod  AS a WITH(NOEXPAND)
LEFT JOIN dbo.portfolio AS d ON a.portfolioId = d.id
LEFT JOIN dbo.reviewPeriod AS e ON a.reviewPeriodId = e.id
LEFT JOIN dbo.reviewCalendar AS f ON a.reviewCalendarId = f.id
LEFT JOIN dbo.calculationCalendar AS g ON a.calculationCalendarId = g.id
LEFT JOIN dbo.currencyRateType AS h ON a.currencyRateTypeId = h.id
LEFT JOIN dbo.portfolioValue AS i ON a.portfolioId = i.portfolioId AND a.[date] = i.[date]






CREATE VIEW [dbo].[vw_portfolioValuePeriod]
WITH SCHEMABINDING
AS
SELECT 
	a.[date],
	a.dateUTC,
	a.nextDate,
	a.nextDateUTC,
	a.prevDate,
	a.prevDateUTC,
	a.portfolioId,
	b.valuationTimeZone,
	b.calculationCalendarId,
	b.reviewCalendarId,
	reviewPeriodId = d.id,
	b.currencyRateTypeId,
	currencyRateDate = c.[date],
	currencyRatePrevDate = c.prevDate
FROM [dbo].[portfolioValuePeriod] AS a
JOIN [dbo].[portfolioConfig] AS b ON a.portfolioId = b.portfolioId AND b.validFrom <= a.[date] AND b.validTo > a.[date]
JOIN [dbo].[currencyPeriod] AS c ON b.currencyRateTypeId = c.currencyRateTypeId AND c.dateUTC <= a.dateUTC AND c.nextDateUTC > a.dateUTC
JOIN [dbo].[reviewPeriod] AS d ON b.reviewCalendarId = d.reviewCalendarId AND d.validFrom <= a.[date] AND d.validTo > a.[date]



GO
CREATE UNIQUE CLUSTERED INDEX [CIX_vw_portfolioValuePeriod]
    ON [dbo].[vw_portfolioValuePeriod]([portfolioId] ASC, [date] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UIX_vw_portfolioValuePeriod]
    ON [dbo].[vw_portfolioValuePeriod]([date] ASC, [portfolioId] ASC)
    INCLUDE([dateUTC], [nextDate], [nextDateUTC], [prevDate], [prevDateUTC], [valuationTimeZone], [calculationCalendarId], [reviewCalendarId], [reviewPeriodId], [currencyRateTypeId], [currencyRateDate], [currencyRatePrevDate]);


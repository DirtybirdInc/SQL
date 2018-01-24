








CREATE VIEW [dbo].[vw_currencyRate]
AS
--exchange rates and inversed exchange rates
SELECT 
	a.date,
	a.currencyRateTypeId,
	currencyRateTypeCode = b.code,
	currencyRateTypeName = b.name,
	currencyRateTypeDescript = b.descript,
	'BASE' AS rateType,
	fromCode = CASE rateType 
		WHEN 1 THEN a.toCode
		WHEN 2 THEN b.baseCode END,
	toCode = CASE rateType 
		WHEN 1 THEN b.baseCode 
		WHEN 2 THEN a.toCode END,
	rate = CASE rateType 
		WHEN 1 THEN CAST(1 AS FLOAT)/a.rate
		WHEN 2 THEN a.rate END
FROM dbo.currencyRate AS a
JOIN dbo.currencyRateType AS b ON a.currencyRateTypeId = b.id
JOIN (VALUES (1),(2)) AS r(rateType) ON 1 = 1

UNION ALL

--exchange rates, inversed exchange rates and crossrates
SELECT 
	a.date,
	a.currencyRateTypeId,
	currencyRateTypeCode = b.code,
	currencyRateTypeName = b.name,
	currencyRateTypeDescript = b.descript,
	'ALL' AS rateType,
	fromCode = CASE rateType 
		WHEN 1 THEN a.toCode
		WHEN 2 THEN b.baseCode
		WHEN 3 THEN a.toCode END,
	toCode = CASE rateType 
		WHEN 1 THEN b.baseCode 
		WHEN 2 THEN a.toCode
		WHEN 3 THEN d.toCode END,
	rate = CASE rateType 
		WHEN 1 THEN CAST(1 AS FLOAT)/a.rate
		WHEN 2 THEN a.rate
		WHEN 3 THEN CAST(1 AS FLOAT)/a.rate*d.rate END
FROM dbo.currencyRate AS a
JOIN dbo.currencyRateType AS b ON a.currencyRateTypeId = b.id
JOIN (VALUES (1),(2),(3)) AS r(rateType) ON 1 = 1
LEFT JOIN dbo.currencyRate AS d ON r.rateType = 3 AND a.currencyRateTypeId = d.currencyRateTypeId AND a.date = d.date AND a.toCode != d.toCode












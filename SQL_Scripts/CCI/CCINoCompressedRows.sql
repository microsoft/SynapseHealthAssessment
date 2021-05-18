SELECT  a.[Schema_Name],
		a.[Table_Name],
		a.Distribution_Type,
		COALESCE(SUM(c.rg_total_rows), 0) AS compressed_total_rows
	FROM [dbo].[CCI_MetaData] a
		LEFT OUTER JOIN [dbo].[CCI_MetaData] c
			ON  a.[Schema_Name] = c.[Schema_Name]
			AND a.[Table_Name]  = c.[Table_Name]
			AND c.rg_state = 3
	GROUP BY a.[Schema_Name], a.[Table_Name], a.Distribution_Type
	HAVING COALESCE(SUM(c.rg_total_rows), 0) = 0
	ORDER BY a.[Schema_Name], a.[Table_Name]

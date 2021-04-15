SELECT               
		a.[Schema_Name],
		a.[Table_Name],
		a.Distribution_Type,
		SUM(c.rg_total_rows) AS compressed_total_rows,
		SUM(c.rg_deleted_rows) AS compressed_deleted_rows

	FROM [dbo].[CCI_MetaData] a
		LEFT OUTER JOIN [dbo].[CCI_MetaData] c
			ON  a.[Schema_Name] = c.[Schema_Name]
			AND a.[Table_Name]  = c.[Table_Name]
			AND c.rg_state = 3
	GROUP BY a.[Schema_Name], a.[Table_Name], a.Distribution_Type
	ORDER BY a.[Schema_Name], a.[Table_Name]
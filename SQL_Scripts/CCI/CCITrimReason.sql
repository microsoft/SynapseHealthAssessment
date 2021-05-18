WITH 
	cte_All_RowGroups AS (
		SELECT	[Schema_Name], 
				[Table_Name],
				Distribution_Type,
				COUNT(*) AS rg_count
		FROM [dbo].[CCI_MetaData]
		GROUP BY [Schema_Name], [Table_Name], Distribution_Type ),
	cte_Compressed_RowGroups AS (
		SELECT	[Schema_Name], 
				[Table_Name],
				rg_trim_reason,
				rg_trim_reason_desc,
				COUNT(*) AS rg_trim_reason_count
		FROM [dbo].[CCI_MetaData]
		WHERE rg_state = 3
		GROUP BY [Schema_Name], [Table_Name], rg_trim_reason, rg_trim_reason_desc )
	SELECT	a.*,
			c.rg_trim_reason,
			c.rg_trim_reason_desc,
			c.rg_trim_reason_count
		FROM cte_All_RowGroups a
			LEFT OUTER JOIN cte_Compressed_RowGroups c
				ON  a.[Schema_Name] = c.[Schema_Name]
				AND a.[Table_Name]  = c.[Table_Name]
		ORDER BY a.[Schema_Name], a.[Table_Name]


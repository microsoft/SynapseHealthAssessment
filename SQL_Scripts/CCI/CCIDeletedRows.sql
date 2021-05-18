SELECT  [Schema_Name],
		[Table_Name],
		Distribution_Type,
		SUM(rg_total_rows) AS compressed_total_rows,
		SUM(rg_deleted_rows) AS compressed_deleted_rows
	FROM [dbo].[CCI_MetaData]
	WHERE rg_state = 3
	GROUP BY [Schema_Name], [Table_Name], Distribution_Type
	ORDER BY [Schema_Name], [Table_Name]
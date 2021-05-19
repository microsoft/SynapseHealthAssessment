/*
	=================================
	   CCI Deleted Rows
	=================================
        Ths query reports the deleted rows in CCI tables, which can cause significant performance degradation

*/
SELECT
        SYSDATETIME()        as 'Collection_Date',
        DB_Name(),
        [Schema_Name],
        [Table_Name],
        Distribution_Type,
        SUM(rg_total_rows)   as compressed_total_rows,
        SUM(rg_deleted_rows) as compressed_deleted_rows
    FROM [dbo].[v_CCI_MetaData]
    WHERE rg_state = 3
    GROUP BY [Schema_Name], [Table_Name], Distribution_Type
    ORDER BY [Schema_Name], [Table_Name]
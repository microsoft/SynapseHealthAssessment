/*
	=================================
	   CCI No Compressed Rows
	=================================
        CCI tables without compressed rows will not perform well.
        If a CCI table has 0 compressed rows, it may be better organized as a RowStore table

*/
SELECT
        SYSDATETIME()                     as 'Collection_Date',
        DB_Name(),
        a.[Schema_Name],
        a.[Table_Name],
        a.Distribution_Type,
        COALESCE(SUM(c.rg_total_rows), 0) as compressed_total_rows
    FROM [dbo].[v_CCI_MetaData] a
        LEFT OUTER JOIN [dbo].[CCI_MetaData] c
            ON a.[Schema_Name] = c.[Schema_Name]
            AND a.[Table_Name]  = c.[Table_Name]
            AND c.rg_state = 3
    GROUP BY a.[Schema_Name], a.[Table_Name], a.Distribution_Type
    HAVING COALESCE(SUM(c.rg_total_rows), 0) = 0
    ORDER BY a.[Schema_Name], a.[Table_Name]

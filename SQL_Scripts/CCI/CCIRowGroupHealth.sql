/*
	=================================
	   CCI Row Group Health 
	=================================
	This query will capture the overall Health of the CCI table

*/
SELECT               
        SYSDATETIME()                                                   as 'Collection_Date',
        DB_Name(),
        [Schema_Name],
        [Table_Name],
        Distribution_Type,
        SUM(rg_total_rows)                                              as 'Total_Rows',

        SUM(CASE WHEN rg_state = 1 THEN 1 else 0 end)                   as 'OPEN_Row_Groups',
        SUM(CASE WHEN rg_state = 1 THEN rg_total_rows else 0 end)       as 'OPEN_rows',
        MIN(CASE WHEN rg_state = 1 THEN rg_total_rows else NULL end)    as 'MIN OPEN Row Group Rows',
        MAX(CASE WHEN rg_state = 1 THEN rg_total_rows else NULL end)    as 'MAX OPEN_Row Group Rows',
        AVG(CASE WHEN rg_state = 1 THEN rg_total_rows else NULL end)	as 'AVG OPEN_Row Group Rows',

        SUM(CASE WHEN rg_state = 3 THEN 1 else 0 end)                   as 'COMPRESSED_Row_Groups',
        SUM(CASE WHEN rg_state = 3 THEN rg_total_rows else 0 end)       as 'COMPRESSED_Rows',
        SUM(CASE WHEN rg_state = 3 THEN rg_deleted_rows else 0 end)     as 'Deleted_COMPRESSED_Rows',
        MIN(CASE WHEN rg_state = 3 THEN rg_total_rows else NULL end)    as 'MIN COMPRESSED Row Group Rows',
        MAX(CASE WHEN rg_state = 3 THEN rg_total_rows else NULL end)    as 'MAX COMPRESSED Row Group Rows',
        AVG(CASE WHEN rg_state = 3 THEN rg_total_rows else NULL end)    as 'AVG_COMPRESSED_Rows',
 
        SUM(CASE WHEN rg_state = 2 THEN 1 else 0 end)                   as 'CLOSED_Row_Groups',
        SUM(CASE WHEN rg_state = 2 THEN rg_total_rows else 0 end)       as 'CLOSED_Rows',
        MIN(CASE WHEN rg_state = 2 THEN rg_total_rows else NULL end)    as 'MIN CLOSED Row Group Rows',
        MAX(CASE WHEN rg_state = 2 THEN rg_total_rows else NULL end)    as 'MAX CLOSED Row Group Rows',
        AVG(CASE WHEN rg_state = 2 THEN rg_total_rows else NULL end)    as 'AVG CLOSED Row Group Rows'
    FROM [dbo].[v_CCI_MetaData]
    GROUP BY [Schema_Name], [Table_Name], Distribution_Type
    ORDER BY [Schema_Name], [Table_Name]


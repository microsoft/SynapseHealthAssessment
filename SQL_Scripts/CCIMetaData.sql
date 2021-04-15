-- This query captures the metadata for the subsequent CCI health queries.

CREATE TABLE CCI_MetaData 
WITH (HEAP, DISTRIBUTION = ROUND_ROBIN)
AS
SELECT               
	s.[name]														as 'Schema_Name',
    t.[name]														as 'Table_Name',
	tdp.distribution_policy_desc									as 'Distribution_type',
	pt.distribution_id												as 'Distribution_Num',
	rg.partition_number												as 'Partition_Num',
	rg.row_group_id													as 'Row_Group_ID',
	rg.[state]														as 'rg_state',
	rg.state_desc													as 'rg_state_desc',
	rg.total_rows													as 'rg_total_rows',
	rg.deleted_rows													as 'rg_deleted_rows',
	rg.[size_in_bytes]												as 'rg_size_bytes',
	rg.trim_reason													as 'rg_trim_reason',
	rg.trim_reason_desc												as 'rg_trim_reason_desc'
FROM sys.dm_pdw_nodes_db_column_store_row_group_physical_stats rg
INNER JOIN sys.pdw_nodes_tables pt
	ON rg.object_id = pt.object_id
	AND rg.pdw_node_id = pt.pdw_node_id
	AND rg.distribution_id = pt.distribution_id
INNER JOIN sys.pdw_table_mappings mp
	ON pt.name = mp.physical_name
INNER JOIN sys.tables t
	ON     mp.object_id = t.object_id
INNER JOIN sys.schemas s
    ON t.schema_id = s.schema_id
INNER JOIN sys.pdw_table_distribution_properties tdp
	ON tdp.object_id = t.object_id
INNER JOIN sys.indexes i
		on t.object_id = i.object_id
WHERE i.[type] = 5		-- CCI indexes only

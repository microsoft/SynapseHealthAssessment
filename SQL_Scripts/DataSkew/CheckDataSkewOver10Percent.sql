/*
	========================================
	   Find tables with data skew over 10%
	========================================
	This query will return tables that have data skew over 10%. These tables could be affecting query processing time and a different distribution column should be considered.
	PRE-REQUISITE: must have the vtableSizes view created: https://raw.githubusercontent.com/Microsoft/AzureDW_Query_Toolbox/master/TableInformation/CreateTableInfoView.dsql
	Source: https://docs.microsoft.com/en-us/azure/sql-data-warehouse/sql-data-warehouse-tables-distribute
*/

select *
from dbo.vTableSizes
where two_part_name in
    (
    select two_part_name
    from dbo.vTableSizes
    where row_count > 0
    group by two_part_name
    having (max(row_count * 1.000) - min(row_count * 1.000))/max(row_count * 1.000) >= .10
    )
order by two_part_name, row_count
;
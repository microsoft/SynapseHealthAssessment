/*This query finds the maximum execution time of queries that use UNION instead of UNION ALL*/
SELECT
       q.query_id               [query_id]
	   ,p.plan_id
       , t.query_sql_text       [command]
       , rs.avg_duration/60000000        [avg_duration_min]
       , rs.min_duration/60000000        [min_duration_min]
       , rs.max_duration/60000000        [max_duration_min]
FROM
       sys.query_store_query q
       JOIN sys.query_store_query_text t ON q.query_text_id = t.query_text_id
       JOIN sys.query_store_plan p ON p.query_id = q.query_id
       JOIN sys.query_store_runtime_stats rs ON rs.plan_id = p.plan_id
WHERE
       --q.query_id = 10
	    t.query_sql_text like '%UNION%'
	AND t.query_SQL_TEXT not like '%UNION ALL%'
       --AND rs.avg_duration > 0;
ORDER BY rs.max_duration desc
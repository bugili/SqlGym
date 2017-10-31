
select cp.refcounts
	,cp.usecounts
	,st.dbid
	,st.objectid
	,st.text
	,qp.query_plan
from sys.dm_exec_cached_plans cp
	cross apply sys.dm_exec_sql_text(cp.plan_handle) as st
	cross apply sys.dm_exec_query_plan(cp.plan_handle) as qp
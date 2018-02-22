SELECT
    request_session_id
    ,resource_type
    ,resource_database_id
    ,DB_NAME(resource_database_id) as DBName
    ,resource_description
    ,resource_associated_entity_id
    --,isnull(OBJECT_Name(resource_associated_entity_id),'Nema') as obj 
    ,request_mode
    ,request_status
from sys.dm_tran_locks;

--select OBJECT_NAME(693577509)


SELECT 
    session_id
    ,connect_time
    ,last_read
    ,last_write
    ,most_recent_sql_handle
from sys.dm_exec_connections
where session_id IN (57,62);

SELECT
    session_id, st.text 
from sys.dm_exec_connections
    cross APPLY sys.dm_exec_sql_text(most_recent_sql_handle) as st 
where session_id in (57,62);

SELECT
    session_id as spid
    ,login_time
    ,host_name
    ,program_name
    ,login_name
    ,nt_user_name
    ,last_request_start_time
    ,last_request_end_time
from sys.dm_exec_sessions;
--where open_transaction_count > 0

SELECT
    session_id as spid
    ,blocking_session_id
    ,command
    ,database_id
    ,sql_handle
    ,wait_type
    ,wait_time
    ,wait_resource
FROM sys.dm_exec_requests
where blocking_session_id > 0;

kill 57;

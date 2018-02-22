
SELECT 
    jobv.name
    ,jobv.enabled
    ,jobv.[description]
    ,jobv.date_created
    ,jobv.date_modified
    ,steps.step_name
    ,steps.command
    ,steps.on_success_action
    ,sch.next_run_date
    ,sch.next_run_time
from msdb.dbo.sysjobs_view as jobV
    join msdb.dbo.sysjobsteps as steps 
        on steps.job_id = jobv.job_id
    join msdb.dbo.sysjobschedules as sch 
        on sch.job_id = jobV.job_id
where jobV.name like '%e';


use msdb;
exec sp_delete_job @job_name = N'jobf';
go

exec sp_help_job

select * from sys.dm_hadr_availability_replica_cluster_states
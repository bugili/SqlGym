if object_id('dbo.AuditDDLEvents2','u') is not NULL
    drop TABLE dbo.AuditDDLEvents2;

create table dbo.AuditDDLEvents2
(
    audit_lsn           int         not null        IDENTITY
    ,posttime           datetime    not NULL    
    ,eventtype          SYSNAME     not NULL
    ,loginname          SYSNAME     not NULL
    ,schemaname         SYSNAME     not NULL
    ,objectname         SYSNAME     not NULL
    ,targetobjectname   SYSNAME     NULL
    ,eventdata          XML         NOT NULL
    ,CONSTRAINT PK_AuditDDLEvents2 PRIMARY KEY(audit_lsn)
);
go 

if OBJECT_ID('trg_audit_ddl_events','tr') is not NULL
    drop TRIGGER trg_audit_ddl_events;
GO

create TRIGGER trg_audit_ddl_events 
    on DATABASE for ddl_database_level_events
AS
set NOCOUNT on;

DECLARE @eventdata XML = eventdata();

insert into dbo.AuditDDLEvents
(
    posttime, eventtype, loginname, schemaname, objectname, targetobjectname, eventdata
)
VALUES
(
    @eventdata.value('(/EVENT_INSTANCE/PostTime)[1]', 'VARCHAR(23)'),
    @eventdata.value('(/EVENT_INSTANCE/EventType)[1]', 'sysname'),
    @eventdata.value('(/EVENT_INSTANCE/LoginName)[1]', 'sysname'),
    @eventdata.value('(/EVENT_INSTANCE/SchemaName)[1]', 'sysname'),
    @eventdata.value('(/EVENT_INSTANCE/ObjectName)[1]', 'sysname'),
    @eventdata.value('(/EVENT_INSTANCE/TargetObjectName)[1]', 'sysname'),
    @eventdata
);
go 

create TABLE dbo.t1(col1 int not null PRIMARY key);
ALTER TABLE dbo.t1 add col2 int null;
alter TABLE dbo.t1 alter COLUMN col2 int not NULL;
create NONCLUSTERED INDEX idx1 on dbo.t1(col2);

select *
from dbo.AuditDDLEvents2

DROP TRIGGER trg_audit_ddl_events ON DATABASE;
DROP TABLE dbo.AuditDDLEvents;
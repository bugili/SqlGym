if OBJECT_ID('dbo.t1_audit','u') is not null drop table dbo.t1_audit;
if OBJECT_ID('dbo.t1','u') is not NULL drop table dbo.t1;
go 

create table dbo.t1 
(
    keycol int not null PRIMARY KEY
    ,datacol varchar(10) not null 
);

create TABLE dbo.t1_audit
(
    audit_lsn   int         not NULL IDENTITY PRIMARY KEY
    ,dt         DATETIME    not NULL DEFAULT(sysdatetime())
    ,login_name SYSNAME     not null default(original_login())
    ,keycol     int         not null
    ,datacol    varchar(10) not null 
);

go 

create TRIGGER trg_T1_insert_audit on dbo.t1 after INSERT
as 
set NOCOUNT on;

insert into dbo.t1_audit(keycol,datacol)
    select keycol, datacol from inserted;
go

INSERT into dbo.t1(keycol,datacol) VALUES(10,'a');
INSERT into dbo.t1(keycol,datacol) VALUES(30,'x');
INSERT into dbo.t1(keycol,datacol) VALUES(20,'g');
go 

select *
from dbo.t1_audit;

IF OBJECT_ID('dbo.T1_Audit', 'U') IS NOT NULL DROP TABLE dbo.T1_Audit;
IF OBJECT_ID('dbo.T1', 'U') IS NOT NULL DROP TABLE dbo.T1;
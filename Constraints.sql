use SqlGym

select * 
from sys.dm_hadr_availability_group_states

use master

create table dbo.narudzbe
(
    orderid int not null
    ,empid  int not NULL
    ,custid VARCHAR(20) not null
    ,orders DATETIME not NULL
    ,qty    int     not NULL
    ,CONSTRAINT pk_narudzbe
        PRIMARY KEY(orderid)
)

create TABLE dbo.zaposleni
(
    empid       INT         not NULL
    ,firstname  VARCHAR(20) not NULL
    ,lastname   VARCHAR(30) not NULL
    ,hiredate   DATE        not NULL
    ,mgrid      int         NULL
    ,ssn        VARCHAR(20) not NULL
    ,salary     money       not NULL
);

alter table dbo.zaposleni
    add CONSTRAINT pk_zaposleni
        PRIMARY KEY(empid);

ALTER TABLE dbo.zaposleni
    add CONSTRAINT unq_zaposleni_ssn
    UNIQUE(ssn);

alter TABLE dbo.narudzbe
    add CONSTRAINT fk_narudzbe_empid
    FOREIGN KEY(empid)
    REFERENCES dbo.zaposleni(empid);

ALTER TABLE dbo.zaposleni
    add CONSTRAINT fk_zaposleni_mgrid
    FOREIGN KEY(mgrid)
    REFERENCES dbo.zaposleni(empid);
go

alter TABLE dbo.zaposleni
    add CONSTRAINT chk_zaposleni_salary
    CHECK(salary > 0);

exec sp_rename 'dbo.narudzbe.orders','orderts'

alter TABLE dbo.narudzbe
    add CONSTRAINT dft_zaposleni_orderts
    DEFAULT(sysdatetime()) for orderts;

alter TABLE dbo.zaposleni
    add CONSTRAINT dft_zaposleni_hiredate
    DEFAULT(sysdatetime()) FOR hiredate

select 
values(1)

use TSQL2012
select name,schema_name(schema_id)
from sys.tables 

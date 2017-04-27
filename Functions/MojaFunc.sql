CREATE FUNCTION GetLoginPermission
(
	@Login as varchar(50)
)
RETURNS TABLE
AS
RETURN
	
	select 
		perm.class_desc
		,Coalesce(obj.name,sch.name,'nema') as ObjectName
		,princ.name
		,permission_name
		,perm.state_desc 
	from 
		sys.database_permissions perm
			join
		sys.database_principals as princ on grantee_principal_id = princ.principal_id
			left join 
		sys.all_objects as obj on perm.major_id = obj.object_id
			left join
		sys.schemas as sch on sch.schema_id = perm.major_id
			left join
		sys.databases as db on db.database_id = perm.major_id
	where princ.name LIKE '%' + @Login + '%'

go
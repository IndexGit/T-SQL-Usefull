
DECLARE
	@ObjName varchar(200) = 'cmdb_Servers'


-- � ����������� �� ����
SELECT 
	a.article, p.publisher_db , p.publication
FROM     
	distribution.dbo.MSarticles a 
	INNER JOIN distribution.dbo.MSpublications p ON 
		a.publication_id = p.publication_id
WHERE 
	a.article like '%'+@ObjName+'%'
ORDER BY a.article

-- � ������� ���
SELECT 
*
FROM
	MSreplication_objects
WHERE
	article like '%'+@ObjName+'%'


SELECT --TOP 100
*
FROM
	cmdb_IResources
WHERE
	ResTypeID = 5 and
	ServerID = 369

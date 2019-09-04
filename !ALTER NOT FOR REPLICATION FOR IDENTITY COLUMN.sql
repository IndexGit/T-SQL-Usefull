DECLARE @int int
SET @int = object_id('dbo.Gruz')

EXEC sys.sp_identitycolumnforreplication @int, 1
GO
IF NOT EXISTS ( SELECT  1 FROM sys.columns WHERE object_id = OBJECT_ID ('AnalArt') and name = 'BalanceObjectID') and
EXISTS ( SELECT  1 FROM sys.objects where object_id = OBJECT_ID ('AnalArt') and is_published = 1 )

                ALTER TABLE AnalArt ADD           BalanceObjectID int NULL
GO

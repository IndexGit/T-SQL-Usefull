SELECT 
	name AS 'Pool Name', 
	cache_memory_kb/1024.0 AS [cache_memory_MB], 
	used_memory_kb/1024.0 AS [used_memory_MB] 
FROM 
	sys.dm_resource_governor_resource_pools;

DBCC FREEPROCCACHE

DBCC DROPCLEANBUFFERS

--sp_who2 active
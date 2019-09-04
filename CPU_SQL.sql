--SELECT * FROM sys.dm_os_sys_info

DECLARE @ts_now bigint 
SET @ts_now= (SELECT cpu_ticks/(cpu_ticks/ms_ticks)FROM sys.dm_os_sys_info); 

SELECT TOP(240) SQLProcessUtilization AS [SQL Server Process CPU Utilization], 
               SystemIdle AS [System Idle Process], 
               --100 - SystemIdle - SQLProcessUtilization AS [Other Process CPU Utilization], 
               DATEADD(ms, -1 * (@ts_now - [timestamp]), GETDATE()) AS [Event Time] 
FROM ( 
	  SELECT record.value('(./Record/@id)[1]', 'int') AS record_id, 
			record.value('(./Record/SchedulerMonitorEvent/SystemHealth/SystemIdle)[1]', 'int') 
			AS [SystemIdle], 
			record.value('(./Record/SchedulerMonitorEvent/SystemHealth/ProcessUtilization)[1]', 
			'int') 
			AS [SQLProcessUtilization], [timestamp] 
	  FROM ( 
			SELECT [timestamp], CONVERT(xml, record) AS [record] 
			FROM sys.dm_os_ring_buffers 
			WHERE ring_buffer_type = N'RING_BUFFER_SCHEDULER_MONITOR' 
			AND record LIKE '%<SystemHealth>%') AS x 
	  ) AS y 
ORDER BY record_id DESC;




SELECT
    cpu_sql = (
            MAX(CASE WHEN counter_name = 'CPU usage %' THEN t.cntr_value * 1. END) /
            MAX(CASE WHEN counter_name = 'CPU usage % base' THEN t.cntr_value END)
        ) * 100
FROM (
    SELECT TOP(2) cntr_value, counter_name
    FROM sys.dm_os_performance_counters
    WHERE counter_name IN ('CPU usage %', 'CPU usage % base')
        AND instance_name = 'default'
) t
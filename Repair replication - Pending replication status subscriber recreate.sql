use [CMDBUTEST]

-- INFO
exec [distribution].sys.sp_replmonitorhelpsubscription 
	@publisher=@@SERVERNAME,
	@publisher_db = N'GENERALUTEST', 
	@publication = N'GENERALUTEST_GSPi', 
	@mode = 0,--7, 
	@exclude_anonymous = 1



	exec sp_helpsubscription @publication = N'GENERALUTEST_GSPi', @subscriber = N'SQLMSKTEST12', @destination_db = N'RSPP08FUTEST', @article = N'all'
--	exec sp_helpsubscription @publication = N'GENERALUTEST_GSPi', @subscriber = N'SQLMSKTEST13', @destination_db = N'NSBPP07FUTEST', @article = N'all'

-- RECREATE subscriber

exec sp_dropsubscription @publication = N'GENERALUTEST_GSPi', @subscriber = N'SQLMSKTEST12', @destination_db = N'RSPP08FUTEST', @article = N'all'
GO
exec sp_addsubscription @publication = N'GENERALUTEST_GSPi', @subscriber = N'SQLMSKTEST12', @destination_db = N'RSPP08FUTEST', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0
exec sp_addpushsubscription_agent @publication = N'GENERALUTEST_GSPi', @subscriber = N'SQLMSKTEST12', @subscriber_db = N'RSPP08FUTEST'
, @job_login = null, @job_password = null, @subscriber_security_mode = 1, @frequency_type = 4, @frequency_interval = 1, @frequency_relative_interval = 1, @frequency_recurrence_factor = 0, @frequency_subday = 8, @frequency_subday_interval = 1, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @dts_package_location = N'Distributor'
GO

exec sp_startpublication_snapshot  @publication= N'GENERALUTEST_GSPi' 
GO

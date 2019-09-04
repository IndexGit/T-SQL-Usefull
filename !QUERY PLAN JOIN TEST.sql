/*
create table #t_int_index(t int)
create index ix_t_int_index  ON #t_int_index (t)
create table #t_int(t int)
create table #t_bigint_index(t bigint)
create index ix_t_bigint_index  ON #t_bigint_index (t)
create table #t_bigint(t bigint)
*/
select RAND()

SELECT 

	POWER(2,CASE WHEN c1.column_id >30 THEN c1.column_id ) as i-- Int 2147483647
	-- BigInt 9223372036854775807 
FROM
	sys.columns c1
	CROSS JOIN sys.columns c2

	select sqrt(2147483647),POWER(2,30)

declare
	@i bigint = 0,
	@total bigint = 1000000,
	@r_int int,
	@r_bigint bigint

while @i < @total
begin
	SELECT
		@r_int = RAND()*1000*RAND()*1000,
		@r_bigint = RAND()*10000*POWER(10,RAND())*POWER(3,RAND()*RAND()*10),
		@i = @i + 1

--	select @r_int, @r_bigint
	
	INSERT INTO #t_int_index VALUES (@r_int)
	INSERT INTO #t_int VALUES (@r_int)
	INSERT INTO #t_bigint_index VALUES (@r_bigint)
	INSERT INTO #t_bigint VALUES (@r_bigint)
end


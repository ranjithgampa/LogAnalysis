beeline -u jdbc:hive2:// --outputformat=csv2 --silent=true  -e  'select url,request_method,
sum(case when duration <= 1000 then 1 else 0 end ) O_to_1_Sec,
sum(case when (duration > 1000 and duration <= 2000) then 1 else 0 end ) 1_to_2_Sec,
sum(case when (duration > 2000 and duration <= 3000) then 1 else 0 end ) 2_to_3_Sec,
sum(case when (duration > 3000 and duration <= 4000) then 1 else 0 end ) 3_to_4_Sec,
sum(case when duration > 4000 then 1 else 0 end ) above_4_Sec,
count(*) total_no_of_requests,
avg(duration) avg_duration,
min(duration) min_duration,
max(duration) max_duration
from localhost_access_log 
where url not like "/services/security/security-principals%"
and dateString >"2016-04-16"
group by url,request_method' > 	/mnt/hgfs/HadoopTrasfer/LocalHostAccessLogAnalysis/AverageServiceDuration.csv


beeline -u jdbc:hive2:// --outputformat=csv2 --silent=true  -e  'select url,request_method, to_date(datestring) ,
sum(case when duration <= 1000 then 1 else 0 end ) O_to_1_Sec,
sum(case when (duration > 1000 and duration <= 2000) then 1 else 0 end ) 1_to_2_Sec,
sum(case when (duration > 2000 and duration <= 3000) then 1 else 0 end ) 2_to_3_Sec,
sum(case when (duration > 3000 and duration <= 4000) then 1 else 0 end ) 3_to_4_Sec,
sum(case when duration > 4000 then 1 else 0 end ) above_4_Sec,
count(*) total_no_of_requests,
avg(duration) avg_duration,
min(duration) min_duration,
max(duration) max_duration
from localhost_access_log 
where url not like "/services/security/security-principals%"
and dateString >"2016-04-16"
group by url,request_method, to_date(datestring)' > /mnt/hgfs/HadoopTrasfer/LocalHostAccessLogAnalysis/AverageServiceDurationByDay.csv

beeline -u jdbc:hive2:// --outputformat=csv2 --silent=true  -e  'select url,request_method, hour(datestring) ,
sum(case when duration <= 1000 then 1 else 0 end ) O_to_1_Sec,
sum(case when (duration > 1000 and duration <= 2000) then 1 else 0 end ) 1_to_2_Sec,
sum(case when (duration > 2000 and duration <= 3000) then 1 else 0 end ) 2_to_3_Sec,
sum(case when (duration > 3000 and duration <= 4000) then 1 else 0 end ) 3_to_4_Sec,
sum(case when duration > 4000 then 1 else 0 end ) above_4_Sec,
count(*) total_no_of_requests,
avg(duration) avg_duration,
min(duration) min_duration,
max(duration) max_duration
from localhost_access_log 
where url not like "/services/security/security-principals%"
and dateString >"2016-04-16"
group by url,request_method, hour(datestring)' > /mnt/hgfs/HadoopTrasfer/LocalHostAccessLogAnalysis/AverageServiceDurationHour.csv
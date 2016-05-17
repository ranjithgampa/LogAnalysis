beeline -u jdbc:hive2:// --outputformat=csv2 --silent=true  -e  'select operation,
sum(case when cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) <= 1000 then 1 else 0 end ) O_to_1_Sec,
sum(case when (cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) > 1000 and cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) <= 2000) then 1 else 0 end ) 1_to_2_Sec,
sum(case when (cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) > 2000 and cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) <= 3000) then 1 else 0 end ) 2_to_3_Sec,
sum(case when (cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) > 3000 and cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) <= 4000) then 1 else 0 end ) 3_to_4_Sec,
sum(case when cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) > 4000 then 1 else 0 end ) above_4_Sec,
count(*) total_no_of_requests,
avg(cast(get_json_object(moms_client_log.json, "$.totalTime") As INT)) avg_duration,
min(cast(get_json_object(moms_client_log.json, "$.totalTime") As INT)) min_duration,
max(cast(get_json_object(moms_client_log.json, "$.totalTime") As INT)) max_duration
from moms_client_log 
where cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) > 0
group by operation
having avg_duration is not null' >/mnt/hgfs/HadoopTrasfer/LogAnalysis/MOMSClientLogs/AverageServiceDuration.csv



beeline -u jdbc:hive2:// --outputformat=csv2 --silent=true  -e  'select operation,to_date(timeStamp),
sum(case when cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) <= 1000 then 1 else 0 end ) O_to_1_Sec,
sum(case when (cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) > 1000 and cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) <= 2000) then 1 else 0 end ) 1_to_2_Sec,
sum(case when (cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) > 2000 and cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) <= 3000) then 1 else 0 end ) 2_to_3_Sec,
sum(case when (cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) > 3000 and cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) <= 4000) then 1 else 0 end ) 3_to_4_Sec,
sum(case when cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) > 4000 then 1 else 0 end ) above_4_Sec,
count(*) total_no_of_requests,
avg(cast(get_json_object(moms_client_log.json, "$.totalTime") As INT)) avg_duration,
min(cast(get_json_object(moms_client_log.json, "$.totalTime") As INT)) min_duration,
max(cast(get_json_object(moms_client_log.json, "$.totalTime") As INT)) max_duration
from moms_client_log 
where cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) > 0
group by operation,to_date(timeStamp)
having avg_duration is not null' >/mnt/hgfs/HadoopTrasfer/LogAnalysis/MOMSClientLogs/AverageServiceDurationByDay.csv



beeline -u jdbc:hive2:// --outputformat=csv2 --silent=true  -e  'select operation,hour(timeStamp),
sum(case when cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) <= 1000 then 1 else 0 end ) O_to_1_Sec,
sum(case when (cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) > 1000 and cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) <= 2000) then 1 else 0 end ) 1_to_2_Sec,
sum(case when (cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) > 2000 and cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) <= 3000) then 1 else 0 end ) 2_to_3_Sec,
sum(case when (cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) > 3000 and cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) <= 4000) then 1 else 0 end ) 3_to_4_Sec,
sum(case when cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) > 4000 then 1 else 0 end ) above_4_Sec,
count(*) total_no_of_requests,
avg(cast(get_json_object(moms_client_log.json, "$.totalTime") As INT)) avg_duration,
min(cast(get_json_object(moms_client_log.json, "$.totalTime") As INT)) min_duration,
max(cast(get_json_object(moms_client_log.json, "$.totalTime") As INT)) max_duration
from moms_client_log 
where cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) > 0
group by operation,hour(timeStamp)
having avg_duration is not null' >/mnt/hgfs/HadoopTrasfer/LogAnalysis/MOMSClientLogs/AverageServiceDurationHour.csv



beeline -u jdbc:hive2:// --outputformat=csv2 --silent=true  -e  'select cast(get_json_object(moms_client_log.json, "$.totalTime") As INT) 
from moms_client_log where operation="openOrder" and timestamp > "2016-05-03" and timestamp<"2016-05-04" ' >/mnt/hgfs/HadoopTrasfer/LogAnalysis/MOMSClientLogs/temp.csv
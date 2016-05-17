select avg(duration) avg, url, count(*) from localhost_access_log 
where url not like '/services/security/security-principals%' 
group by url
order by avg desc;

select min(dateString) , max(dateString) from localhost_access_log

select url, request_method, count(*) noOfRequests, avg(duration) avg, floor(duration * 0.001) noOfSeconds, max(duration) maxDuration, min(duration) minDuration 
from localhost_access_log 
where url not like '/services/security/security-principals%' 
group by url , floor(duration * 0.001),request_method
order by avg desc;

hive -e '
select url, count(*) noOfRequests, avg(duration) avg, floor(duration * 0.001) noOfSeconds, max(duration) maxDuration, min(duration) minDuration 
from localhost_access_log 
where url not like '/services/security/security-principals%' 
group by url , floor(duration * 0.001)
order by avg desc' > /mnt/hgfs/HadoopTrasfer/LocalHostAccessLogAnalysis/output.csv
	
beeline -u jdbc:hive2:// -e '
select url,request_method,
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
group by url,request_method' > 	/mnt/hgfs/HadoopTrasfer/LocalHostAccessLogAnalysis/output2.csv
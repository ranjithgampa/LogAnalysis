--beeline -u jdbc:hive2://
--beeline -u jdbc:hive2://

DROP TABLE IF EXISTS moms_client_log;

create table IF NOT EXISTS moms_client_log(
timeStamp Timestamp,
logLevel String,
thread String,
userName String,
operation String,
userAgent String,
json String
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '^'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH '/mnt/hgfs/HadoopTrasfer/LogAnalysis/MOMSClientLogs/final.log' INTO TABLE moms_client_log;

select * from moms_client_log limit 2;


select operation, avg(get_json_object(moms_client_log.json, '$.totalTime'))
from moms_client_log 
group by operation;
--beeline -u jdbc:hive2://

DROP TABLE IF EXISTS localhost_access_log;

create table IF NOT EXISTS localhost_access_log(
ip varchar(64), 
dateString Timestamp,
request_method varchar(10),
url varchar(4000),
response_code int,
no_of_records int ,
duration int
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '@'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH '/mnt/hgfs/HadoopTrasfer/LocalHostAccessLogAnalysis/final.log' INTO TABLE localhost_access_log;

select * from localhost_access_log limit 2;

select url, avg(duration) as d from localhost_access_log group by url order by d desc limit 5;

select url, avg(duration) as d, count(1) as totalCount from localhost_access_log group by url order by totalCount desc, d desc limit 10;
 
select url, count(1) as totalCount from localhost_access_log where response_code <> 200 group by url  order by totalCount desc; 
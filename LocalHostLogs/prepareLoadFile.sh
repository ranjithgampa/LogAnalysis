#!/bin/sh
rm complete
rm filtered.log
rm final.log
cat Apr17May03/server2/*.bz2 > complete.bz2
bunzip2 complete.bz2
cat Apr17May03/server2/localhost_access.log >> complete
echo "Script execution begins"
echo "Filtering services log entries"
grep "/services" complete> filtered.log
echo "Massage service log file entries"
awk '
BEGIN{
split("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec",months);
    for (i in months) {
        month_nums[months[i]]=i
    }
}
{
month=sprintf("%02d",month_nums[substr($4,5,3)]);
url=$8
if(index(url,"?")>0) {
  url = substr($8,1,index($8,"?")-1)
}
gsub(/[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}/,"",url)
gsub(/\/[0-9]+/,"",url)

print $1"@"substr($4,9,4)"-"month"-"substr($4,2,2)" "substr($4,14)"@"substr($7,2)"@"url"@"$10"@"11"@"substr($12,index($12,"/")+1)

#print $1"@"substr($4,2)"@"substr($7,2)"@"$8"@"$10"@"11"@"substr($12,index($12,"/")+1)
}' filtered.log > final.log

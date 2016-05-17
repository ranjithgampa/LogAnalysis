#!/bin/sh
rm complete
cat ./Server1/*.gz > complete.gz
cat ./Server2/*.gz > complete.gz
gunzip complete.gz
cat ./Server1/momsclient.log >> complete
cat ./Server2/momsclient.log >> complete


echo "Script execution begins"
echo "Massage service log file entries"
awk  '
function getDate ( dateString,month_nums ) {
	 # split(dateString, dateFields, "-")
	 # month = dateFields[2];
	 # gsub ("^0*", "", month);
	 # output =  dateFields[1] "-" month_nums[month] "-" dateFields[3]
	 return substr(dateString,0, index(dateString,",")-1)	
	 
}

BEGIN{
	split("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec",months);
	for (i in months) {
	    month_nums[months[i]]=i
	}
	outputFieldDelimiter ="^"
	inputFieldDelimiter = "]"
	expectedNoOfFields = 7
}
{	
	noOfFields = split($0, fields, inputFieldDelimiter)
	for(i=0; i<=noOfFields; i++){
		field = fields[i]
		gsub(/^[ \t]+|[ \t]+$/, "",field);
		gsub(/^\[/,"",field)
		if(i==1){
			lineString =getDate(field, months)
		}else if(i<=expectedNoOfFields){
			lineString =  lineString outputFieldDelimiter field	
		}else{
			lineString =  lineString inputFieldDelimiter field	
		}
	}
	print lineString
}
' complete > final.log

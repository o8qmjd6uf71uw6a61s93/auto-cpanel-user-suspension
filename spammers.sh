#!/bin/bash
##Script To Monitor Spammers Path

awk '{ if ($0 ~ "cwd" && $0 ~ "home") {print $3} }' /var/log/exim_mainlog | sort | uniq -c | sort -nk 1 > /root/spamusers

User1=`tail -n 5 /root/spamusers | sed -n 5p | cut -d "/" -f 3`
User1Email=`tail -n 5 /root/spamusers | sed -n 5p | cut -d "/" -f 1 | awk '{print $1}'`

User2=`tail -n 5 /root/spamusers | sed -n 4p | cut -d "/" -f 3`
User2Email=`tail -n 5 /root/spamusers | sed -n 4p | cut -d "/" -f 1 | awk '{print $1}'`

User3=`tail -n 5 /root/spamusers | sed -n 3p | cut -d "/" -f 3`
User3Email=`tail -n 5 /root/spamusers | sed -n 3p | cut -d "/" -f 1 | awk '{print $1}'`



##Please Adjust The Value I Made The Default Value 500

if [ $User1Email -gt 500 ]; then
	if [[ `ls /var/cpanel/suspended | grep $User1 | head -n 1` != $User1 ]]; then
		/scripts/suspendacct $User1 [Auto Suspended] 1
	fi


		if [[ $User2Email -gt 500 ]]; then
			if [[ `ls /var/cpanel/suspended | grep $User1 | head -n 1` != $User1 ]]; then
				/scripts/suspendacct $User2 [Auto Suspended] 1
			fi
		fi	

				if [[ $User3Email -gt 500 ]]; then
					if [[ `ls /var/cpanel/suspended | grep $User1 | head -n 1` != $User1 ]]; then
						/scripts/suspendacct $User3 [Auto Suspended] 1
					fi
				fi	

fi

## END

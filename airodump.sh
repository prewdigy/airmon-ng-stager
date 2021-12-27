#/bin/bash

chmod u+x dump2.sh

#maybe make the script check to see if aircrack-ng is installed yet and install it for the user

#declaring the number of adapters and forming a numbered list of them

n="$(airmon-ng | grep "phy" | awk '{print $2}' | sed -n p | tee >(wc -l) | tail -1)"
list="$(airmon-ng | grep "phy" | awk '{print $2}' | sed -n p)"

#step 1:  find out if you will be wanting to keep ethernet enabled

echo "Are you still going to be using ethernet? (Y/n): "
read eth

#step 2 : ask what adapter you would like to use for the airodump

echo "choose the adapter to use for the airodump: [1-$n]"

airmon-ng | grep "phy" | awk '{print $2}' | sed -n p | awk 'NR==1,NR==$n{print NR": "$0}'

read adptNum

#need to convert adaptNum to the actual name of the adapter and make it = $adapt

adapt=$("airmon-ng | grep "phy" | awk '{print $2}' | sed -n "$adptNum"p")

#step 3 : restart and set wifi adapters to monitor mode (for)

echo "Restarting all wifi adapters and setting to monitor mode."

airmon-ng check kill

wait -n
#this is all still too verbose.. make this run quietly and fix the error with airmon start



for wifi in $list
do
	echo "Working on $wifi, Please standby.."
	ifconfig $wifi down
	wait -n
	iwconfig $wifi mode monitor
	wait -n
	airmon-ng start $wifi
	wait -n
done

echo "done."

echo "Reseting ethernet adapter"

if [$eth == "Y"] || [$eth == "y"] || [$eth == "yes"] || [$eth == "Yes"] then

systemctl restart NetworkManager.service
echo "Net-manager.d reset, please check ethernet connection stability..."

fi

#step 3 : display usable adapters for choice of adapter

#step 4 : ask whether to scan 2.4ghz only
echo "Scan only 2.4ghz? (Y/n):"
read ghz

#step 5 : asking if you would like to save output

echo "Would you like to save the output? (Y/n): "
read save

#step 6 : asking what format you would like to save the output a
echo "What format would you like it to save the scan results as?"

#counts the amount of formats
forms=".csv \n.txt \n.xml"

#setting f = the number of choices there are in the list of formats
f="$(echo $forms | wc -l)"

echo "(Available formats: [1-$f])"
echo "$forms" | awk 'NR==1,NR==3{print NR": "$0}'

#reading chosen int from the list that got output for the different format choices
read format

#saving the format string that was chosen as "fmt" converting number selection into name
fmt=$(echo "$forms" | sed -n "$format"p)

#step 7 : running airodump with chosen adapter

echo "Running dump with $adapt, standby.."


#solo 2.4ghz with saving output

if [ $ghz == "Y" ] || [ $ghz == "y" ] || [ $ghz == "yes" ] || [ $ghz == "Yes" ] && [$save == "Y" ] || [ $save == "y" ] || [ $save == "yes" ] || [ $save == "Yes" ]

then
	echo "Saving output of 2.4ghz scan."
	airodump-ng -w dump.scan --output-format $fmt $adapt

fi

#both 2.4ghz and 5ghz with save chosen

if [$save == "Y" ] || [ $save == "y" ] || [ $save == "yes" ] || [ $save == "Yes" ]

then
	echo "Saving output of full frequency scan."
	airodump-ng -b a --output-format $save $adapt

fi

#solo 2.4ghz

	if [ $ghz == "Y" ] || [ $ghz == "y" ] || [ $ghz == "yes" ] || [ $ghz == "Yes" ]
then
	echo "Scanning only 2.4ghz."
	airodump-ng $adapt
fi

#both 2.4ghz and 5ghz no save

	if [ $ghz == "N" ] || [ $ghz == "n" ] || [ $ghz == "no" ] || [ $ghz == "No" ]
then
	echo "Scanning full frequency."
	airodump-ng -b a $adapt
fi



#step 8 : ask if you would like to filter a certain device



#previous script for pulic and private ip scanner
#!/bin/bash
#
#n="$(ifconfig | grep 'inet' | awk '{print $2}' | sed -n p | tee >(wc -l) | tail -1)"
#list="$(ifconfig | grep 'flags' | awk '{print $2}' | sed -n p)"
#list="$(ifconfig | grep 'inet' | awk '{print $2}' | sed -n p)"
#
#echo "which adapter do you need the local IP address of?: [1-$n]"
#
#ifconfig | grep 'flags' | awk '{print $1}' | sed -n p | awk 'NR==1,NR==4{print NR" "$0}' | sed 's/://'
#
#read ADPTR
#
#PUB_IP="$(dig +short myip.opendns.com @resolver1.opendns.com)"
#LOC_IP="$(ifconfig | grep 'inet' | awk '{print $2}' | sed -n "$ADPTR"p)"
#
#echo -e "Your Public IP:\n $PUB_IP\n"
#echo -e "Your Local IP:\n $LOC_IP\n"
#
#exit 0

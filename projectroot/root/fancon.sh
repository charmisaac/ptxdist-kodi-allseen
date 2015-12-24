#!/bin/bash
#
### SourceForge.net Powered
### http://sourceforge.net/projects/fancon/
### This software is under GPL
#
#

cd /sys/class/hwmon/hwmon0/device
sudo chmod 777 *
echo 1 > pwm1_enable
echo 1 > pwm2_enable

if test $# -eq 0        #principal
then
     echo
     echo -----------------------------------------
     echo -e "-\t\tSysInfo\t\t\t-"
     echo -----------------------------------------
     cput=`cat temp2_input`
     syst=`cat temp1_input`
     echo -e "Temperature CPU:\t\t$[cput/1000].$[cput%1000/100] C"
     echo -e "Temperature System\t\t$[syst/1000].$[syst%1000/100] C"

     cpuf=`cat fan2_input`
     cas1f=`cat fan1_input`
     cas2f=`cat fan5_input`
     fron=`cat fan3_input`

     echo -e "CPU Fan:\t\t\t$cpuf rpm"
     echo -e "Case1 Fan:\t\t\t$cas1f rpm"
     echo -e "Case2 Fan:\t\t\t$cas2f rpm"
     echo -e "Frontal Fan:\t\t\t$fron rpm"
     echo

else
	if test $1 = max
	then
		echo max > ~/.pwm
		echo Maxim. Performance . . .
		sudo echo 255 > pwm1
		sudo echo 255 > pwm2
		sleep 4
		cpuf=`cat fan2_input`
		casef=`cat fan1_input`
		echo CPU fan: $cpuf
		echo Case fan: $casef

	elif test $1 = med
	then
		echo med > ~/.pwm
		echo Medium Performance . . .
		sudo echo 175 > pwm1
		sudo echo 150 > pwm2
		sleep 4
		cpuf=`cat fan2_input`
		casef=`cat fan1_input`
		echo CPU fan: $cpuf
		echo Case fan: $casef

	elif test $1 = min
	then
		echo $1 > ~/.pwm
		echo Min. Performance . . .
		sudo echo 100 > pwm1
		sudo echo 100 > pwm2
		sleep 4
		cpuf=`cat fan2_input`
		casef=`cat fan1_input`
		echo CPU fan: $cpuf
		echo Case fan: $casef

	elif test $1 = cust
	then
		if test $# -eq 3
		then
			sudo echo $2 > pwm$3
		fi

	elif test $1 = rend
	then
		cat ~/.pwm

	elif test $1 = help
	then
		echo
		echo -e "\tHelp"
		echo "'./pwm.sh' Show System Temperatures and Fan Speeds"
		echo "'./pwm.sh max' CONFIG. MAX RPM"
		echo "'./pwm.sh med' CONFIG. MED RPM"
		echo "'./pwm.sh min' CONFIG. MIN RPM"
		echo "'./pwm.sh cust #2 #3' ADJUST PWM #3 AT #2 VAL"
		echo "'./pwm.sh rend' SHOW CURRENT PERF."
		echo
	else
   		echo -e "Wrong option. Type: \t./pwm.sh help\t to obtain some help."
	fi
fi


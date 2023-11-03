#!/bin/sh

function powersave() {
	for file in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
	do
		echo "powersave" > $file
	done
}

function exit_handler() {
	# enable all cores
	for f in /sys/devices/system/cpu/cpu*/online
	do
		echo 1 > $f
	done
	exit 0
}

trap exit_handler EXIT TERM INT


INTERVAL="30s"
HIGH_WATERMARK=80
LOW_WATERMARK=30
SYSFS="/sys/devices/system/cpu"
ALL_CPUS=$(awk -F- '{print $2-$1+1}' "${SYSFS}/possible")
CURRENT_CPUS=$(awk -F- '{print $2-$1+1}' "${SYSFS}/online")
LOADAVG=$(awk '{print $1*100}' "/proc/loadavg")

#powersave

while :
do
	sleep "$INTERVAL"

	LOADAVG=$(awk '{print $1*100}' "/proc/loadavg")
	CURRENT_CPUS=$(awk -F- '{print $2-$1+1}' "${SYSFS}/online")
	LOADAVG_PER=$(awk -v L=$LOADAVG -v C=$CURRENT_CPUS 'BEGIN{print int(L/C)}')

	#echo "$LOADAVG $LOADAVG_PER $CURRENT_CPUS $ALL_CPUS"
	if [ "$LOADAVG_PER" -ge "$HIGH_WATERMARK" -a "$CURRENT_CPUS" -lt "$ALL_CPUS" ]; then
		# avg is high and some cpus are offline
		echo "cpu too high, enable cpu$CURRENT_CPUS"
		echo 1 > "${SYSFS}/cpu$CURRENT_CPUS/online"
	elif [ "$LOADAVG_PER" -lt "$LOW_WATERMARK" -a "$CURRENT_CPUS" -gt "1" ]; then
		# avg is low and 2 or more cpu are online

		echo "cpu low, disable cpu$(($CURRENT_CPUS-1))"
		echo 0 > "${SYSFS}/cpu$(($CURRENT_CPUS-1))/online"
	fi
done

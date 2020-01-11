#!/bin/bash

while true; do
	date +%A\ %H:%M > /tmp/CurTime.tmp
	findmnt -no used /tmp > /tmp/CurUsedTmp.tmp
	sleep 60s
done &
while true; do
	GPU_RPM=$(< /sys/module/nouveau/drivers/pci\:nouveau/0000\:01\:00.0/hwmon/hwmon2/fan1_input)
	GPU_T=$(< /sys/module/nouveau/drivers/pci\:nouveau/0000\:01\:00.0/hwmon/hwmon2/temp1_input)
	GPU_TEMP=$(expr "$GPU_T" / 1000)

	CPU_T=$(< /sys/devices/platform/coretemp.0/hwmon/hwmon0/temp2_input)
	CPU_TEMP=$(expr "$CPU_T" / 1000)
	CPU_RPM=$(< /sys/module/hwmon_vid/holders/it87/drivers/platform\:it87/it87.656/hwmon/hwmon1/fan1_input)

	LOCALTIME=$(< /tmp/CurTime.tmp)
	USEDTMP=$(< /tmp/CurUsedTmp.tmp)

	R1=$(< /sys/class/net/enp4s0/statistics/rx_bytes)    # Internet interface name may differ (enp4s0 in my case)
        T1=$(< /sys/class/net/enp4s0/statistics/tx_bytes)
        sleep 1s
        R2=$(< /sys/class/net/enp4s0/statistics/rx_bytes)
        T2=$(< /sys/class/net/enp4s0/statistics/tx_bytes)
        TBPS=$(expr "$T2" - "$T1")
        RBPS=$(expr "$R2" - "$R1")
        TKBPS=$(expr "$TBPS" / 1024)
        RKBPS=$(expr "$RBPS" / 1024)

	xsetroot -name "${TKBPS}/${RKBPS} kB | ${CPU_TEMP}°C $CPU_RPM | ${GPU_TEMP}°C $GPU_RPM | ${USEDTMP}/2.0G | $LOCALTIME"
	sleep 10s
done &

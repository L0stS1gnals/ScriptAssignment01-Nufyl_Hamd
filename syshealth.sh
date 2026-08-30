#!/usr/bin/env bash
#=======================================
#syshealth.sh - System Health and Log Analysis Toolkit
#Lab 1 - Data Collector
#Author: Nufyl Hamd
#Date: $(date +%Y-%m-%d)
#=======================================
#---Variables and quoting demonstration---
HOSTNAME=$(hostname)
CURRENT_DATE=$(date '+%Y-%m-%d %H:%M:%S')
echo "Hostname without quotes: $HOSTNAME"
echo "Hostname without quotes: \"$HOSTNAME\""
cat <<EOF
#COMMENT FOR GRADER:
#Difference:
#Double quoting variables preserves spaces/special charecters, which prevents accidental word splitting.
#In python/java variables expand safely.
#In bash, unquoted \$VAR splits on spaces/tabs/newlines.
#Always double quote unless you deliberately want splitting.
EOF
#---System metrics collection---
UPTIME=$(uptime -p)
DISK_USAGE=$(df -h / | tail -1)
MEMORY_USAGE=$(free -h | awk '/Mem:/ {print $3 "/" $2}')
PROCESS_COUNT=$(ps -e | wc -l)
#---Output Handling---
OUTPUT_FILE="${1:-}"
print_report(){
printf "=======================================\n"
printf "System Health Report - %s\n" "$CURRENT_DATE"
printf "Hostname          :%s\n" " $HOSTNAME"
printf "Uptime            :%s\n" " $UPTIME"
printf "Disk /            :%s\n" " $DISK_USAGE"
printf "Memory used       :%s\n" " $MEMORY_USAGE"
printf "Total processes   :%s\n" " $PROCESS_COUNT"
printf "=======================================\n"
}
if [ -n "$OUTPUT_FILE" ];then
    print_report > "$OUTPUT_FILE"
    echo "Report written to $OUTPUT_FILE"
else
    print_report
fi
exit 0
#!/bin/bash

echo "=== CPU STATS ==="
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk -F',' '{print $4}' | awk '{print 100 - $1"%"}')
echo "Total CPU Usage: $CPU_USAGE"
echo ""

echo "=== MEMORY STATS ==="
free -m | grep "Mem:" | awk '{printf "Total: %sMB | Used: %sMB (%.2f%%) | Free: %sMB\n", $2, $3, $3/$2*100, $4}'
echo ""

echo "=== DISK USAGE (Root /) ==="
df -h / | awk 'NR==2 {printf "Total: %s | Used: %s (%s) | Free: %s\n", $2, $3, $5, $4}'
echo ""

echo "=== TOP 5 PROCESSES BY CPU ==="
ps -eo pid,cmd,%cpu,%mem --sort=-%cpu | head -n 6
echo ""

echo "=== TOP 5 PROCESSES BY MEMORY ==="
ps -eo pid,cmd,%mem,%cpu --sort=-%mem | head -n 6
echo ""

echo "=== SYSTEM INFO ==="
OS_VERSION=$(grep "PRETTY_NAME" /etc/os-release | awk -F'"' '{print $2}')
UPTIME=$(uptime -p)
echo "OS Version: $OS_VERSION"
echo "Uptime: $UPTIME"
echo ""

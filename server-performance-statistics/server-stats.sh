#!/bin/bash

# server-stats.sh: Analyze basic server performance stats

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root to gather all stats."
  exit 1
fi

# Display header
echo "==================== SERVER STATS ===================="

# 1. Total CPU usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "Total CPU Usage: $cpu_usage%"

# 2. Total memory usage
mem_total=$(free -m | awk '/Mem:/ {print $2}')
mem_used=$(free -m | awk '/Mem:/ {print $3}')
mem_free=$(free -m | awk '/Mem:/ {print $4}')
mem_usage_percentage=$(awk "BEGIN {print ($mem_used/$mem_total)*100}")
echo "Total Memory Usage: $mem_used MB used / $mem_free MB free ($mem_usage_percentage%)"

# 3. Total disk usage
disk_total=$(df -h --total | grep total | awk '{print $2}')
disk_used=$(df -h --total | grep total | awk '{print $3}')
disk_free=$(df -h --total | grep total | awk '{print $4}')
disk_usage_percentage=$(df -h --total | grep total | awk '{print $5}')
echo "Total Disk Usage: $disk_used used / $disk_free free ($disk_usage_percentage)"

# 4. Top 5 processes by CPU usage
echo "Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# 5. Top 5 processes by memory usage
echo "Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

# Stretch Goals

# OS version
os_version=$(cat /etc/os-release | grep -w "PRETTY_NAME" | cut -d '=' -f2 | tr -d '"')
echo "OS Version: $os_version"

# Uptime
uptime_info=$(uptime -p | sed 's/^up //')
echo "Uptime: $uptime_info"

# Load average
load_avg=$(uptime | awk -F 'load average:' '{print $2}' | xargs)
echo "Load Average: $load_avg"

# Logged in users
logged_in_users=$(who | wc -l)
echo "Logged-in Users: $logged_in_users"

# Failed login attempts
failed_logins=$(grep "Failed password" /var/log/auth.log 2>/dev/null | wc -l)
echo "Failed Login Attempts: $failed_logins"

# Display footer
echo "======================================================="


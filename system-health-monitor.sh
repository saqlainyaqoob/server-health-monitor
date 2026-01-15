#!/bin/bash

LOG_FILE="/var/log/system-health-monitor.log"



# Set log file path dynamically
if [ -d "/var/log" ] && [ "$(id -u)" -eq 0 ]; then
    LOG_FILE="/var/log/system-health-monitor.log"
else
    mkdir -p logs
    LOG_FILE="logs/system-health-monitor.log"
fi


# Function to log alerts 
alert() {
    MESSAGE="$1"
    echo "ALERT: $MESSAGE" >> "$LOG_FILE"
}


# Ping target for network check
PING_TARGET="google.com"

# Enable test mode? (set to 1 to simulate alerts, 0 for real data)
TEST_MODE=0


# ---------------- CPU USAGE CHECK ----------------

# Capture CPU usage using `top`
# -b  : batch mode (non-interactive)
# -n1 : take only one snapshot
#   $2 = user CPU usage
#   $4 = system CPU usage
# Log CPU usage percentage to the log file
check_cpu() {
    CPU_USAGE=$(top -bn1 | awk '/Cpu\(s\)/ {printf "%.2f", 100 - $8}')
    echo "CPU Usage: $CPU_USAGE%" >> "$LOG_FILE"
}


# ---------------- MEMORY USAGE CHECK ----------------

# Calculate memory usage percentage using `free`
# $3 = used memory
# $2 = total memory
# printf "%.2f" formats the output to 2 decimal places
# Log memory usage percentage
check_memory() {
    MEMORY_USAGE=$(free -m | awk '/Mem:/ {printf "%.2f", $3/$2 * 100}')
    echo "Memory Usage: $MEMORY_USAGE%" >> "$LOG_FILE"
}


# ---------------- DISK USAGE CHECK ----------------

# Get root (/) disk usage percentage using `df`
# NR==2 selects the second line (actual filesystem data)
# sed removes the '%' symbol
# Log disk usage percentage
# Check if disk usage exceeds 80%
# If true, log a warning message
check_disk() {
    DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
    echo "Disk Usage: $DISK_USAGE%" >> "$LOG_FILE"

    if [ "$DISK_USAGE" -gt 80 ]; then
        echo "WARNING: Disk usage above 80%" >> "$LOG_FILE"
        alert "Disk usage critical: ${DISK_USAGE}%"
    fi
}


# ---------------- SYSTEM UPTIME ----------------

# Get system uptime in a human-readable format
# Log system uptime
check_uptime() {
    UPTIME=$(uptime -p)
    echo "Uptime: $UPTIME" >> "$LOG_FILE"
}


# ---------------- SSH SERVICE STATUS ----------------

# Check whether SSH service is active using systemctl

SSH_SERVICE="ssh"

check_ssh() {
    if systemctl is-active --quiet "$SSH_SERVICE"; then
        echo "SSH Service: RUNNING" >> "$LOG_FILE"
    else
        echo "SSH Service: NOT RUNNING" >> "$LOG_FILE"
    fi
}


# ---------------- NETWORK CONNECTIVITY CHECK ----------------

# Ping google.com once to test internet connectivity
# &> /dev/null suppresses output
# $? stores the exit status of the previous command
# 0 = success (connected)
# non-zero = failure (disconnected)

PING_TARGET="8.8.8.8"

check_network() {
    #ping -c 1 google.com &> /dev/null
    ping -c 1 "$PING_TARGET" &> /dev/null


    if [ $? -eq 0 ]; then
        echo "Network: CONNECTED" >> "$LOG_FILE"
    else
        echo "Network: DISCONNECTED" >> "$LOG_FILE"
    fi
}


# ---------------- LOG SEPARATOR ----------------
# Add a separator line to clearly distinguish each health check entry
# Add an empty line for better readability

main() {
    DATE=$(date "+%Y-%m-%d %H:%M:%S")


    echo "===== Health Check: $DATE =====" >> "$LOG_FILE"

    check_cpu
    check_memory
    check_disk
    check_uptime
    check_ssh
    check_network

    echo "==================================" >> "$LOG_FILE"
    echo "" >> "$LOG_FILE"
}

main






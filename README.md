Server Health Monitor (DevOps Project)

A lightweight Linux Server Health Monitoring script written in Bash, designed from a DevOps perspective.

It periodically checks system health metrics and logs them automatically using cron.

This project demonstrates real-world DevOps fundamentals: monitoring, automation, logging, and clean scripting.

📌 Features

The script monitors and logs:

CPU Usage

Memory Usage

Disk Usage

System Uptime

SSH Service Status

Network Connectivity

Timestamped Logs

All results are stored in a centralized log file for auditing and troubleshooting.

Project Structure

server-health-monitor/
├── health-monitor.sh        # main script
├── README.md                # professional README
├── .gitignore               # ignore logs and temp files
└── logs/                    # optional folder for local logs if not using /var/log

Prerequisites

Linux (Ubuntu recommended)

Bash shell

Root / sudo privileges

cron service enabled

Installation & Setup

Clone the repository

git clone https://github.com/your-username/server-health-monitor.git

cd server-health-monitor

Make the script executable

chmod +x health-monitor.sh

Run manually (test)

sudo ./health-monitor.sh

📝 Log File Location

All health checks are logged to:

/var/log/system-health-monitor.log

View logs:

sudo tail -f /var/log/system-health-monitor.log

Cron Automation (Recommended)

Run the health check every 5 minutes automatically.

Edit crontab:

sudo crontab -e

Add this line:

\*/5 \* \* \* \* /absolute-path-here/system-health-monitor.sh

How It Works (High-Level)

Uses standard Linux tools (top, free, df, uptime, systemctl, ping)

Each check is written as a separate function

A main function orchestrates execution

Logs are timestamped for traceability

Cron enables hands-off automation

Customization

You easily modify:

Ping target (e.g., Google → internal server)

Disk usage threshold

Log file location

Check frequency (cron)

DevOps Skills Demonstrated

Bash scripting

Linux system monitoring

Cron automation

Log management

Production-style structure

Server reliability mindset

DevOps Learner

Linux | Bash | Monitoring | Automation

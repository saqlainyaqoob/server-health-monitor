# Server Health Monitor

A production-inspired Linux server monitoring tool built with Bash — automated, reliable, and DevOps-ready.

Server Health Monitor is a lightweight Bash script that continuously observes critical system metrics and records them in a centralized log file. Designed with a real-world DevOps mindset, it focuses on automation, observability, and operational clarity.

**No dashboards. No agents. Just clean Linux fundamentals done right.**

---

## Why This Project Exists

Modern systems fail silently unless they are observed. This project simulates how DevOps engineers:

- Track server health  
- Automate routine checks  
- Create audit-ready logs  
- Reduce manual intervention using cron  

It’s intentionally simple, transparent, and production-aligned.

---

## What Gets Monitored

Every execution captures a snapshot of the system’s health:

- CPU utilization — detect load spikes  
- Memory usage — identify pressure early  
- Disk consumption — avoid "disk full" incidents  
- System uptime — track stability  
- SSH service status — ensure remote access availability  
- Network reachability — confirm outbound connectivity  
- Timestamps — full traceability for every run  

All results are appended to a single log for easy auditing and debugging.

---

## 🗂️ Repository Layout

```
server-health-monitor/
├── health-monitor.sh   # Core monitoring logic
├── README.md           # Documentation
├── .gitignore          # Ignore logs & temporary files
└── logs/               # Optional local logs directory
```

Structured to reflect real production repositories — simple and intentional.

---

## Design Philosophy

- Uses native Linux utilities: `top`, `free`, `df`, `uptime`, `systemctl`, `ping`  
- Each check is isolated into a function  
- A single main function controls execution flow  
- Clear output → predictable logs → easier debugging  
- Zero external dependencies  

---

---

## Requirements

- Linux environment (Ubuntu preferred)  
- Bash shell  
- cron enabled  
- Root / sudo privileges  

---

## Getting Started

### 1. Clone the repository
```bash
git clone https://github.com/saqlainyaqoob/server-health-monitor.git
cd server-health-monitor
```

### 2. Make the script executable
```bash
chmod +x health-monitor.sh
```

### 3. Run a test execution
```bash
sudo ./health-monitor.sh
```

---

## Logging & Observability

All system checks are written to:

```
/var/log/system-health-monitor.log
```

Monitor logs live:
```bash
sudo tail -f /var/log/system-health-monitor.log
```

Logs are timestamped and append-only, making them suitable for audits and troubleshooting.

---

## Fully Automated with Cron

Automate health checks every 5 minutes — hands-free.

Edit root crontab:
```bash
sudo crontab -e
```

Schedule execution:
```
*/5 * * * * /absolute-path-here/system-health-monitor.sh
```

Once scheduled, the server monitors itself.


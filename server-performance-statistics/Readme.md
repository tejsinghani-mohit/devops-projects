# Server Stats Script

## Overview
The `server-stats.sh` script is a simple tool to analyze basic server performance statistics on a Linux system. It provides information about CPU usage, memory usage, disk usage, and the top resource-consuming processes. Additionally, it includes optional metrics like OS version, uptime, load average, logged-in users, and failed login attempts.

This project is a part of [roadmap.sh](https://roadmap.sh/projects/server-stats).

## Features
1. **CPU Usage**: Displays the total CPU usage percentage.
2. **Memory Usage**: Shows free and used memory (in MB) and its percentage.
3. **Disk Usage**: Provides total, used, and free disk space along with usage percentage.
4. **Top Processes**:
   - Top 5 processes by CPU usage.
   - Top 5 processes by memory usage.
5. **Stretch Goals**:
   - OS version.
   - System uptime.
   - Load average.
   - Number of logged-in users.
   - Count of failed login attempts.

## Prerequisites
- The script must be executed with root privileges to gather all stats.
- Linux system with the following commands available:
  - `top`
  - `free`
  - `df`
  - `ps`
  - `uptime`
  - `who`
  - `grep`

## Installation
1. Save the script to a file named `server-stats.sh`.
2. Make the script executable:
   ```bash
   chmod +x server-stats.sh
   ```

## Usage
Run the script using the following command:
```bash
sudo ./server-stats.sh
```

## Example Output
```
==================== SERVER STATS ====================
Total CPU Usage: 5.3%
Total Memory Usage: 2048 MB used / 1024 MB free (66.67%)
Total Disk Usage: 10G used / 40G free (20%)

Top 5 Processes by CPU Usage:
  PID COMMAND         %CPU
  1234 process1       50.0
  5678 process2       25.0
  ...

Top 5 Processes by Memory Usage:
  PID COMMAND         %MEM
  4321 process3       30.0
  8765 process4       20.0
  ...

OS Version: Ubuntu 20.04.6 LTS
Uptime: 2 hours, 30 minutes
Load Average: 0.15, 0.10, 0.05
Logged-in Users: 2
Failed Login Attempts: 5
=======================================================
```

## Notes
- The script is designed to run on most Linux distributions.
- Some commands may need to be adjusted for distributions where logs or utilities are located differently (e.g., failed login attempts may not be found in `/var/log/auth.log` on non-Debian-based systems).


This project is a part of [roadmap.sh](https://roadmap.sh/projects/server-stats) DevOps projects.


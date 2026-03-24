# Nginx-Log-Analyser

## Overview

A lightweight, zero-dependency Bash script to analyze Nginx access logs and quickly surface the top request patterns.

Project Source: [https://roadmap.sh/projects/nginx-log-analyser](https://roadmap.sh/projects/nginx-log-analyser)

## Features

- Top 5 IP addresses by request count
- Top 5 requested URIs/paths
- Top 5 HTTP response status codes
- Top 5 User-Agent values


## Prerequisites

- macOS or Linux (POSIX-compatible shell)
- `awk`, `sort`, `uniq`, `head` available (usually installed by default)
- An Nginx access log in combined or compatible format

## Installation

1. Clone the repository (or copy the script file):
   ```bash
   git clone https://github.com/tejsinghani-mohit/devops-projects.git
   cd devops-projects/nginx-log-analyser
   ```
2. Make the script executable:
   ```bash
   chmod +x nginx-log-analyser.sh
   ```

## Usage

```bash
./nginx-log-analyser.sh [path/to/access.log]
```

- Default log file: `nginx-access.log` (if no argument provided)
- Example:
  ```bash
  ./nginx-log-analyser.sh /var/log/nginx/access.log
  ```

## Output

The script prints 4 sections with header lines and the top 5 rows, each sorted by frequency:

1. IP address (field `$1`)
2. Request path (field `$7`)
3. HTTP status code (field `$9`)
4. User-Agent (field `$12`)

### Example

```text
Top 5 IP addresses with most requests:
10.0.0.1 - 1132 requests
...

Top 5 most requested paths:
/ - 589 requests
...

Top 5 response status codes:
200 - 3335 occurrences
...

Top 5 user agents:
"Mozilla/5.0 ..." - 1153 occurrences
...
```

## Customization

If your log format uses different field positions, update the field index passed to `awk` lines in `nginx-log-analyser.sh`:

- IP: `$1`
- Path: `$7`
- Status: `$9`
- User-Agent: `$12`

Example (change path from `$7` to `$8`):

```bash
awk '{ paths[$8]++ } END { ... }' "$logfile"
```

## Troubleshooting

- If the file cannot be found:
  - Verify path and permissions.
  - Confirm log freshness and rotation state.
- If output is empty:
  - Ensure the log uses a space-separated format and includes expected fields.

## Tests

No automated tests are included. Quick manual validation:

```bash
printf '%s\n' '127.0.0.1 - - [01/Jan/2025:00:00:00 +0000] "GET / HTTP/1.1" 200 123 "-" "curl/7.68.0"' > test.log
./nginx-log-analyser.sh test.log
```




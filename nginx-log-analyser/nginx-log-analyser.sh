#!/usr/bin/env bash

# nginx-log-analyser.sh
# Usage: ./nginx-log-analyser.sh [logfile]
# Default logfile: nginx-access.log

LOGFILE="${1:-nginx-access.log}"

if [ ! -f "$LOGFILE" ]; then
  echo "ERROR: Log file not found: $LOGFILE" >&2
  exit 1
fi

echo "Top 5 IP addresses with most requests:"
awk '{ ips[$1]++ } END { for (ip in ips) printf "%s - %d requests\n", ip, ips[ip] }' "$LOGFILE" | sort -t ' ' -k3 -rn | head -n 5

echo ""

echo "Top 5 most requested paths:"
awk '{ paths[$7]++ } END { for (p in paths) printf "%s - %d requests\n", p, paths[p] }' "$LOGFILE" | sort -t ' ' -k3 -rn | head -n 5

echo ""

echo "Top 5 response status codes:"
awk '{ if ($9 ~ /^[0-9]+$/) status[$9]++ } END { for (s in status) printf "%s - %d occurrences\n", s, status[s] }' "$LOGFILE" | sort -t ' ' -k3 -rn | head -n 5

echo ""

echo "Top 5 user agents:"
awk '{ agents[$12]++ } END { for (a in agents) printf "%s - %d occurrences\n", a, agents[a] }' "$LOGFILE" | sort -t ' ' -k3 -rn | head -n 5

echo ""



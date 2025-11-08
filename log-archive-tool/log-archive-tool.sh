#!/usr/bin/env bash
# log-archive-tool.sh
# Usage: ./log-archive-tool.sh /path/to/logdir
set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 /path/to/log-directory"
    exit 2
fi

INPUT_DIR="$1"

# Resolve to absolute path
if ! INPUT_DIR_ABS=$(cd "$INPUT_DIR" 2>/dev/null && pwd); then
    echo "Error: directory not found: $INPUT_DIR" >&2
    exit 3
fi

# Create a new directory to store archives (sibling "archives" directory)
ARCHIVE_PARENT="$(dirname "$INPUT_DIR_ABS")"
ARCHIVE_DIR="$ARCHIVE_PARENT/archives"
mkdir -p "$ARCHIVE_DIR"

TIMESTAMP="$(date '+%Y%m%dT%H%M%S')"
BASE_NAME="$(basename "$INPUT_DIR_ABS")"
ARCHIVE_NAME="${BASE_NAME}-${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="$ARCHIVE_DIR/$ARCHIVE_NAME"

# Create tar.gz of the log directory contents
tar -czf "$ARCHIVE_PATH" -C "$INPUT_DIR_ABS" .

# Record the archive action to a log file
LOG_FILE="$ARCHIVE_DIR/archive.log"
ARCHIVE_TIME="$(date '+%Y-%m-%dT%H:%M:%S%z')"
ARCHIVE_SIZE="$(du -h "$ARCHIVE_PATH" | cut -f1)"
echo "$ARCHIVE_TIME - archived $INPUT_DIR_ABS -> $ARCHIVE_PATH ($ARCHIVE_SIZE)" >> "$LOG_FILE"

echo "Archived: $ARCHIVE_PATH"
echo "Recorded archive entry in: $LOG_FILE"
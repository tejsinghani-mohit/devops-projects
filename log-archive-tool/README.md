# log-archive-tool

A small shell utility to archive a log directory into a timestamped tar.gz file and record the action.

This repository contains `log-archive-tool.sh` which compresses the contents of a given directory into a `tar.gz` file and places it in a sibling `archives` directory. It also appends an entry to an `archive.log` file recording the archive action.

Project Source: https://roadmap.sh/projects/log-archive-tool

## Features

- Creates a timestamped archive named `<dirname>-YYYYmmddTHHMMSS.tar.gz` in a sibling `archives` directory.
- Records each archive event in `archives/archive.log` with timestamp, source path, archive path, and size.
- Safe handling of non-existing directories with clear exit codes.

## Requirements

- macOS or Linux
- Bash (script uses POSIX-ish features; tested with bash)
- `tar`, `du`, and standard coreutils available

## Installation

No installation is necessary. Make the script executable if needed:

```bash
chmod +x log-archive-tool.sh
```

## Usage

```bash
./log-archive-tool.sh /path/to/log-directory
```

Where `/path/to/log-directory` is the directory whose contents you want archived.

### What the script does

1. Validates a single argument is provided. If not, exits with code `2` and prints usage.
2. Resolves the provided path to an absolute path. If the directory doesn't exist, exits with code `3` and prints an error.
3. Creates (if missing) an `archives` directory beside the provided directory (i.e. a sibling of the directory's parent).
4. Creates a compressed tarball named `<basename>-<TIMESTAMP>.tar.gz` (timestamp format: `YYYYmmddTHHMMSS`) and stores it in the `archives` directory.
5. Appends a line to `archives/archive.log` with the archive timestamp, source path, destination path, and the archive size.
6. Prints the archive path and the log file path to stdout.

## Exit codes

- `0` - Success
- `2` - Incorrect usage (wrong number of arguments)
- `3` - Provided directory does not exist or cannot be resolved

## Examples

Archive a directory called `myapp-logs`:

```bash
./log-archive-tool.sh /var/log/myapp-logs
# Output:
# Archived: /var/log/archives/myapp-logs-20251108T153045.tar.gz
# Recorded archive entry in: /var/log/archives/archive.log
```

You can use this from cron to rotate/backup logs periodically. Example crontab entry (runs nightly at 02:00):

```cron
0 2 * * * /full/path/to/log-archive-tool.sh /var/log/myapp-logs >> /var/log/log-archive-cron.log 2>&1
```

## Notes and safety

- The script archives the contents of the directory (tar -C <dir> .). It preserves permissions determined by `tar` and the executing user. Run with appropriate permissions if you need to archive system-owned logs.
- The `archives` directory is created as a sibling of the provided directory's parent. For example, given `/path/to/logs`, archives will be written to `/path/to/archives`.
- Ensure sufficient disk space in the archive target location before running on very large log trees.

## Troubleshooting

- "directory not found" message: check the path you passed and ensure it exists and is accessible by the script's user.
- Permission errors when writing archives: run the script as a user with write permissions to the parent directory or run via sudo if appropriate.

## License

This repository is provided as-is. Add a LICENSE file if you need a specific license.

#!/bin/bash

SRC="$HOME/data"
DEST="$HOME/backup"
LOG="$HOME/backup.log"
DATE=$(date +%Y-%m-%d)

mkdir -p "$DEST"

if [ ! -d "$SRC" ]; then
    echo "$(date): ERROR - Source directory $SRC does not exist" >> "$LOG"
    exit 1
fi

if tar -czf "$DEST/data_backup_$DATE.tar.gz" "$SRC" 2>>"$LOG"; then
    echo "$(date): Backup successful" >> "$LOG"
else
    echo "$(date): ERROR - Backup failed" >> "$LOG"
    exit 2
fi

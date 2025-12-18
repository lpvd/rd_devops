#!/bin/bash

URL="https://www.google.com"

LOG_DIR="$HOME/log"
mkdir -p "$LOG_DIR"
LOG="$LOG_DIR/check_site.log"

if curl -s -L -o /dev/null -w "%{http_code}" "$URL" | grep -q "^2"; then
    echo "$(date): SITE OK" >> "$LOG"
else
    echo "$(date): SITE DOWN" >> "$LOG"
fi

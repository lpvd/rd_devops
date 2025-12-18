#!/bin/bash

OUT="$HOME/log/system_monitor.log"

echo "===== $(date) =====" >> "$OUT"
echo "CPU:" >> "$OUT"
top -bn1 | grep "Cpu" >> "$OUT"

echo "Memory:" >> "$OUT"
free -h >> "$OUT"

echo "Disk:" >> "$OUT"
df -h >> "$OUT"
echo "" >> "$OUT"

#!/bin/sh
echo "Start cloud sync script"

rclone sync /sync remote:sync

echo "Completed"
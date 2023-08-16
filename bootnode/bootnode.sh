#!/bin/bash

logfile="/debug/debug.log" # Name of the log file

# Start the bootnode command and append its output to the log file
bootnode -nodekey /app/boot.key -verbosity 9 -addr :30310 >> $logfile 2>&1 &

# Print the content of the log file to the console
tail -f $logfile
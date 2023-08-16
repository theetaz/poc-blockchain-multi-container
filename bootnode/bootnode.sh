#!/bin/bash

logfile="/debug/debug.log" # Name of the log file
bootnode -nodekey /app/boot.key -verbosity 9 -addr :30310 >> $logfile

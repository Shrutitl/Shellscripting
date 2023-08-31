#!/bin/bash

THRESHOLD_CPU=80  # Threshold for CPU usage (%)
THRESHOLD_MEM=90  # Threshold for memory usage (%)
ALERT_EMAIL="admin@example.com"

# Get current CPU and memory usage
#when you run top -bn1, you're instructing the top command to run in batch mode for a single iteration, 
#print the resource usage information, and then exit immediately.


CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')

# /Mem:/: This is a pattern to match lines containing the string "Mem:". 
#In the context of the free command's output, lines containing "Mem:" provide information about memory usage.
#{print $3/$2 * 100}: This is the action that awk performs when it matches the pattern. 
#It calculates the percentage of used memory by dividing the value in the third column (used memory) by the value in the second column 
#(total memory)
#and then multiplying the result by 100 to get the percentage.


MEM_USAGE=$(free | awk '/Mem:/ {print $3/$2 * 100}')

# Check if thresholds are exceeded and send alert
if (( $(echo "$CPU_USAGE > $THRESHOLD_CPU" | bc -l) )); then
    echo "CPU usage is high ($CPU_USAGE%) - please investigate." | mailx -s "High CPU Alert" "$ALERT_EMAIL"
fi

#The bc command without the -l flag performs basic arithmetic calculations, 
#but with the -l flag, it includes support for functions like square root, exponential, and trigonometric functions

if (( $(echo "$MEM_USAGE > $THRESHOLD_MEM" | bc -l) )); then
    echo "Memory usage is high ($MEM_USAGE%) - please investigate." | mailx -s "High Memory Alert" "$ALERT_EMAIL"
fi

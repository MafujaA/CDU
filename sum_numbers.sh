#!/usr/bin/env bash
# TASK-02: While loop program to sum 7 integers in range 9-90

set -euo pipefail

count=0
sum=0

echo "Enter 7 integers between 9 and 90 (inclusive)."
echo "Any input > 100 will terminate the program."

while [ $count -lt 7 ]; do
    read -p "Enter number $((count+1)): " num

    # Check if number is greater than 100
    if [ "$num" -gt 100 ]; then
        echo "Number greater than 100 entered. Program terminated."
        exit 1
    fi

    # Check if number is within 9-90
    if [ "$num" -ge 9 ] && [ "$num" -le 90 ]; then
        sum=$((sum + num))
        count=$((count + 1))
    else
        echo "Error: $num is not in the range 9-90 (inclusive). Please try again."
    fi
done

echo "---------------------------------"
echo "Sum of the 7 valid numbers: $sum"

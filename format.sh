#!/bin/bash
script_name=$0
parametr1=$1
echo "========================================="
echo "You run script with name $script_name and parameter $parametr1"
echo "-----------------------------------------"
echo "Machine name: "$HOSTNAME
echo "Parent process ID: "$PPID
echo "Program search path: "$PATH
echo "-----------------------------------------"
cat < out.txt
grep -E '\b50[0-9]\b' file.txt | cut -d ' ' -f 3,4 | while read line; do RESULT1=$(echo "$line" | cut -d ' ' -f 1); RESULT2=$(grep -ch "$line" file.txt) ; RESULT="${RESULT1} ${RESULT2}`echo`" ; echo "$RESULT">>out.txt ; done
cat out.txt |sort -ru
echo "========================================="
exit 0
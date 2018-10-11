#!/bin/bash
# Program Name: cdown.sh
# Created by: Norman Chen
# Create date: 12/12/2017
# Description: This is a countdown clock which will prompt user for Hours minutes and seconds.
# Limitation: Currently does not do user input data checking.  Input assumes user will follow prompts of entering interger values to start countdown.  
# Version: 1.1 
#
# Revision History:
# v1.1: Added audible sound time is up.
# v1.0: Orginal

# Prompt user for Hour Minute and second settings
read -p 'Hours: ' hMax
read -p 'Minutes: ' mMax
read -p 'Seconds: ' sMax

# Calculate time in seconds
let sMax=hMax*3600+mMax*60+sMax

# Set start point of s in terms of seconds
let s=$sMax

# Run countdown
while [ $s -ne 0 ]
do

# Calculate display values for Hours Minutes and Seconds 
  let seconds=s%60
  let minutes=(s-seconds)/60%60
  let hours=(s-s%3600)/3600

# Sleep for 1 second before displaying timer output
  sleep 1

# Display Message in center of screen using tput
  message="Hours:$hours Minutes:$minutes Seconds:$seconds"
  cols=$( tput cols )
  rows=$( tput lines )
  input_length=${#message} 
  half_input_length=$(( $input_length / 2 ))
  middle_row=$(( $rows / 2 ))
  middle_col=$(( ($cols / 2) - $half_input_length ))
  tput clear
  tput cup $middle_row $middle_col
  tput bold
  echo $message
  let s=s-1 
done

# Display "Time is up" in center of page
tput clear
tput cup $middle_row $middle_col
echo "Time is up"

# Sound off alarm Time is up.
let bdex=3
while [ $bdex -gt 0 ] 
do
   beep -f 750 -l 400 -n -f 200 -l 200  
   let bdex=bdex-1 
done

# Clear tput settings and reset cursor to lower left hand of screen.
tput sgr0
tput cup $( tput lines ) 0


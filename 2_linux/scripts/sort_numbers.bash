#!/bin/bash

read -p "Enter a number between 1-100: " number
echo $number

if [ $number -lt 30 ]
   then
      echo "Entered number is between 0-30"
 elif [ $number -ge 30 ] && [ $number -le 60 ]
   then
      echo "Entered number is between 30-59"
 elif [ $number -ge 60 ] && [ $number -le 100 ]
   then
      echo "Entered number is between 60-100"
 else
      echo "Entered number is not on a range between 1-100" 
fi

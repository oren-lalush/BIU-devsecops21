#!/bin/bash

Name=$1
Age=$2
City=$3

echo "Name: " $1 | tee profile.txt
echo "Age: " $2 | tee -a profile.txt
echo "City: " $3 | tee -a profile.txt
echo "Number of parameters: " $#

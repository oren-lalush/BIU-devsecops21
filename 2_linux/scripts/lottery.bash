#!/bin/bash
num1=$RANDOM
num2=$RANDOM
num3=$RANDOM

#username=$USER
username=`whoami`
echo "Lucky numbers for $username: $num1 $num2 $num3" | tee -a lottery.log

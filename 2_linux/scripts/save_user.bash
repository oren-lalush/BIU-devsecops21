#!/bin/bash

safe_name=$(echo "$full_name" | tr ' ' '_')
output_file="user_${safe_name}.txt"

echo "========== USER BADGE ==========" | tee "$output_file"
echo "Name: $full_name" | tee -a "$output_file"
echo "Email: $user_email" | tee -a "$output_file"
echo "User ID: $user_id" | tee -a "$output_file"
echo "Registered: $registration_time" | tee -a "$output_file"
echo "Terminal: $machine" | tee -a "$output_file"
echo "===============================" | tee -a "$output_file"

echo "User badge saved to: $output_file"

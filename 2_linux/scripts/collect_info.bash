#!/bin/bash

echo "Please enter the following details:"
echo -n "Full name: "
read full_name

echo -n "Email: "
read user_email

echo -n "User ID: "
read user_id

registration_time=$(date)
machine=$(hostname)

# Export so they remain available for the current session
export full_name user_email user_id registration_time machine

echo "You can now run ./save_user.sh to display your user badge."


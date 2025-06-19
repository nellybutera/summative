#!/bin/bash

cd "$(dirname "$0")"

source ./config/config.env
source ./modules/functions.sh

submission_data="./assets/submissions.txt"

echo "Assignment: $ASSIGNMENT"
echo "Remaining days: $DAYS_REMAINING"
echo "-------------------------------"

check_submissions "$submission_data"

#!/bin/bash

# Checks for students with pending submissions
function check_submissions {
    local file=$1
    echo "Checking file: $file"

    while IFS=, read -r student task status; do
        student=$(echo "$student" | xargs)
        task=$(echo "$task" | xargs)
        status=$(echo "$status" | xargs)

        if [[ "$task" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "$student has not submitted the $ASSIGNMENT task."
        fi
    done < <(tail -n +2 "$file")
}

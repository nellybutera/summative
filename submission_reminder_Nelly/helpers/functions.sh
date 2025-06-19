#!/bin/bash

# Check who hasn't submitted based on assignment
function check_submissions {
    local input_file=$1
    echo "Processing file: $input_file"

    while IFS=, read -r student task status; do
        student=$(echo "$student" | xargs)
        task=$(echo "$task" | xargs)
        status=$(echo "$status" | xargs)

        if [[ "$task" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "$student has not submitted the $ASSIGNMENT task."
        fi
    done < <(tail -n +2 "$input_file")
}

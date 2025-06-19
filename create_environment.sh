#!/bin/bash

# Ask for the student's name to personalize the folder
echo "Please enter your name:"
read student_name

# Define project folder
project_root="submission_reminder_${student_name}"

# Create necessary directories
mkdir -p "$project_root"/{app_code,helpers,data_store,configuration}

# Create config.env file
cat << EOF > "$project_root/configuration/config.env"
# Configuration settings
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# Create functions.sh script
cat << 'EOF' > "$project_root/helpers/functions.sh"
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
EOF

# Create reminder.sh script
cat << 'EOF' > "$project_root/app_code/reminder.sh"
#!/bin/bash

# Load config and functions
source ../configuration/config.env
source ../helpers/functions.sh

# File location
submissions_file="../data_store/submissions.txt"

echo "Current Assignment: $ASSIGNMENT"
echo "Remaining Days: $DAYS_REMAINING"
echo "--------------------------------"

check_submissions "$submissions_file"
EOF

# Create startup.sh script
cat << 'EOF' > "$project_root/startup.sh"
#!/bin/bash

cd "$(dirname "$0")"

# Load configuration and helper script
source ./configuration/config.env
source ./helpers/functions.sh

submissions_file="./data_store/submissions.txt"

echo "Assignment in focus: $ASSIGNMENT"
echo "Time left: $DAYS_REMAINING days"
echo "--------------------------------"

check_submissions "$submissions_file"
EOF

# Create a sample submissions.txt
cat << EOF > "$project_root/data_store/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Grace, Shell Navigation, not submitted
Lina, Shell Navigation, submitted
Ali, Shell Navigation, not submitted
Fahad, Shell Navigation, not submitted
Brian, Git, not submitted
Yasmin, Shell Navigation, submitted
EOF

# Set executable permissions
find "$project_root" -name "*.sh" -exec chmod +x {} \;

echo "Environment successfully created in: $project_root"

#!/bin/bash

# Ask for your name
echo "Please type your name:"
read user_name

# Define root folder
project_folder="submission_reminder_${user_name}"

# Create directory structure
mkdir -p "$project_folder"/{app,modules,assets,config}

# Generate config.env
cat << EOF > "$project_folder/config/config.env"
# Assignment settings
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# Generate functions.sh
cat << 'EOF' > "$project_folder/modules/functions.sh"
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
EOF

# Generate reminder.sh
cat << 'EOF' > "$project_folder/app/reminder.sh"
#!/bin/bash

# Load settings and helper functions
source ../config/config.env
source ../modules/functions.sh

submissions_file="../assets/submissions.txt"

echo "Assignment: $ASSIGNMENT"
echo "Days left: $DAYS_REMAINING"
echo "-------------------------"

check_submissions "$submissions_file"
EOF

# Generate startup.sh
cat << 'EOF' > "$project_folder/startup.sh"
#!/bin/bash

cd "$(dirname "$0")"

source ./config/config.env
source ./modules/functions.sh

submission_data="./assets/submissions.txt"

echo "Assignment: $ASSIGNMENT"
echo "Remaining days: $DAYS_REMAINING"
echo "-------------------------------"

check_submissions "$submission_data"
EOF

# Generate submissions.txt
cat << EOF > "$project_folder/assets/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Grace, Shell Navigation, not submitted
Ali, Shell Navigation, not submitted
Fahad, Shell Navigation, not submitted
Brian, Git, not submitted
Yasmin, Shell Navigation, submitted
Noor, Shell Navigation, not submitted
EOF

# Make all shell scripts executable
find "$project_folder" -name "*.sh" -exec chmod +x {} \;

echo "Setup complete. Project folder created: $project_folder"

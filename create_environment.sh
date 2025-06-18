#!/bin/bash

# Prompt for user name
echo "Enter your name:"
read username

# Main app directory
main_dir="submission_reminder_${username}"

# Create directory structure
mkdir -p "$main_dir"/{app,modules,assets,config}

# --- Create config.env ---
cat << EOF > "$main_dir/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# --- Create functions.sh ---
cat << 'EOF' > "$main_dir/modules/functions.sh"
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF

# --- Create reminder.sh ---
cat << 'EOF' > "$main_dir/app/reminder.sh"
#!/bin/bash

# Source environment variables and helper functions
source ../config/config.env
source ../modules/functions.sh

# Path to the submissions file
submissions_file="../assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions "$submissions_file"
EOF

# --- Create startup.sh ---
cat << 'EOF' > "$main_dir/startup.sh"
#!/bin/bash

# Navigate to script location
cd "$(dirname "$0")"

# Source config and functions
source ./config/config.env
source ./modules/functions.sh

# Define the path to submissions
submissions_file="./assets/submissions.txt"

# Display info
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions "$submissions_file"
EOF

# --- Create submissions.txt with 10 entries ---
cat << EOF > "$main_dir/assets/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Grace, Shell Navigation, not submitted
Lina, Shell Navigation, submitted
Ali, Shell Navigation, not submitted
Fahad, Shell Navigation, not submitted
Khalid, Git, not submitted
Zara, Shell Navigation, submitted
EOF

# --- Make all .sh files executable ---
find "$main_dir" -name "*.sh" -exec chmod +x {} \;

echo "✅ Environment created at: $main_dir"

# Submission Reminder App

This is a shell script project that reminds students about upcoming or missed assignment submissions.

## Project Structure

The script sets up a folder called `submission_reminder_<yourName>` with the following folders:

- `app/`: where the main reminder script is
- `modules/`: has the functions script
- `assets/`: contains the list of submissions
- `config/`: has the config file

## Scripts Overview

### 1. create_environment.sh

This script sets up the whole project environment.

- It asks for your name
- It creates all the folders and files automatically
- It adds default students and submissions
- Makes all `.sh` files executable

To run it:
./create_environment.sh

### 2. startup.sh
Runs the reminder app and checks which students haven’t submitted the assignment yet (based on what’s set in config.env).

### 3. copilot_shell_script.sh
- This one allows you to change the assignment name in config.env.
- It asks for the name you used when creating the environment
- Then asks for a new assignment name
- Updates the config file
- Runs the app again with the new assignment

To run it:
./copilot_shell_script.sh

#### Sample Submission Data
Comes with 10 students, some who submitted and some who didn’t.

##### Final Notes
After setup, make sure you're in the correct directory before running the scripts.
# Using Linux to manage accounts for users
The purpose of this script is to automate the process of adding and removing a user from the system.
With the script, we can;
1. Create a user and add the user to the home directory.
2. Automatically generate a password for the user account.
3. Add the login credentials to a new file and send it to the user through email address.
4. Delete the login credentials from the system for security reasons.
5. Delete a user from the system

## How it works
The user starts the process by running `bash script.sh`
Before running the script, you wil have to provide three variables
1. add/remove
2. username
3. email address

using add/remove tells the bash script to either add or remove a user from the system.
The username provided will be what the script will use to set up an account and also add it to the home directory.
The email address provided will be used to send the login details to the owner of the account.

#!/bin/bash

USERNAME="$2"
EMAIL="$3"
PASSWORD="$4"

addUser() {
	#Add account with name passed in as first parameter. The "m" is to create a new home directory for the user so we can put a file in it
	sudo useradd -m $USERNAME

	#checking the length of password, and if password isnt set, it automatically creates one
	if [ -z $PASSWORD ];
	then 
		PASSWORD=$(openssl rand -base64 32)
	fi

	#set password for the account that was just created and send message of sucessful account creation
	echo "$USERNAME:$PASSWORD" | sudo chpasswd && echo "Account for $USERNAME has been created successfully"

	#create a credentials file and pass in username and password
	touch credentials.txt
	echo "Welcome to our company, here is your login details" >> credentials.txt
	echo "username: $USERNAME" >> credentials.txt
	echo "password: $PASSWORD" >> credentials.txt

	#send email with user credentials to new user and delete the credentials file for security reasons
	mail -A credentials.txt -s "your login credentials" "$EMAIL" < /dev/null && echo "mail has been sent successfuly to $EMAIL" && \
		echo "Deleting credentials file" && \
		rm -rf credentials.txt && \
		echo "credentials.txt successfully deleted"

	#copy company rules to new users home directory
	sudo cp company_rules.txt /home/$USERNAME && \
		echo "company rules copied successfully"
}

deleteUser() {
	sudo userdel $USERNAME && sudo rm -rf /home/$USERNAME && \
	echo "user $USERNAME has been removed from the system"
}

if [[ "$1" == "add" && -z "$2" && -z "$3" ]]
then
	echo "Please input a valid username and email address as second and third argument"
elif [[ "$1" == "add" && -n "$2" && -z "$3" ]]
then
	echo "Please input a valid email address as a third argument"
elif [ "$1" == "add" ]
then
	addUser
elif [ "$1" == "delete" ]
then
	deleteUser
else
	echo "you must enter add or delete as first argument"
fi

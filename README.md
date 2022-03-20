# HHA504-E2E-Final-Assignment

The following is a step-by-step tutorial on how to setup and deploy a ubuntu server on Azure.

## Setting up the virtual machine
1. In the Microsoft Azure portal, create a virtual machine (VM). For this exercise, we created a virtual machine on the Linux OS, standard B1s size, and chose "Password" for the authentication type. Create a username and password.
2. After creating the virtual machine, go to "Networking" and add an inbound port rule for MySQL-3306.

## Connecting to the virtual machine
1. Open the terminal or command prompt on your computer.
2. Type "ssh username@publicIPaddress. Ther username is the one you created for the virtual machine in Part 1 and the Public IP address of your VM can be found in the Overview section in the Azure portal.

## Installing MySQL and creating a new user
1. Once connected, type in the command "sudo apt-get update" to update the Ubuntu server.
2. Type "sudo apt install mysql-server mysql-client" to install MySQL on your VM.
3. After the installation is complete, enter "sudo mysql" to log into MySQL.
4. Create a new user with the command "CREATE USER 'USERNAME'@'%' IDENTIFIED BY 'PASSWORD';. 
5. Confirm the creation of the user by typing "select user from mysql.user;". 
6. Grant privileges to the new user by typing "GRANT ALL PRIVILEGES ON . TO 'username'@'%' WITH GRANT OPTION;"
7. Confirm privileges with "show grants for username;".
8. Test the new user connection by typing "my sql -u username -p" and entering the password that you had previously created.
9. Type "create database e2e;" and confirm its creation with "show databases;".

## Write a Python script that connects to your MySQL instance
1. In a Jupyter Notebook or Python IDE import the relevant packages (as shown in the Jupyter Notebook provided in this repo).  
2. For the code to connect to the MySQL instance: 
MYSQL_HOSTNAME = Your VM's Public IP address
MYSQL_USER = The username you made when creating your VM
MYSQL_PASSWORD = The password you made when creating your VM
MYSQL_DATABASE = The table you created ("e2e" in this exercise)
3. Follow the rest of the code as shown in the notebook.
4. Run the code. You will see a "Connection refused" error message.

## Fixing the connection error
1. Return to your terminal. We now need to update our MySQL configuration settings to enable external connections by updating the "mysql.cnf" special configuration file.
2. Type in "sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf" (make sure you are typing this in your VM and not in MySQL).
3. Go down to "bind-address" and Ctrl + I to edit the numbers to 0.0.0.0.
4. Save changes with Ctrl + O.
5. Ctrl + X to exit.
6. Type in "/etc/init.d/mysql restart" to restart MySQL for the changes to take place.
7. Rerun your Python script to connect to the MySQL instance. You should now be properly connected.
8. In your terminal, type "show databases;", "use e2e;" and "show tables" to see the newly uploaded data. You may also connect to your instance through MySQL workbench to view the database (using the same IP address, username, and password that you created in the first part of this tutorial. The connection name will be the name of your VM.)

## Creating a dump file 
1. Create a second virtual machine on Azure using the exact same steps in Part 1. Note your username, password and Public IP once again.
2. Back in your terminal, connect to the second virtual machine using the "ssh username@ipaddress" command.
3. Go back to the first VM and create a dump file by typing "sudo mysqldump e2e > nameofbackupfile.sql". 
4. Type "ls" to list the files and confirm the creation of the .sql file.
5. You can look at the file with the "nano nameofbackupfile.sql" command.
6. Send this file to the second virtual machine you created by typing "scp nameofbackupfile.sql username@ipaddress:/home/username". 
7. After pressing enter, type in the password for your second VM when prompted. 
8. Verify that the backup file has been successfully sent to the second VM by typing "ls".

## Creating a trigger
1. See the trigger file provided in this repo. You will notice that when making changes to the "h1n1" table within the e2e database, you cannot enter a value for h1n1 concern that is greater than 3.



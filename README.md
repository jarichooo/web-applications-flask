Set up your database/schema in xampp server before running the web application to ensure smooth operation :)

This can also be accessed through my GitHub repository
https://github.com/jarichooo/web-applications-flask.git

Method 1: Using phpMyAdmin (Graphical Interface)
Steps:

1. Start XAMPP:

	Open the XAMPP Control Panel.

	Click Start next to Apache and MySQL.

2. Open phpMyAdmin:

	Visit: http://localhost/phpmyadmin

3. Create a New Database (optional):

	Click New on the left sidebar.

	Enter a database name (e.g., my_database) and click Create.

4. Import SQL File:

	Click on the name of the database you created.

	Go to the Import tab.

	Click Choose File and select your .sql file.

	Click Go at the bottom.

	Your SQL file will be executed and the tables/data will be imported.

Method 2: Using Command Line Interface (CLI)
Steps:
1. Open Command Prompt (on Windows):

	Press Win + R, type cmd, and press Enter.

2. Navigate to the MySQL bin directory:
	cd C:\xampp\mysql\bin
	mysql -u root -p your_database_name < path\to\your\file.sql

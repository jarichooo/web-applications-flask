import mysql.connector # Establishes connection to database from python app
from mysql.connector import Error 
from dotenv import load_dotenv # loads environment variables from env file
import os # reads env files after loading


def establish_connection():
    try:
        connection = mysql.connector.connect(
            host= os.getenv('DB_HOST'),
            user= os.getenv('DB_USER'),
            password= os.getenv('DB_PASSWORD'),
            database= os.getenv('DB_DATABASE')
        )
        return connection
    except Error as e:
        print(f'Error connecting to localhost: {e}')
        return None # always return something even if it's none

def insert_user(firstName, middleName, lastName, role, password):
    try:
        connection = establish_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute("""INSERT INTO users (firstName, middleName, lastName, role, password) 
                           VALUES (%s, %s, %s, %s, %s)""", (firstName, middleName, lastName, role, password))
            connection.commit()
            
            # retrieves last added rod id
            userId = cursor.lastrowid

            # insert user id to linked tables
            tables = ["crops", "posts", "soilReports"]
            for i in tables:
                cursor.execute(f"""INSERT INTO {i} (userId) VALUES (%s)""", (userId,))
                connection.commit()

            return {
                "success": True,
                "message": f"Successfully add user {userId}"
            }

    except Error as e:
            return {
                "success": False,
                "message": f"Failed to insert user {e}"
            }
    finally:
        if connection:
            connection.close()

def insert_crops(cropName, fieldLocation, sowingTime):
    try:
        connection = establish_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute("""INSERT INTO crops (cropName, fieldLocation, sowingTime) 
                           VALUES (%s, %s, %s)""", (cropName, fieldLocation, sowingTime))
            connection.commit()
            cropId = cursor.lastrowid

            return {
                "sucess": True,
                "message": f"Crop successfully inserted: {cropId}"
            }
        
    except Error as e:
        return {
            "success": False,
            "message": "Was not able to insert crop to database"
        }
    finally:
        connection.close()

def inser_posts(title, body):
    try:
        connection = establish_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute("""INSERT INTO posts (title, body) 
                           VALUES (%s, %s)""", (title, body))
            connection.commit()
            postId = cursor.lastrowid

            return {
                "sucess": True,
                "message": f"Post successfully inserted: {postId}"
            }
        
    except Error as e:
        return {
            "success": False,
            "message": "Was not able to insert post to database"
        }
    finally:
        connection.close()

def insert_report(phLevel, nitrogenLevel, phosphorus, potassium, suggestion):
    try:
        connection = establish_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute("""INSERT INTO soilReports (phLevel, nitrogenLevel, phosphorus, potassium, suggestion) 
                           VALUES (%s, %s, %s, %s, %s)""", (phLevel, nitrogenLevel, phosphorus, potassium, suggestion))
            connection.commit()
            reportId = cursor.lastrowid

            return {
                "sucess": True,
                "message": f"Report successfully inserted: {reportId}"
            }
        
    except Error as e:
        return {
            "success": False,
            "message": "Was not able to insert report to database"
        }
    finally:
        connection.close()
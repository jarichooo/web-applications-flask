import mysql.connector
from mysql.connector import Error
from dotenv import load_dotenv
import os

load_dotenv()

def create_connection():
    try:
        connection = mysql.connector.connect(
            host=os.getenv('DB_HOST'),
            user=os.getenv('DB_USER'),
            password=os.getenv('DB_PASSWORD'),
            database=os.getenv('DB_NAME')
        )
        return connection
    except Error as e:
        print(f"Error connecting to MariaDB: {e}")
        return None

def fetchDrugs():
    try:
        connection = create_connection() 
        if connection:
            cursor = connection.cursor()
            cursor.execute("SELECT d.drugId, d.drugName, d.drugType, i.quantity, d.unitPrice FROM drugs d JOIN inventory i ON d.drugId = i.drugId")
            drugs = cursor.fetchall()

            result = []
            for drug in drugs:
                result.append({
                    "id": drug[0],
                    "name": drug[1],
                    "type": drug[2],
                    "quantity": drug[3],
                    "unitPrice": drug[4]
                })
            return result
    except Error as e:
        return {"error": str(e)}
    finally:
        if connection:
            connection.close()

def checkInventory():
    try:
        connection = create_connection()
        if connection:
            cursor = connection.cursor()

            cursor.execute("SELECT * FROM drugs")
            drugs = cursor.fetchall()
            
            cursor.execute("SELECT quantity FROM inventory")
            inventory = cursor.fetchall()
            
            cursor.execute("SELECT reorderLevel FROM inventory")
            orderLevel = cursor.fetchall()

            results = []
            for i in range(min(len(drugs), len(inventory))):
                drug = drugs[i]
                results.append({
                    "id": drug[0],
                    "name": drug[1],
                    "type": drug[2],
                    "price": drug[5],
                    "quantity": inventory[i][0],
                    "reorderLevel": orderLevel[i][0]
                })
            return results
            
                    
    except Error as e:
        return [{"error": str(e)}]
    finally:
        if connection:
            connection.close()

def updateInventory(inventoryId, quantity, reorderLevel, unitPrice):
    try:
        connection = create_connection()
        if connection:
            cursor = connection.cursor()

            quantity_updated = 0
            reorder_updated = 0
            unitPrice_updated = 0

            # Update quantity if it's not None and not an empty string
            if quantity not in [None, ""]:
                cursor.execute(
                    "UPDATE inventory SET quantity = %s WHERE inventoryId = %s",
                    (quantity, inventoryId)
                )
                quantity_updated = cursor.rowcount

            # Update reorder level if it's not None and not an empty string
            if reorderLevel not in [None, ""]:
                cursor.execute(
                    "UPDATE inventory SET reorderLevel = %s WHERE inventoryId = %s",
                    (reorderLevel, inventoryId)
                )
                reorder_updated = cursor.rowcount

            # Update unit price if it's not None and not an empty string
            if unitPrice not in [None, ""]:
                cursor.execute(
                    "UPDATE drugs SET unitPrice = %s WHERE drugId = %s",
                    (unitPrice, inventoryId)
                )
                unitPrice_updated = cursor.rowcount

            connection.commit()

            if quantity_updated > 0 or reorder_updated > 0 or unitPrice_updated > 0:
                return {
                    "success": True,
                    "message": "Inventory updated successfully."
                }
            else:
                return {
                    "success": False,
                    "message": "No changes were made to the inventory."
                }

    except Error as e:
        return {
            "success": False,
            "message": f"Error updating inventory: {e}"
        }
    finally:
        if connection:
            connection.close()

def addDrugs(drugName, drugType, description, manufacturer, unitPrice, expiryDate):
    try:
        connection = create_connection()
        if connection:
            cursor = connection.cursor()

            cursor.execute("SELECT MAX(drugId) FROM drugs")
            max_id = cursor.fetchone()[0]
            new_drugId = (max_id or 0) + 1

            cursor.execute("""
                INSERT INTO drugs (drugId, drugName, drugType, description, manufacturer, unitPrice, expiryDate)
                VALUES (%s, %s, %s, %s, %s, %s, %s)
            """, (new_drugId, drugName, drugType, description, manufacturer, unitPrice, expiryDate))
            connection.commit()

            cursor.execute("""
                INSERT INTO inventory (inventoryId, quantity, reorderLevel)
                VALUES (%s, %s, %s)
            """, (new_drugId, 0, 10))
            connection.commit()

            return {
                "success": True,
                "message": f"Drug added successfully with drugId {new_drugId}"
            }

    except Error as e:
        return {
            "success": False,
            "message": f"Error adding drug: {e}"
        }
    finally:
        if connection:
            connection.close()

def eradicateDrugs(drugIds):
    try:
        connection = create_connection()
        if connection:
            cursor = connection.cursor()
            
            format_strings = ','.join(['%s'] * len(drugIds))
            query = f"DELETE FROM inventory WHERE inventoryID IN ({format_strings})"
            cursor.execute(query, tuple(drugIds))
            connection.commit()

            # Use SQL IN clause to delete multiple records
            format_strings = ','.join(['%s'] * len(drugIds))
            query = f"DELETE FROM drugs WHERE drugId IN ({format_strings})"
            cursor.execute(query, tuple(drugIds))
            connection.commit()

            return {
                "success": True,
                "message": f"Deleted {cursor.rowcount} drug(s) with IDs: {', '.join(drugIds)}"
            }

    except Error as e:
        return {
            "success": False,
            "message": f"Error deleting inventory: {e}"
        }
    finally:
        if connection:
            connection.close()


def createAccount(lastName, firstName, email, password):
    try:
        connection = create_connection()
        if connection:
            cursor = connection.cursor()

            cursor.execute("SELECT MAX(userId) FROM users")
            max_id = cursor.fetchone()[0]
            new_userId = (max_id or 0) + 1

            cursor.execute("INSERT INTO users (userId, firstName, lastName, email, password) VALUES ( %s ,%s, %s, %s, %s)", (new_userId, lastName, firstName, email, password))
            connection.commit()

            return {
                "success": True,
                "message": f"Account created successfully with userId {new_userId}"
            }

    except Error as e:
        return {
            "success": False,
            "message": f"Error creating account: {e}"
        }
    finally:
        if connection:
            connection.close()

def logIn(email, password):
    try:
        connection = create_connection()
        if connection:
            cursor = connection.cursor()
            
            # Check if the user is an admin
            cursor.execute("SELECT * FROM admin WHERE email = %s AND password = %s", (email, password))
            admin = cursor.fetchone()

            if admin:
                return {
                    "userId": admin[0],
                    "firstName": admin[1],
                    "lastName": admin[2],
                    "email": admin[3],
                    "password": admin[4],
                    "userType":"admin"
                } 
            # Check if the user is a regular user
            cursor.execute("SELECT * FROM users WHERE email = %s AND password = %s", (email, password))
            user = cursor.fetchone()

            if user:
                return {
                    "userId": user[0],
                    "firstName": user[1],
                    "lastName": user[2],
                    "email": user[3],
                    "password": user[4],
                    "userType":"user"
                }
            else:
                return None
    except Error as e:
        return None
    finally:
        if connection:
            connection.close()


def submitPurchase(userId, drugId, quantity):
    try:
        connection = create_connection()
        if connection:
            cursor = connection.cursor()

            # Check if the drug is in stock and get unitPrice
            cursor.execute("SELECT quantity, unitPrice FROM inventory JOIN drugs ON inventory.drugId = drugs.drugId WHERE inventory.inventoryId = %s", (drugId,))
            result = cursor.fetchone()
            
            if result:
                current_quantity, unit_price = result
                if current_quantity >= quantity:
                    # Update the inventory
                    cursor.execute("UPDATE inventory SET quantity = quantity - %s WHERE inventoryId = %s", (quantity, drugId))
                    connection.commit()

                    # Calculate total price
                    total = quantity * float(unit_price)

                    # Insert into purchase history with total
                    cursor.execute(
                        "INSERT INTO purchases (quantityPurchased, purchaseDate, userId, drugId, total) VALUES (%s, CURDATE(), %s, %s, %s)",
                        (quantity, userId, drugId, total)
                    )
                    connection.commit()

                    return {
                        "success": True,
                        "message": "Purchase successful."
                    }
                else:
                    return {
                        "success": False,
                        "message": "Not enough stock available."
                    }
            else:
                return {
                    "success": False,
                    "message": "Drug not found."
                }

    except Error as e:
        return {
            "success": False,
            "message": f"Error processing purchase: {e}"
        }
    finally:
        if connection:
            connection.close()

def fetchPurchaseHistory(userId):
    try:
        connection = create_connection()
        if connection:
            cursor = connection.cursor()

            cursor.execute("""
                SELECT p.quantityPurchased, p.purchaseDate, d.drugName, d.unitPrice, p.total
                FROM purchases p
                JOIN drugs d ON p.drugId = d.drugId
                WHERE p.userId = %s
            """, (userId,))
            purchases = cursor.fetchall()

            result = []
            for purchase in purchases:
                result.append({
                    "quantityPurchased": purchase[0],
                    "purchaseDate": purchase[1],
                    "drugName": purchase[2],
                    "unitPrice": purchase[3],
                    "total": purchase[4]
                })
            return result

    except Error as e:
        return {"error": str(e)}
    finally:
        if connection:
            connection.close()
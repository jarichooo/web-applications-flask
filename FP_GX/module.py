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

def fetch_drugs():
    try:
        connection = create_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute("SELECT * FROM drugs")
            drugs = cursor.fetchall()

            result = []
            for i, drug in enumerate(drugs, start=1):
                result.append({
                    "id": i,
                    "name": drug[1],
                    "type": drug[2],
                    "price": drug[5]
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
                    "id": i + 1,
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

def update_inventory(inventoryId, quantity, reorderLevel, unitPrice):
    try:
        connection = create_connection()
        if connection:
            cursor = connection.cursor()
            
            # Check if inventory record exists
            cursor.execute("SELECT inventoryId FROM inventory WHERE inventoryId = %s", (inventoryId,))
            if not cursor.fetchone():
                return {
                    "success": False,
                    "message": f"Inventory record with ID {inventoryId} does not exist."
                }
            # Initialize updated flags
            quantity_updated = 0
            reorder_updated = 0
            unitPrice_updated = 0
            
            # Update quantity
            if quantity is not None:
                cursor.execute("UPDATE inventory SET quantity = %s WHERE inventoryId = %s", (quantity, inventoryId))
                quantity_updated = cursor.rowcount

            # Update reorder level
            if reorderLevel is not None:
                cursor.execute("UPDATE inventory SET reorderLevel = %s WHERE inventoryId = %s", (reorderLevel, inventoryId))
                reorder_updated = cursor.rowcount

            # Update Unit price
            if unitPrice is not None:                
                cursor.execute("UPDATE drugs SET unitPrice = %s WHERE drugId = %s", (unitPrice, inventoryId))
                unitPrice_updated = cursor.rowcount

            connection.commit()

            if quantity_updated > 0 or reorder_updated > 0 or (unitPrice is not None and unitPrice_updated > 0) :
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
            cursor.execute("""INSERT INTO drugs (drugName, drugType, description, manufacturer, unitPrice, expiryDate)
                VALUES (%s, %s, %s, %s, %s, %s) """, (drugName, drugType, description, manufacturer, unitPrice, expiryDate))
            connection.commit()

            drugId = cursor.lastrowid
            cursor.execute("INSERT INTO inventory (drugId, quantity, reorderLevel) VALUES (%s, %s, %s)", (drugId, 0, 10))
            connection.commit()
            return {
                "success": True,
                "message": "Drug added successfully."
            }
        
    except Error as e:
        return {
            "success": False,
            "message": f"Error adding drug: {e}"
        }
    finally:
        if connection:
            connection.close()


def delete_record(drugId):
    try:
        connection = create_connection()
        if connection:
            cursor = connection.cursor()
            
            # Check if inventory record exists
            cursor.execute("SELECT drugId FROM drugs WHERE drugId = %s", (drugId,))
            if not cursor.fetchone():
                return {
                    "success": False,
                    "message": f"Inventory record with ID {drugId} does not exist."
                }
            
            # Update quantity
            cursor.execute("UPDATE drugs SET unitPrice = %s WHERE inventoryId = %s", (drugId, ))
            quantity_updated = cursor.rowcount
            connection.commit()
    
    
    except Error as e:
        return {
            "success": False,
            "message": f"Error updating inventory: {e}"
        }
    finally:
        if connection:
            connection.close()
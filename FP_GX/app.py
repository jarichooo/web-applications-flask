from flask import Flask, render_template, request, redirect, url_for, jsonify
from module import fetch_drugs, checkInventory, update_inventory, addDrugs
app = Flask(__name__)

@app.route("/")
def index():
    drugs = fetch_drugs()
    return render_template("index.html", drugs=drugs)

@app.route("/inventory")
def inventory():
    items = checkInventory()
    return render_template("inventory.html", items=items)

@app.route("/updateQuantityOlevel", methods=['GET', 'POST'])

def updateQuantityOlevel():
    control = None

     # Get data from the form
    inventoryId = request.form.get('inventoryId')
    quantity = request.form.get('quantity')
    quantity = quantity if quantity else None

    reorderLevel = request.form.get('reorderLevel')
    reorderLevel = reorderLevel if reorderLevel else None

    unitPrice = request.form.get('unitPrice')
    unitPrice = unitPrice if unitPrice else None

    control = update_inventory(inventoryId, quantity, reorderLevel, unitPrice)

    return render_template("updateQuantityOlevel.html", control=control)

@app.route('/addDrug', methods=['GET', 'POST'])

def addDrug():
    if request.method == 'POST':
        drugName = request.form.get('drugName')
        drugType = request.form.get('drugType')
        description = request.form.get('description')
        manufacturer = request.form.get('manufacturer')
        unitPrice = request.form.get('unitPrice')
        expiryDate = request.form.get('expiryDate')

        result = addDrugs(drugName, drugType, description, manufacturer, unitPrice, expiryDate)
        if result["success"]:
            return redirect(url_for('inventory'))
        else:
            # Pass the error message to the template or handle as you like
            return render_template('addDrug.html', error=result["message"])

    return render_template('addDrug.html')
    
if __name__ == "__main__":
    app.run(debug=True)
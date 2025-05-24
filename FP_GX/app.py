import os
from flask import Flask, render_template, request, redirect, url_for, session
from module import fetchDrugs, checkInventory, updateInventory, addDrugs, eradicateDrugs, logIn, createAccount, submitPurchase, fetchPurchaseHistory, fetchUserPurchase

app = Flask(__name__)
app.secret_key = os.getenv("DB_SUPERSECRET_KEY")

#----------------------------------------------------database connection----------------------------------------------------
@app.route("/", methods=["GET"])
def login_get():
    return render_template("login.html")
#----------------------------------------------------logout----------------------------------------------------
@app.route("/logout")
def logout():
    session.clear()  
    return redirect(url_for("login_get"))
#----------------------------------------------------admin----------------------------------------------------
@app.route("/admin")
def admin():
    drugs = fetchDrugs()
    return render_template("admin.html", drugs=drugs)
#----------------------------------------------------login----------------------------------------------------
@app.after_request
def add_header(response):
    response.headers['Cache-Control'] = 'no-store, no-cache, must-revalidate, private'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = '0'
    return response

#----------------------------------------------------log_post----------------------------------------------------
@app.route("/login", methods=["POST"])
def login_post():
    email = request.form.get("email")
    password = request.form.get("password")

    user = logIn(email, password)
    if user and user["email"] == email and user["password"] == password:
        session["user"] = {
            "userId": user["userId"],
            "firstName": user["firstName"],
            "lastName": user["lastName"],
            "email": user["email"],
            "userType": user["userType"]
        }
        if user["userType"] == "admin":
            return redirect(url_for("admin"))
        else:
            return redirect(url_for("userPage"))

    return render_template("login.html", error="Invalid credentials")

#----------------------------------------------------userPage----------------------------------------------------
@app.route("/userPage", methods=["GET"])
def userPage():
    user = session.get("user")
    if not user:
        return redirect(url_for("login_get"))
    drugs = fetchDrugs()
    return render_template("userPage.html", user=user, drugs=drugs)


#----------------------------------------------------submit purchase----------------------------------------------------
@app.route("/submitPurchase", methods=["POST"])
def submitPurchaseRoute():
    user = session.get("user")
    if not user:
        return redirect(url_for("login_get"))

    try:
        drug_id = int(request.form.get("drugId"))
        quantity = int(request.form.get("quantity"))
    except (ValueError, TypeError):
        return render_template("userPage.html", user=user, error="Invalid drug ID or quantity.")

    result = submitPurchase(user["userId"], drug_id, quantity)

    if result["success"]:
        return redirect(url_for("userPage"))
    else:
        return render_template("userPage.html", user=user, error=result["message"])

#----------------------------------------------------create user----------------------------------------------------
@app.route("/createUser", methods=["GET", "POST"])
def createUser():
    if request.method == 'POST':
        lastName = request.form.get('lastName')
        firstName = request.form.get('firstName')
        email = request.form.get('email')
        password = request.form.get('password')

        registration = createAccount(lastName, firstName, email, password)

        if registration["success"]:
            return redirect(url_for('login_get'))
        else:
            return render_template('createUser.html', error=registration["message"])

    return render_template('createUser.html', error=None)

#----------------------------------------------------inventory----------------------------------------------------
@app.route("/inventory")
def inventory():
    items = checkInventory()
    return render_template("inventory.html", items=items)
#----------------------------------------------------update quantity and reorder level----------------------------------------------------
@app.route("/updateQuantityOlevel", methods=['GET', 'POST'])
def updateQuantityOlevel():
    control = None
    if request.method == 'POST':
        inventoryId = request.form.get('inventoryId')
        quantity = request.form.get('quantity')
        reorderLevel = request.form.get('reorderLevel')
        unitPrice = request.form.get('unitPrice')

        control = updateInventory(inventoryId, quantity, reorderLevel, unitPrice)

    return render_template("updateQuantityOlevel.html", control=control)

#==------------------------------------add drugs----------------------------------------------------
@app.route('/addDrug', methods=['GET', 'POST'])
def addDrug():
    if request.method == 'POST':
        drugName = request.form.get('drugName')
        drugType = request.form.get('drugType')
        description = request.form.get('description')
        manufacturer = request.form.get('manufacturer')
        unitPrice = float(request.form.get('unitPrice'))
        expiryDate = request.form.get('expiryDate')

        result = addDrugs(drugName, drugType, description, manufacturer, unitPrice, expiryDate)
        if result["success"]:
            return redirect(url_for('inventory'))
        else:
            return render_template('addDrug.html', error=result["message"])

    return render_template('addDrug.html')

#----------------------------------------------------delete drugs----------------------------------------------------
@app.route('/deleteDrugs', methods=['GET', 'POST'])
def deleteDrugs():
    message = ''
    success = False

    if request.method == 'POST':
        drug_ids_raw = request.form.get('drugIds')  
        if drug_ids_raw:
            drug_ids = [id.strip() for id in drug_ids_raw.split(',') if id.strip().isdigit()]
            if drug_ids:
                result = eradicateDrugs(drug_ids)
                message = result['message']
                success = result['success']
            else:
                message = 'No valid drug IDs provided.'
        else:
            message = 'No drug IDs submitted.'

    return render_template('deleteDrugs.html', message=message, success=success)

@app.route('/userPurchases', methods=['GET'])
def userPurchases():
    user = session.get("user")
    if not user:
        return redirect(url_for("login_get"))

    purchases = fetchPurchaseHistory(user["userId"])
    return render_template('userPurchases.html', purchases=purchases)

@app.route('/userCart', methods=['GET'])
def userCart():
    user = session.get("user")
    if not user:
        return redirect(url_for("login_get"))

    myPurchase = fetchUserPurchase(user["userId"])
    return render_template('userCart.html', purchases=myPurchase)

if __name__ == "__main__":
    app.run(debug=True)
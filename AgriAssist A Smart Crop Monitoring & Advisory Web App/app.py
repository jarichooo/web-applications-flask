from flask import Flask
from module import *
app = Flask(__name__)

@app.route('/')
def home():
    return "IMY"

if __name__ == "__main__":
    app.run(debug=True)
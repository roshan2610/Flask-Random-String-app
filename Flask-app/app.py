from flask import Flask, jsonify
import random

app = Flask(__name__)

#Given List of strings
random_strings = ["Investments", "Smallcase", "Stocks", "buy-the-dip", "TickerTape"]

@app.route('/api/v1', methods = ['GET'])
def get_random_string():
    #Choosing a random string from list of strings 
    random_string = random.choice(random_strings)
    #Return the string in json form
    return jsonify({"random_string": random_string})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8081)
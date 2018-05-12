from flask import Flask, request
from web3.auto import w3

class SmartContractHandler:
    def __init__(self):
        pass;
    def handle_blockchain_connection(self, )

app = Flask(__name__) #create flask app

@app.route('/', methods=['POST'])
def push_transaction():
    values = request.get_json()
    
    # check that required fields are POST'ed in it
    requires = ['method', 'params', 'digital_signature'];
    if not all(k in values for k in required):
        return 'Missing params', 400
    

if __name__ == "__main__":
    app.run()
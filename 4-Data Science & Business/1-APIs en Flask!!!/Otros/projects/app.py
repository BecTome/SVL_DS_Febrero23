from flask import Flask, jsonify, request

app = Flask(__name__)

stores = [
    {
        'name': 'My First Store',
        'items':[
            {
            'name': 'My Item',
            'price': 15.99
            }
        ]
    }
]

@app.route('/store', methods=['POST'])
def create_store():
    request_data = request.get_json()
    new_store = {
                'name': request_data['name'],
                'items':[]    
                }
    
    stores.append(new_store)

    return jsonify(new_store)

@app.route('/store/<string:name>', methods=['GET'])
def get_store(name):
    pass

# @app.route()

app.run(port=5000)
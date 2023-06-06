
from flask import Flask, request, jsonify
import pickle
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error
from sklearn.linear_model import LinearRegression

app = Flask(__name__)
app.config["DEBUG"] = True

'''
La peticion seria:
http://127.0.0.1:5000/api/v1/adv_model/predict?TV=180&radio=15&newspaper=60
'''
@app.route('/api/v1/adv_model/predict', methods=['GET'])
def predict():

    args = request.args
    if 'TV' in args and 'radio' in args and 'newspaper' in args:
        with open('advertising.model', "rb") as archivo_entrada:
            model = pickle.load(archivo_entrada)

        tv = args.get('TV', None)
        radio = args.get('radio', None)
        newspaper = args.get('newspaper', None)

        if tv is None or radio is None or newspaper is None:
            return "Error. Args empty"
        else:
            predictions = model.predict([[float(tv),
                                          float(radio),
                                          float(newspaper)]])

            return jsonify({"predictions": list(predictions)})

    else:
        return "Error in args"


'''
http://127.0.0.1:5000/api/v1/adv_model/register?TV=180&radio=15&newspaper=60&sales=12000
'''
@app.route('/api/v1/adv_model/register', methods=['POST'])
def new_register():
    args = request.args
    if 'TV' in args and 'radio' in args and 'newspaper' in args and 'sales' in args:

        tv = args.get('TV', None)
        radio = args.get('radio', None)
        newspaper = args.get('newspaper', None)
        sales = args.get('sales', None)

        if tv is None or radio is None or newspaper is None or sales is None:
            return "Error. Args empty"
        else:

            data = pd.read_csv('data/Advertising.csv')

            new_register_dict = {'TV': [float(tv)],
                                 'radio': [float(radio)],
                                 'newspaper': [float(newspaper)],
                                 'sales': [float(sales)]}

            new_register = pd.DataFrame(new_register_dict)
            data = pd.concat([data, new_register]).reset_index()
            data.to_csv('data/Advertising_Update.csv', index=False)

            return jsonify(new_register_dict)
    else:
        return "Error in args"


'''
http://127.0.0.1:5000/api/v1/adv_model/retrain
'''
@app.route('/api/v1/adv_model/retrain', methods=['PUT'])
def retrain():
    try:
        data = pd.read_csv('data/Advertising_Update.csv')
        data.drop(['index'], 1, inplace=True)

        X_train, X_test, y_train, y_test = train_test_split(data.drop(['sales'],1),
                                                            data['sales'],
                                                            test_size=0.20,
                                                            random_state=42)

        lin_reg = LinearRegression()
        lin_reg.fit(X_train, y_train)

        pickle.dump(lin_reg, open('advertising.model', 'wb'))

        return "Finished train successfully"
    except:
        return "Error training"


app.run()
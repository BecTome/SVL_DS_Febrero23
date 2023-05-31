from flask import Flask, jsonify, request
import os
import pickle
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import Lasso
from sklearn.metrics import mean_squared_error
import numpy as np

os.chdir(os.path.dirname(__file__))

app = Flask(__name__)
app.config['DEBUG'] = True

@app.route("/", methods=['GET'])
def hello():
    return "Bienvenido a mi API del modelo advertising"


@app.route('/api/v1/predict', methods=['GET'])
def predict():

    model = pickle.load(open('ad_model.pkl','rb'))
    tv = request.args.get('tv', None)
    radio = request.args.get('radio', None)
    newspaper = request.args.get('newspaper', None)

    print(tv,radio,newspaper)
    print(type(tv))

    if tv is None or radio is None or newspaper is None:
        return "Args empty, the data are not enough to predict"
    else:
        prediction = model.predict([[float(tv),float(radio),float(newspaper)]])
    
    return jsonify({'predictions': prediction[0]})

@app.route('/api/v1/retrain', methods=['GET'])
def retrain():
    data = pd.read_csv('data/Advertising.csv', index_col=0)

    X_train, X_test, y_train, y_test = train_test_split(data.drop(columns=['sales']),
                                                    data['sales'],
                                                    test_size = 0.20,
                                                    random_state=42)

    model = Lasso(alpha=6000)
    model.fit(X_train, y_train)
    rmse = np.sqrt(mean_squared_error(y_test, model.predict(X_test)))

    model.fit(data.drop(columns=['sales']), data['sales'])
    pickle.dump(model, open('ad_model.pkl', 'wb'))

    return "Model retrained. New evaluation metric RMSE: " + str(rmse)

app.run()
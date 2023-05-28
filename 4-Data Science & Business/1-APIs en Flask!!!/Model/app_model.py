from flask import Flask, jsonify, request
import os
import pickle
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import Lasso
from sklearn.metrics import mean_squared_error
import numpy as np

# os.chdir(os.path.dirname(__file__))

app = Flask(__name__)
app.config['DEBUG'] = True

# Enruta la landing page (endpoint /)
def hello():
    return "Bienvenido a mi API del modelo advertising"

# Enruta la funcion al endpoint /api/v1/predict
def predict():

    # Carga el modelo

    # Procesa los argumentos (fila a predecir)

    # Realiza la prediccion

    # Devuelve la prediccion en el formato adecuado (jsonify)
    return 

@app.route('/api/v1/retrain', methods=['GET'])
# Enruta la funcion al endpoint /api/v1/retrain
def retrain():
    # Carga los datos de Advertising.csv

    # Entrena el modelo

    # Guarda la nueva versión del modelo y haz que esté disponible para el endpoint /api/v1/predict

    # Devuelve un mensaje de que está entrenado
    return 

app.run()
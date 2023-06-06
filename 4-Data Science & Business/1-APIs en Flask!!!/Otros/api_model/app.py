import numpy as np
from flask import Flask, request, jsonify
import joblib

app = Flask(__name__)
model_path = "4-Data Science & Business\\2-APIs en Flask!!!\\api_model\\model\\model.sav"
target = ['setosa', 'versicolor', 'virginica']

@app.route('/predict', methods=['PUT'])
def predict():
    vals = request.args
    model = joblib.load(model_path)
    if "slength" in vals or "swidth" in vals or "plength" in vals or "pwidth" in vals:
        data = np.array([[vals.get("slength", None),
                         vals.get("swidth", None),
                         vals.get("plength", None),
                         vals.get("pwidth", None)]], 
                         dtype=np.float32)
        prediction = target[model.predict(data)[0]]

    return jsonify(prediction)


app.run(port=5000, debug=True)
from os import path

from sklearn.datasets import load_iris
from sklearn.ensemble import RandomForestClassifier
from sklearn.pipeline import make_pipeline
from sklearn.impute import SimpleImputer

import joblib

data = load_iris()
X = data['data']
y = data['target']
print(data['feature_names'])

pipe = make_pipeline(SimpleImputer(strategy="median"), 
                     RandomForestClassifier())

pipe.fit(X, y)

model_path = '4-Data Science & Business\\2-APIs en Flask!!!\\api_model\\model'

joblib.dump(pipe, path.join(model_path, 'model.sav'))
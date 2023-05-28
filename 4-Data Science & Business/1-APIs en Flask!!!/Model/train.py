import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error
from sklearn.linear_model import Lasso
import pickle
import os

#os.chdir(os.path.dirname(__file__))

data = pd.read_csv('data/Advertising.csv', index_col=0)

X_train, X_test, y_train, y_test = train_test_split(data.drop(columns=['sales']),
                                                    data['sales'],
                                                    test_size = 0.20,
                                                    random_state=42)

model = Lasso(alpha=6000)
model.fit(X_train, y_train)

pickle.dump(model, open('ad_model.pkl', 'wb'))

print("MSE: ", mean_squared_error(y_test, model.predict(X_test)))
print("RMSE: ", np.sqrt(mean_squared_error(y_test, model.predict(X_test))))
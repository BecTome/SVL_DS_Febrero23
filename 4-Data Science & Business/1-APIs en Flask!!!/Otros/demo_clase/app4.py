'''
Este ejemplo es para mandar una foto y guardarla
Posteriormente se utilizara este codigo para predecir
con Deep Learning
Docu de Flask: https://flask.palletsprojects.com/en/1.1.x/patterns/fileuploads/
'''


from flask import Flask, request
import os
import cv2
import numpy as np
from PIL import Image
from io import BytesIO

app = Flask(__name__)
app.config["DEBUG"] = True

UPLOAD_FOLDER = 'C:\\Users\\alber\\Documents\\GitHub\\TheBridge\\SVL_DS_Septiembre22\\4-Data Science & Business\\2-APIs en Flask!!!\\demo_clase\\images\\received'

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

@app.route('/uploader', methods=['GET'])
def upload_file():
    if request.method == 'GET':

        # check if the post request has the file part
        print(request.files)
        if 'image' not in request.files:
            return "File not in body"

        file = request.files['image']
        print(request.files['image'])

        f = request.files['image'].read()
        npimg = np.fromstring(f, np.uint8)
        img = cv2.imdecode(npimg, cv2.IMREAD_COLOR)

        print(img.shape)

        # if user does not select file, browser also
        # submit a empty part without filename
        if file.filename == '':
            return "No selected file"

        if file:
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], file.filename))
            return "Worked!"

app.run()
from flask import Flask, jsonify, request
from datos_dummy import books

app = Flask(__name__)
app.config["DEBUG"] = True

# Ruta Home


# 1.Ruta para obtener todos los libros


# 2.Ruta para obtener un libro concreto mediante su id como parámetro en la llamada


# 3.Ruta para obtener un libro concreto mediante su título como parámetro en la llamada de otra forma

# 4.Ruta para obtener un libro concreto mediante su título dentro del cuerpo de la llamada

# 5.Ruta para añadir un libro mediante parámetros en la llamada


# 6.Ruta para añadir un libro de otra forma 1


# 7.Ruta para modificar un libro

# 8.Ruta para eliminar un libro


app.run()
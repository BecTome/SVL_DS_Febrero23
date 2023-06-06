
from flask import Flask

'''
Añade un nombre único a la APP, lo hace automatico
Flask es una clase del paquete flask.
'''
app = Flask(__name__)
# Para que salten los errores en la página y podamos debuguearlo bien
# Tb sirve para que formatee los JSONs de los outputs del navegador.
app.config["DEBUG"] = True

'''
Que request va a entender.
Accede al home page de la api
El methods es opcional ahora mismo

Utilizamos un decorator para enrutar las peticiones. '/' significa que está
accediendo a la home page de la API, a la raiz. Al ser un decorator, utilizará
acciones dentro del metodo route de Flask, después llamará a la funcion
que creamos debajo y finalmente acabará con otras acciones de la funcion route.

'''
@app.route('/', methods=['GET'])
def home():
	return "<h1>Distant Reading Archive</h1><p>This site is a prototype API for distant reading of science fiction novels.</p>"


'''
Dejamos corriendo la app. Podemos especificar el puerto, aunque no es obligatorio.
Si esto da algun error, es que igual tenemos un puerto ya ocupado
Asegurate que estas en la carpeta correcta y ejecuta "python api1.py"
127.0.0.1 es una dirección interna del propio ordenador, como locahost. Es el edpoint.
'''
app.run()


import flask

# Añade un nombre único a la APP, lo hace automatico
# Flask es una clase del paquete flask.
app = flask.Flask(__name__)
app.config["DEBUG"] = True


# Que request va a entender.
# Accede al home page de la api
@app.route('/', methods=['GET'])
def home():
    return "<h1>Distant Reading Archive</h1><p>This site is a prototype API for distant reading of science fiction novels.</p>"

app.run()
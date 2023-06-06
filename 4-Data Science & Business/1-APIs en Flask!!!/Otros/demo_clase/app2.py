
from flask import Flask, jsonify, request
from datos_dummy import books

app = Flask(__name__)
app.config["DEBUG"] = True

@app.route('/')
def home():
    return "<h1>Distant Reading Archive</h1><p>This site is a prototype API for distant reading of science fiction novels.</p>"



'''
Conviene poner la versión por si se está dando servicio de API con versiones
anteriores. Y resources tb es importante para que escale con nuevos resources.
'''
@app.route('/api/v1/resources/books/all', methods=['GET'])
def get_all():
    # Para pasar a un json, que es lo que devuelve la API
    return jsonify(books)

'''
Si ponemos dos rutas iguales, va a hacer caso a la primera.
Probar a meter varios argumentos separados por &
'''
@app.route('/api/v1/resources/book', methods=['GET'])
def api_id():
    # Check if an ID was provided as part of the URL.
    # If ID is provided, assign it to a variable.
    # If no ID is provided, display an error in the browser.
    if 'id' in request.args:
        id = int(request.args['id'])
    else:
        return "Error: No id field provided. Please specify an id."

    # Create an empty list for our results
    results = []

    # Loop through the data and match results that fit the requested ID.
    # IDs are unique, but other fields might return many results
    for book in books:
        if book['id'] == id:
            results.append(book)

    # Use the jsonify function from Flask to convert our list of
    # Python dictionaries to the JSON format.
    return jsonify(results)


'''
Otra manera de introducir argumentos
'''
@app.route('/api/v1/resources/book/<string:title>', methods=['GET'])
def get_by_title(title):
    for book in books:
        if book['title'] == title:
            return jsonify(book)
    return jsonify({'message': "Book not found"})


'''
Tercera manera de introducir args. Esta vez en el propio cuerpo.
OJO ESTE ES V2, PARA NO CONFUNDIR CON OTROS ENRUTADOS
'''
@app.route('/api/v2/resources/book', methods=['GET'])
def get_by_id():
    id = int(request.get_json()['id'])
    for book in books:
        if book['id'] == id:
            return jsonify(book)
    return jsonify({'message': "Book not found"})


@app.route('/api/v1/resources/book', methods=['POST'])
def post_book():
    data = request.get_json()
    books.append(data)
    return data


@app.route('/api/v1/resources/<string:title>/published', methods=['PUT'])
def post_book_published(title):
    data = request.get_json()
    for book in books:
        if book['title'] == title:
            book['published'] = data['published']
            return book
    return jsonify({'message': "Book not found"})

    return data


# Esta seria otra alternativa.
@app.route('/api/v1/resources/<string:title>/<int:published>', methods=['PUT'])
def post_book_published2(title, published):
    for book in books:
        if book['title'] == title:
            book['published'] = published
            return book
    return jsonify({'message': "Book not found"})

    return data


app.run()


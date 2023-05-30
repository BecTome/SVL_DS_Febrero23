from flask import Flask, jsonify, request
from datos_dummy import books

app = Flask(__name__)
app.config["DEBUG"] = True

# Ruta Home
@app.route('/', methods=['GET'])
def home():
    return "<h1>API de libros</h1><p>Esta es la página de inicio</p>"

# 1.Ruta para obtener todos los libros
@app.route('/books/all', methods=['GET'])
def books_all():
    return jsonify(books)

# 2.Ruta para obtener un libro concreto mediante su id como parámetro en la llamada
@app.route('/books', methods=['GET'])
def books_id():
    if 'id' in request.args:
        id = int(request.args['id'])
        for book in books:
            if book['id'] == id:
                return jsonify(book)
        else:
            return "ID not in DB"
    else:
        return "No ID provided"

# 3.Ruta para obtener un libro concreto mediante su título como parámetro en la llamada de otra forma
@app.route("/books/<string:title>", methods=['GET'])
def books_title(title):
    
    for book in books:
        if book['title'] == title:
            return jsonify(book)
    
    return "Not Found"



# 4.Ruta para obtener un libro concreto mediante su título dentro del cuerpo de la llamada
@app.route("/v2/books", methods=['GET'])
def get_book_title():
    body = request.get_json()
    if 'title' in body:
        for book in books:
            if book['title'] == body['title']:
                return jsonify(book)
        return "Title Not Found"
    return "Missing title in request body"

# 5.Ruta para añadir un libro mediante parámetros en la llamada
@app.route("/books/create", methods=['GET', 'POST'])
def create_book():
    args = request.args
    title = args.get('title', None)
    author = args.get('author', None)
    fsent = args.get('fs', None)
    pub = args.get('published', None)

    id = max([book['id'] for book in books]) + 1

    ls_titles = [book['title'] for book in books]
    ls_authors = [book['author'] for book in books]
    ls_pubs = [book['published'] for book in books]

    # d_out = {}
    if (title is not None)&(author is not None)&(pub is not None):
        if (title not in ls_titles)&(author not in ls_authors)&(pub not in ls_pubs):
            d_out = {'id':id, 'title': title, 'author': author, 
                    'first_sentence': fsent, "published": pub}
            books.append(d_out)
            return jsonify(d_out)
        return "Book already in Database"
    else:
        return "ERROR!! MISSING FIELDS"

# 6.Ruta para añadir un libro de otra forma 1
@app.route("/v2/books/create", methods=['POST'])
def create_book_body():
    args = request.get_json()
    title = args.get('title', None)
    author = args.get('author', None)
    fsent = args.get('first_sentence', None)
    pub = args.get('published', None)

    id = max([book['id'] for book in books]) + 1

    ls_titles = [book['title'] for book in books]
    ls_authors = [book['author'] for book in books]
    ls_pubs = [book['published'] for book in books]
    
    # d_out = {}
    if (title is not None)&(author is not None)&(pub is not None):
        if (title not in ls_titles)&(author not in ls_authors)&(pub not in ls_pubs):
            d_out = {'id':id, 'title': title, 'author': author, 
                    'first_sentence': fsent, "published": pub}
            books.append(d_out)
            return jsonify(d_out), 201
        return jsonify({"Message": "Book already in Database"}), 400
    else:
        return jsonify({"Message": "Missing Fields"}), 400

# 7.Ruta para modificar un libro
@app.route('/books/<int:id>', methods=['PUT'])
def update_book(id):
    d_update = request.get_json()
    if 'id' in d_update:
        del d_update['id']

    for book in books:
        if book['id'] == id:
            book.update(d_update)
            return jsonify(d_update), 201


# 8.Ruta para eliminar un libro
@app.route("/books/delete/<int:id>", methods=["GET", "DELETE"])
def remove_book(id):
    for book in books:
        if book['id'] == id:
            books.remove(book)
            return jsonify(book), 200

app.run()
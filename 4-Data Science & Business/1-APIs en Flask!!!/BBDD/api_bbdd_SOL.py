import sqlite3
from flask import Flask, request, jsonify

app = Flask(__name__)
app.config['DEBUG'] = True

db = '4-Data Science & Business\\1-APIs en Flask!!!\\BBDD\\books.db'
def get_query(query):
    conn = sqlite3.connect(db)
    cursor = conn.cursor()
    result = cursor.execute(query).fetchall()
    conn.close()
    return result

# API para consultar todos los libros en /books/all
@app.route("/books/all", methods=["GET"])
def get_all():
    q_all = "SELECT * FROM books"
    all_books = get_query(q_all)
    return jsonify({"books": all_books})

# API para filtrar por autor
@app.route("/books", methods=['GET'])
def get_author():
    author = request.args.get('author', None)
    if author is not None:
        q_author = f"SELECT * FROM books WHERE author = '{author}'"
        return jsonify({author: get_query(q_author)})
    else:
        return jsonify({"Message": "No author provided"})
    
@app.route("/books/<string:author>", methods=['GET'])
def get_author_param(author):
    if author is not None:
        q_author = f"SELECT * FROM books WHERE author = '{author}'"
        return jsonify({author: get_query(q_author)})
    else:
        return jsonify({"Message": "No author provided"})

# API para llamar por filtros de query param
@app.route("/books/filter", methods=["GET"])
def filter_books():
    
    d_conds = request.args
    columns = get_query('PRAGMA table_info(books)')
    columns = [x[1] for x in columns]

    orig_query = "SELECT * FROM books WHERE"
    for col in columns:
        value = d_conds.get(col, None)
        if  value is not None:
            orig_query += f" {col} = {value} AND"
        
    orig_query = orig_query[:-4]
    results = get_query(orig_query)
    return jsonify({"results": results})

app.run()
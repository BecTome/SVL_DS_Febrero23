import sqlite3
from flask import Flask, request, jsonify

app = Flask(__name__)
app.config['DEBUG'] = True

db = '4-Data Science & Business\\1-APIs en Flask!!!\\BBDD\\books.db'

# API para consultar todos los libros en /books/all
def get_all():
    
    return None

# API para filtrar por autor 
def get_author():

    return None

# API para llamar por filtros de query param
def filter_books():

    return None

app.run()
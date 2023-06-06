


import sqlite3

def dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d

conn = sqlite3.connect('books.db')
conn.row_factory = dict_factory
cur = conn.cursor()
all_books = cur.execute('SELECT * FROM books;').fetchall()
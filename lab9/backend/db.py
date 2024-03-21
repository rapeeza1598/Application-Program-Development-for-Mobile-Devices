import sqlite3

def init_db():
    db = sqlite3.connect('database.db')
    cursor = db.cursor()
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL
        )
    ''')
    db.commit()
    db.close()

def get_db():
    conn = sqlite3.connect('database.db')
    return conn

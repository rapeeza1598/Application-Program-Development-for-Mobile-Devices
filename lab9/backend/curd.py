from typing import List
from pydantic import BaseModel
from db import get_db

class UserModel(BaseModel):
    name: str

class UserList(BaseModel):
    users: List[UserModel]

    
def get_all_users():
    try:
        db = get_db()
        cursor = db.cursor()
        cursor.execute("SELECT * FROM users")
        data = cursor.fetchall() 
        return data
    finally:
        db.close()

def create_user(user: UserModel):
    try:
        db = get_db()
        cursor = db.cursor()
        cursor.execute("INSERT INTO users(name) VALUES (?)", (user.name,))
        db.commit()
        return cursor.lastrowid
    finally:
        db.close()

def update_user(id: int, user: UserModel):
    try:
        db = get_db()
        cursor = db.cursor()
        cursor.execute("UPDATE users SET name = ? WHERE id = ?", (user.name, id))
        db.commit()
    finally:
        db.close()

def delete_user(id: int):
    try:
        db = get_db()
        cursor = db.cursor()
        cursor.execute("DELETE FROM users WHERE id = ?", (id,))
        db.commit()
    finally:
        db.close()

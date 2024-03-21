from fastapi import FastAPI

from curd import create_user, delete_user, get_all_users, update_user, UserModel

app = FastAPI()

class listUser:
    id: int
    name: str

@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.get("/user")
async def getUser():
    return get_all_users()

@app.post("/user")
async def createUser(user: UserModel):
    return create_user(user)
    
@app.put("/user/{id}")
async def updateUser(id: int, user: UserModel):
    update_user(id, user)
    return {** user.dict()}

@app.delete("/user/{id}")
async def deleteUser(id: int):
    delete_user(id)
    return {"id":id,"message":"user delete"}

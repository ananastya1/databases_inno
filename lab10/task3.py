from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017")
db = client["lab10"]
collection = db["db"]


def delete_single():
    collection.delete_one({"borough": "Brooklyn"})


def delete_all():
    collection.delete_many({"cuisine": "Thai"})


delete_single()
delete_all()

from datetime import datetime
from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017")
db = client["lab10"]
collection = db["db"]


def insert_restaurant(address, borough, cuisine, name, restaurant_id, grades):
    data = {
        "address": {
            "building": address[0],
            "zipcode": address[1],
            "coord": address[2],
            "street": address[3]
        },
        "borough": borough,
        "cuisine": cuisine,
        "name": name,
        "restaurant_id": restaurant_id,
        "grades": grades
    }
    collection.insert_one(data)


address = ("Sportivnaya 126", "420500", [-73.9557413, 40.7720266], "Sportivnaya")
borough = "Innopolis"
cuisine = "Serbian"
name = "The Best Restaurant"
restaurant_id = "41712354"
grades = [{
    "grade": "A",
    "score": 11,
    "date": datetime.strptime("04 Apr, 2023", "%d %b, %Y")
}]

insert_restaurant(address, borough, cuisine, name, restaurant_id, grades)

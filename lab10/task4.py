from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017")
db = client["lab10"]
collection = db["db"]


def process_restaurants(street):
    restaurants = list(collection.find({"address.street": street}))

    for restaurant in restaurants:
        a_grades = [grade for grade in restaurant["grades"] if grade["grade"] == "A"]

        if len(a_grades) > 1:
            collection.delete_one({"_id": restaurant["_id"]})
        else:
            new_grade = {
                "grade": "A",
                "score": None,
                "date": None
            }
            collection.update_one(
                {"_id": restaurant["_id"]},
                {"$push": {"grades": new_grade}}
            )


process_restaurants("Prospect Park West")

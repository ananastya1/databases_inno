from pymongo import MongoClient


def query_1():
    result = collection.find({"cuisine": "Irish"})
    return list(result)


def query_2():
    result = collection.find({"cuisine": {"$in": ["Irish", "Russian"]}})
    return list(result)


def query_3(street, zipcode, building):
    result = collection.find({"address.street": street, "address.zipcode": zipcode, "address.building": building})
    return list(result)


client = MongoClient("mongodb://localhost:27017")
db = client["lab10"]
collection = db["db"]

irish = query_1()
print("Irish Cuisines:\n", irish)

irish_and_russian = query_2()
print("Irish and Russian Cuisines:\n", irish_and_russian)

restaurant = query_3("Prospect Park West", "11215", "284")
print("Restaurant at Prospect Park West 284, 11215:\n", restaurant)

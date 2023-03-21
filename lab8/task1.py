import geopy as geopy
import psycopg2
from geopy.geocoders import Nominatim

con = psycopg2.connect(database="dvdrental", user="postgres",
                       password="postgres", host="127.0.0.1", port="5432")
geolocator = Nominatim(user_agent="a.barabanova@innopolis.university")

cur = con.cursor()
cur.execute('''
SELECT * FROM retrieves();
''')
rows = cur.fetchall()
locations = {}
longitude = []
latitude = []
for address in rows:
    try:
        location = geolocator.geocode(address[0])
    except:
        location = None
    if location is None:
        locations[address[0]] = [0.0, 0.0]
    else:
        locations[address[0]] = [location.latitude, location.longitude]

sql_addcolumns = 'ALTER TABLE address ADD latitude REAL;' \
                 'ALTER TABLE address ADD longitude REAL;'
cur.execute(sql_addcolumns)
con.commit()

for address, location in locations.items():
    cur.execute(f"UPDATE address SET latitude = {location[0]}, longitude = {location[1]} WHERE address = '{address}';")
    con.commit()

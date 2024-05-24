
import duckdb
import pandas

con = duckdb.connect("mydb.duckdb")
#--- with a one year lag on pm10_concentration for each city
#--- I Determine 5 top cities where air become more pure

file = open("top5_cities.sql", "r")
script = file.read()
df = con.sql(script)

print(df)

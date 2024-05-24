import duckdb
import pandas

con = duckdb.connect("mydb.duckdb")
df = con.sql("FROM air_ambient")
df_avg = con.sql("SELECT city, avg(pm10_concentration) FROM  air_ambient GROUP BY ALL ORDER BY  2 desc")

print(df_avg)
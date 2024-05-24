import duckdb
con = duckdb.connect("mydb.duckdb")

table_name = "air_ambient"
file = "'s3://us-prd-motherduck-open-datasets/who_ambient_air_quality/parquet/who_ambient_air_quality_database_version_v6_april_2023.parquet'"
# directly read a Parquet file from within SQL
con.sql("CREATE OR REPLACE TABLE "+table_name+" as SELECT * FROM " + file)
 

 
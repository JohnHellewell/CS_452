import mysql.connector
from mysql.connector import Error
from dotenv import load_dotenv
import os

load_dotenv()

MYSQL_USER = os.getenv("MYSQL_USER")
MYSQL_PASSWORD = os.getenv("MYSQL_PASSWORD")
MYSQL_HOST = 'localhost'
TARGET_DB = 'COMBAT_ROBOT'



def get_connection(database=None):
    return mysql.connector.connect(
        host=MYSQL_HOST,
        user=MYSQL_USER,
        password=MYSQL_PASSWORD,
        database=TARGET_DB
    )

def execute_sql_file(cursor, sql_file_path):
    with open(sql_file_path, 'r') as file:
        sql_commands = file.read()

    for command in sql_commands.split(';'):
        command = command.strip()
        
        try:
            cursor.execute(command)
        except Error as e:
                print(e)

try:
    conn = get_connection()
    cursor = conn.cursor()

    #Drop the database, start from scratch
    cursor.execute(f"DROP DATABASE IF EXISTS {TARGET_DB};")
    print(f"Dropped database '{TARGET_DB}'.")

    cursor.execute(f"CREATE DATABASE {TARGET_DB};")
    print(f"Created database '{TARGET_DB}'.")
    
    cursor.close()
    conn.close()

    #Reconnect
    conn = get_connection(database=TARGET_DB)
    cursor = conn.cursor()

    #Create tables
    execute_sql_file(cursor, 'AISQL/create_db.sql')
    conn.commit()

    print("Tables ready")

except Error as e:
    print(e)
finally:
    cursor.close()
    conn.close()

import mysql.connector
from mysql.connector import Error
from dotenv import load_dotenv
import os

load_dotenv()

MYSQL_USER = os.getenv("MYSQL_USER")
MYSQL_PASSWORD = os.getenv("MYSQL_PASSWORD")
MYSQL_HOST = 'localhost'
SQL_FILE_PATH = 'create_db.sql'
TARGET_DB = 'COMBAT_ROBOT'


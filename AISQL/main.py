import mysql.connector
from mysql.connector import Error
from dotenv import load_dotenv
import os
from openai import OpenAI

load_dotenv()

MYSQL_USER = os.getenv("MYSQL_USER")
MYSQL_PASSWORD = os.getenv("MYSQL_PASSWORD")
OPENAI_API_KEY = os.getenv("API_KEY")
MYSQL_HOST = 'localhost'
TARGET_DB = 'COMBAT_ROBOT'

CREATE_DB_PATH = 'AISQL/create_db.sql'
FILL_DATA_PATH = 'AISQL/fill_data.sql'


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

def user_input_to_gpt_prompt(user_input, strategy = 'zero-shot'):
    sql_only_specification = f"Generate an SQL query for a MySQL database with the given schema that will answer the following question: \"{user_input}\" " \
    "\nRespond ONLY with the SQL SELECT statement. Any additional chatter or commentary is unwanted, and will ruin the query. Do not even wrap the output in a sql code block"
    db_schema = ""
    with open(CREATE_DB_PATH, 'r') as file:
        db_schema = file.read()
    
    #pick strategy
    if strategy == 'zero-shot':
        return sql_only_specification + "\nDatabase Schema:\n" +  db_schema


def prompt_user_for_question(cursor):
     user_prompt = input("Welcome to the Combat Robotics database. Ask any question about any Robots, Events, or Brackets! Type your question:\n")
     #print("User Question: " + user_prompt)
     return user_prompt

def get_gpt_query(prompt):
    openAiClient = OpenAI(api_key = OPENAI_API_KEY)
    openAiClient.models.list() # check if the key is valid (update in config.json)
    stream = openAiClient.chat.completions.create(
        model="gpt-4o",
        messages=[{"role": "user", "content": prompt}],
        stream=True,
    )

    responseList = []
    for chunk in stream:
        if chunk.choices[0].delta.content is not None:
            responseList.append(chunk.choices[0].delta.content)

    result = "".join(responseList)
    return result

def friendly_response(sql_results, query, user_question, strategy = 'zero_shot'):
    prompt = f"SQL RESULTS:{sql_results} \n\nTranslate the SQL table results above into a natural, written answer. No additional commentary or chatter is needed, and do not reference the SQL aspect of the question. Pretend that I don't even know about the SQL process, I ONLY want an answer to my original question. If the query result is blank, it is not by mistake. That was the query result." \
            "For context, here is the original question, and the SQL query I used to answer the question:\nOriginal Question: \" {user_question} \"\nSQL Query:\n {query}"

    if strategy=='zero_shot':
        return get_gpt_query(prompt)
    if strategy=='single_domain_double_shot':
        prompt+="\nFor example: for an empty SQL Result table, user question: \"Which teams don't have any robots\", the response could be \"No teams had 0 robots\""
        return get_gpt_query(prompt)

    
def complete_question_cycle(cursor):
    #get prompt from user
    user_input = prompt_user_for_question(cursor)

    prompt = user_input_to_gpt_prompt(user_input)
    #print(prompt)

    #send to OpenAI, print output
    openAI_sql_query = get_gpt_query(prompt)
    #print(f"OpenAI Response:\n{openAI_response})
    cursor.execute(openAI_sql_query)
    query_results = cursor.fetchall()
    #print("Answer:\n")
    #for row in query_results:
    #    print(row)
    print(f"Answer: {friendly_response(query_results, openAI_sql_query, user_input, 'zero_shot')}")

    




try:
    conn = get_connection()
    cursor = conn.cursor()

    #Drop the database, start from scratch
    cursor.execute(f"DROP DATABASE IF EXISTS {TARGET_DB};")
    print(f"Dropped database '{TARGET_DB}'.")

    cursor.execute(f"CREATE DATABASE {TARGET_DB};")
    print(f"Created database '{TARGET_DB}'.")
    
    #Reconnect to new db
    cursor.close()
    conn.close()
    conn = get_connection(database=TARGET_DB)
    cursor = conn.cursor()

    #Create tables
    execute_sql_file(cursor, CREATE_DB_PATH)
    conn.commit()

    print("Tables created")

    #Fill tables with data
    execute_sql_file(cursor, FILL_DATA_PATH)
    conn.commit()

    print("Tables filled with data")

    #get question from user, throw to GPT, return response to user
    complete_question_cycle(cursor)
    
except Error as e:
    print(e)


cursor.close()
conn.close()

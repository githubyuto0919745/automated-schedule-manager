
import os
from openai import OpenAI
import mysql.connector
from dotenv import load_dotenv


load_dotenv()

# Connect to MYSQL
def create_connection():
    conn = mysql.connector.connect(
        user = os.getenv("DB_USER"),
        host = os.getenv("DB_HOST"),
        port = int (os.getenv("DB_PORT", "3306")),
        password = os.getenv("DB_PASSWORD"),
        database =os.getenv("DB_NAME"),
    ) 
    return conn

def createOpenAI_client():
    # OpenAI
    openai_key= os.getenv("OPENAI_API_KEY")
    client = OpenAI(api_key = openai_key)
    chosen_model = "gpt-5.5"

    return client, chosen_model

def get_schema_text():
    return """
    user:
        user_id, first_name, last_name, email

    task: task_id, user_id, title, priority, deadline, estimated_duration, status

    fixed_block: 
    block_id, user_id, title, start_datetime, end_datetime, recurrence_type, recurrence_rule   

    schedule_entry: 
        schedule_entry_id, user_id, task_id, block_id,
        start_datetime, end_datetime, is_locked

    time_entry: 
        time_entry_id, task_id, start_datetime, end_datetime, duration_minutes     
    """


def build_sql_prompt(question, schema):
    return f"""
    Can you convert this question into MySQL query statements? 

    Database schema: 
    {schema}

    User Question: 
    {question}

    Return only the SQL statement. 
    """


def getOpenAIResponse(client, model,prompt):
    response = client.responses.create(
        model = model,
        input = prompt
    )
    return response.output_text


def execute_sql(conn, sql_query):
    cursor = conn.cursor()
    cursor.execute(sql_query)
    rows = cursor.fetchall()
    cursor.close()   
    return rows

def main():
    conn = create_connection()
    client,model = createOpenAI_client()

    schema = get_schema_text()
    question = input("Ask a question: ")
    prompt = build_sql_prompt(question, schema)
    sql = getOpenAIResponse(client, model,prompt)

    rows = execute_sql(conn, sql)
    print(rows)
    conn.close()


if __name__ == "__main__":
    main()   





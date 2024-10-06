
############# Mehmet Egehan Pala 31089 CS306 Project Phase 3 ##############




import mysql.connector
from mysql.connector import Error
from mysql.connector import errorcode


def create_connection(host, username, password, database):
    try:
        cnx = mysql.connector.connect(
            host=host,
            user=username,
            password=password,
            database=database
        )
        print("Connection established with the database")
        return cnx
    except Error as err:
        if err.errno == mysql.connector.errorcode.ER_ACCESS_DENIED_ERROR:
            print("Something is wrong with your user name or password")
        elif err.errno == mysql.connector.errorcode.ER_BAD_DB_ERROR:
            print("Database does not exist")
        else:
            print(err)
        return None
    

# Read Operation
def read_Entitled_baggage (connection):
    query = "SELECT * FROM Entitled_baggage"
    cursor = connection.cursor(dictionary=True)
    try:
        cursor.execute(query)
        records = cursor.fetchall()
        for record in records:
            print(record)
    except Error as e:
        print(f"Error: {e}")
    finally:
        cursor.close()



def read_ticket(connection):
    query = "SELECT * FROM ticket"
    cursor = connection.cursor(dictionary=True)
    try:
        cursor.execute(query)
        records = cursor.fetchall()
        for record in records:
            print(record)
    except Error as e:
        print(f"Error: {e}")
    finally:
        cursor.close()



# Function to execute a query
def execute_query(connection, query, data=None):
    cursor = connection.cursor()
    try:
        if data:
            cursor.execute(query, data)
        else:
            cursor.execute(query)
        connection.commit()
        print("Query executed successfully")
    except Error as e:
        print(f"Error: {e}")
    finally:
        cursor.close()




# Insert Operation
def insert_ticket(connection, data):
    query = "INSERT INTO ticket (ticket_id,price,class) VALUES (%s,%i, %s)"
    execute_query(connection, query, data)



# Update Operation
def update_ticket(connection, ticket_id, new_class):
    query = "UPDATE ticket SET class = %s WHERE ticket_id = %s"
    data = (new_class, ticket_id)
    execute_query(connection, query, data)


# Delete Operation
def delete_ticket(connection, ticket_id):
    query = "DELETE FROM ticket WHERE ticket_id = %s"
    data = (ticket_id)
    execute_query(connection, query, data)


# Insert Operation
def insert_Entitled_baggage (connection, data):
    query = "INSERT INTO Entitled_baggage (ticket_id, baggage_id, weight, insurance) VALUES (%s, %s, %s, %s)"
    execute_query(connection, query, data)



def update_Entitled_baggage(connection, baggage_id, insurance=None, weight=None):
    # Initialize the base query and parameters
    base_query = "UPDATE Entitled_baggage SET"
    query_parts = []
    data = []

    # Add the insurance part to the query if provided
    if insurance is not None:
        query_parts.append(" insurance = %s")
        data.append(insurance)
    
    # Add the weight part to the query if provided
    if weight is not None:
        query_parts.append(" weight = %s")
        data.append(weight)
    
    # Combine the query parts and add the WHERE clause
    query = base_query + ",".join(query_parts) + " WHERE baggage_id = %s"
    data.append(baggage_id)

    # Execute the query with the constructed data
    execute_query(connection, query, data)



# Delete Operation
def delete_Entitled_baggage(connection, baggage_id):
    query = "DELETE FROM Entitled_baggage WHERE baggage_id = %s"
    data = (baggage_id)
    execute_query(connection, query, data)

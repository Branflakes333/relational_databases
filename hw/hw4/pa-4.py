import psycopg
import time
from typing import Callable, Union, Any, Dict
from user_input import *


def time_query(task: Union[str, Callable], fetch_results=True, **conn_params) -> Dict[str, Any]:
    """
    Time the execution of a SQL query or a Python function using a DB cursor.

    Parameters:
        task (str | function):
            - SQL query string, OR
            - a function that accepts a cursor and returns something.
        fetch_results (bool): Whether to fetch results if task is SQL.
        **conn_params: Connection parameters (host, dbname, user, password, port).

    Returns:
        dict: {
            "execution_time": float (seconds),
            "row_count": int | None,
            "rows": list | None,
            "function_result": Any | None
        }
    """
    # Connect using psycopg (updated from psycopg2)
    conn = psycopg.connect(
        host=conn_params.get("host"),
        dbname=conn_params.get("database"),
        user=conn_params.get("user"),
        password=conn_params.get("password"),
        port=conn_params.get("port"),
    )
    cur = conn.cursor()

    rows, row_count, func_result = [], None, None

    start_time = time.perf_counter()

    if isinstance(task, str):  # Case 1: SQL string
        cur.execute(task)
        if fetch_results:
            rows = cur.fetchall()
            row_count = len(rows)
    elif callable(task):       # Case 2: function pointer
        func_result = task(cur)  # Whatever the function returns, we capture
    else:
        raise ValueError(
            "task must be either a SQL string or a callable function")

    execution_time = time.perf_counter() - start_time

    cur.close()
    conn.close()

    return {
        "execution_time": execution_time,
        "row_count": row_count,
        "rows": rows if fetch_results and isinstance(task, str) else None,
        "function_result": func_result if callable(task) else None
    }


def time_function_with_connection(func: Callable, conn_params: Dict) -> Dict[str, Any]:
    """
    Helper function to time query functions that expect a connection object.
    """

    def wrapper(cursor):
        # Create a mock connection object that provides cursor access
        class MockConnection:
            def cursor(self):
                return MockCursor(cursor)

        class MockCursor:
            def __init__(self, cursor):
                self._cursor = cursor

            def execute(self, query):
                return self._cursor.execute(query)

            def fetchall(self):
                return self._cursor.fetchall()

            def __enter__(self):
                return self

            def __exit__(self, exc_type, exc_val, exc_tb):
                pass

        mock_conn = MockConnection()
        return func(mock_conn)

    return time_query(wrapper, **conn_params)


def execute_queries():
    # List of queries to time
    queries = [
        ("Q1", q1_customers_with_phone_prefix_1),
        ("Q2", q2_part_size_calculations),
        ("Q3", q3_order_price_categorization),
        ("Q4", q4_urgent_orders_timeframe),
        ("Q5", q5_customer_comment_analysis),
        ("Q6", q6_supplier_most_expensive_parts),
        ("Q7", q7_suppliers_multiple_parts),
    ]

    print("=" * 60)
    print("QUERY EXECUTION TIMING RESULTS")
    print("=" * 60)

    for query_name, query_func in queries:
        try:
            result = time_function_with_connection(query_func, conn_params)

            print(f"\n{query_name}:")
            print(f"  Execution Time: {result['execution_time']:.6f} seconds")
            if result['function_result']:
                print(f"  Rows Returned: {len(result['function_result'])}")
                # Show first 3 rows
                print(f"  Sample Results: {result['function_result'][:3]}...")
            print(f"  Status: ✓ Success")

        except Exception as e:
            print(f"\n{query_name}:")
            print(f"  Status: ✗ Error - {str(e)}")

    print("\n" + "=" * 60)

# Database Connection


def get_connection(self, connection_params):
    """
    Update with your own DB credentials before running.
    """
    return psycopg.connect(
        host=connection_params["host"],
        port=connection_params["port"],
        dbname=connection_params["database"],
        user=connection_params["user"],
        password=connection_params["password"]
    )

# =========================================================================================
# =========================================================================================
#               MODIFY ONLY BELOW THIS LINE
# =========================================================================================
# =========================================================================================

# Q1.	Find all customers whose phone numbers start with a prefix of '1'
# and format their account balance to 2 decimal places. Return only TOP 5 customers based on the decreasing order of the balance.
# Return: (customer_name, formatted_balance, phone_prefix) [10 points]


def q1_customers_with_phone_prefix_1(conn):
    # =========================================================================================
    #               ADD YOUR QUERY BELOW
    # =========================================================================================

    # =========================================================================================
    #               END QUERY
    # =========================================================================================
    with conn.cursor() as cursor:
        cursor.execute(query)
        return cursor.fetchall()


# Q2.	Find all distinct part sizes and calculate what the size would be if increased by 10%.
# Only include parts with size greater than 5. Return the results in the increasing order of the original size.
# Return: (original_size, increased_size) [10 points]
def q2_part_size_calculations(conn):
    # =========================================================================================
    #               ADD YOUR QUERY BELOW
    # =========================================================================================

    # =========================================================================================
    #               END QUERY
    # =========================================================================================
    with conn.cursor() as cursor:
        cursor.execute(query)
        return cursor.fetchall()


# Q3.	Categorize all orders based on their total price and priority.
# Create categories for price ranges and show order priority distribution.
# Return the results in the increasing order of order_priority followed by decreasing order of the total order_count.
#
# If totalprice >=300000 then the price_category is 'HIGH_VALUE'
# If totalprice >=150000 and totalprice <300000 then the price_category is 'MEDIUM_VALUE'
# If totalprice >=50000 and totalprice <150000 then the price_category is 'LOW_VALUE'
# If totalprice >0 and totalprice <50000 then the price_category is 'MINIMAL_VALUE'
# Else for all other totalprice the price_category is ‘ZERO_VALUE’
# Return: (order_priority, price_category, order_count) [20 points]
def q3_order_price_categorization(conn):
    # =========================================================================================
    #               ADD YOUR QUERY BELOW
    # =========================================================================================

    # =========================================================================================
    #               END QUERY
    # =========================================================================================

    with conn.cursor() as cursor:
        cursor.execute(query)
        return cursor.fetchall()


# Q4.	Find all orders placed between July 1, 1995 and December 31, 1995 with order priority '1-URGENT' or '2-HIGH'.
# Return the orders in the order of orderdate and orderpriority.
# Return: (orderkey, orderdate, order_priority, customer_name) [10 points]
def q4_urgent_orders_timeframe(conn):
    # =========================================================================================
    #               ADD YOUR QUERY BELOW
    # =========================================================================================

    # =========================================================================================
    #               END QUERY
    # =========================================================================================
    with conn.cursor() as cursor:
        cursor.execute(query)
        return cursor.fetchall()


# Q5.	Find top 10 customers by comment length and identify complaints.
# The complaint keywords are “complaint” or “problem”. Return results in the decreasing order of length of the comments.
# Return: (customer_name, comment_length, has_complaint) [10 points]
def q5_customer_comment_analysis(conn):
    # =========================================================================================
    #               ADD YOUR QUERY BELOW
    # =========================================================================================

    # =========================================================================================
    #               END QUERY
    # =========================================================================================
    with conn.cursor() as cursor:
        cursor.execute(query)
        return cursor.fetchall()


# Q6.	Find the most expensive part supplied by each supplier.
# Return suppliers in the decreasing order of supply cost.
# Return: (suppkey, supplier_name, partkey, part_name, max_supplycost) [20 points]
def q6_supplier_most_expensive_parts(conn):
    # =========================================================================================
    #               ADD YOUR QUERY BELOW
    # =========================================================================================

    # =========================================================================================
    #               END QUERY
    # =========================================================================================
    with conn.cursor() as cursor:
        cursor.execute(query)
        return cursor.fetchall()


# Q7.	Find suppliers who supply more than 5 different parts.
# Return suppliers in the decreasing order of number of parts supplied.
# Return: (suppkey, supplier_name, parts_supplied) [20 points]
def q7_suppliers_multiple_parts(conn):
    # =========================================================================================
    #               ADD YOUR QUERY BELOW
    # =========================================================================================

    # =========================================================================================
    #               END QUERY
    # =========================================================================================
    with conn.cursor() as cursor:
        cursor.execute(query)
        return cursor.fetchall()

# =========================================================================================
# =========================================================================================
#               DONT MODIFY BELOW THIS LINE
# =========================================================================================
# =========================================================================================


def get_queries():
    # List of queries to time
    queries = [
        ("Q1", q1_customers_with_phone_prefix_1),
        ("Q2", q2_part_size_calculations),
        ("Q3", q3_order_price_categorization),
        ("Q4", q4_urgent_orders_timeframe),
        ("Q5", q5_customer_comment_analysis),
        ("Q6", q6_supplier_most_expensive_parts),
        ("Q7", q7_suppliers_multiple_parts)
    ]
    return queries


def main():
    # Example runner with timing
    if __name__ == "__main__":

        # Connection parameters
        conn_params = {
            "host": user_host,
            "port": user_port,
            "database": user_database,
            "user": user_user,
            "password": user_password
        }

        queries = get_queries()
        print("=" * 60)
        print("QUERY EXECUTION TIMING RESULTS")
        print("=" * 60)

        for query_name, query_func in queries:
            try:
                result = time_function_with_connection(query_func, conn_params)

                print(f"\n{query_name}:")
                print(
                    f"  Execution Time: {result['execution_time']:.6f} seconds")
                if result['function_result']:
                    print(f"  Rows Returned: {len(result['function_result'])}")
                    # Show first 3 rows
                    print(
                        f"  Sample Results: {result['function_result'][:3]}...")
                print(f"  Status: ✓ Success")

            except Exception as e:
                print(f"\n{query_name}:")
                print(f"  Status: ✗ Error - {str(e)}")

        print("\n" + "=" * 60)


if __name__ == '__main__':
    main()

from google.cloud import bigquery
import logging
import os
import csv


CREDENTIALS_FILE_NAME = "credentials.json"
CURRENT_FOLDER = os.path.dirname(os.path.abspath(__file__))

log_file_path = os.path.join(CURRENT_FOLDER, "run_queries_case_1.log")
credentials_file_path = os.path.join(CURRENT_FOLDER, f"{CREDENTIALS_FILE_NAME}")

logging.basicConfig(
    level = logging.INFO,
    format = '%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers = [
        logging.FileHandler(log_file_path),
        logging.StreamHandler()
    ])

client = bigquery.Client.from_service_account_json(credentials_file_path)

def read_sql_file(filename: str) -> str:
    
    """
    Reads a SQL file filename and returns the content as a String.

    Returns None if an error occurs
    """

    try:
        logging.info(f"Reading query from {filename} file.")
        with open(os.path.join(CURRENT_FOLDER, f"{filename}"), 'r') as f:
            return f.read()
    except Exception as e: 
        logging.error(f"Error reading SQL file: {e}")
        return None

def write_output_to_csv(query_results: bigquery.job.QueryJob, csv_filename: str) -> bool:

    """
    Receives a query_results QueryJob and writes the output to csv_filename.

    Returns True if the execution was successful, False otherwise
    """

    if query_results:
        try:
            with open(os.path.join(CURRENT_FOLDER, f"{csv_filename}"), 'w', newline='', encoding='utf-8') as csvfile:
                writer = csv.writer(csvfile)

                header = [field.name for field in query_results.schema]
                writer.writerow(header)

                for row in query_results:
                    writer.writerow(row)

            logging.info(f"Query results written to {csv_filename}")
            return True
        except Exception as e:
            logging.error(f"Error writing to CSV: {e}")
            return False

def run_sql_query(sql_query: str, write_to_csv = False, csv_filename = None) -> bool:

    """
    Runs a SQL query sql_query. If write_to_csv boolean is True, writes the output
        to csv_filename

    Returns True if the execution was successful, False otherwise
    """

    try:
        r = client.query(sql_query)
        results = r.result()
        logging.info(f"Query ran successfully.")
        if write_to_csv:
            try:
                write_output_to_csv(results, csv_filename)
                return True
            except Exception as e:
                logging.error(f"Error writing query result to CSV: {e}")
                return False
        return True
    except Exception as e:
        logging.error(f"Error running the SQL query: {e}")
        return False


if __name__ == "__main__":

    # Creating the Tables

    query_create_tables = read_sql_file(os.path.join(CURRENT_FOLDER, "queries/create_tables_case1.sql"))
    run_sql_query(query_create_tables)

    # Populating them

    query_populate_tables = read_sql_file(os.path.join(CURRENT_FOLDER, "queries/populate_tables_case1.sql"))
    run_sql_query(query_populate_tables)

    # Answering the Case

    case1 = read_sql_file(os.path.join(CURRENT_FOLDER, "queries/answer_1_case_1.sql"))
    run_sql_query(case1, write_to_csv = True, csv_filename = "answer_1_case_1.csv")

    case2 = read_sql_file(os.path.join(CURRENT_FOLDER, "queries/answer_2_case_1.sql"))
    run_sql_query(case2, write_to_csv = True, csv_filename = "answer_2_case_1.csv")

    case3 = read_sql_file(os.path.join(CURRENT_FOLDER, "queries/populate_items_daily.sql"))
    run_sql_query(case3)

    call_procedure_query = read_sql_file(os.path.join(CURRENT_FOLDER, "queries/call_populate_items_daily.sql"))
    run_sql_query(call_procedure_query)
    
    run_sql_query("SELECT * FROM `mlcase-hassakura.case1.items_daily`", write_to_csv = True, csv_filename = "answer_3_case_1.csv")
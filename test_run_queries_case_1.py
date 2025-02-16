import pytest
from unittest.mock import Mock, patch, mock_open
import os
from run_queries_case1 import read_sql_file, write_output_to_csv, run_sql_query
from google.cloud import bigquery

CREDENTIALS_FILE_NAME = "credentials.json"
CURRENT_FOLDER = os.path.dirname(os.path.abspath(__file__))

PROJECT_ID = "mlcase-hassakura"
DATASET_ID = "case1"

mock_client = Mock(spec=bigquery.Client)

@pytest.fixture(scope="module")
def bigquery_client():

    """
    Creates a BigQuery client with credentials. It will be necessary for the tests that access the database.
    """

    return bigquery.Client.from_service_account_json(os.path.join(CURRENT_FOLDER, f"{CREDENTIALS_FILE_NAME}"))
    

@patch("builtins.open", new_callable = mock_open, read_data = "SELECT * FROM my_table;")
def test_read_sql_file_success(mock_file):

    filename = "test_query.sql"

    result = read_sql_file(filename)
    assert result == "SELECT * FROM my_table;"
    mock_file.assert_called_once_with(os.path.join(CURRENT_FOLDER, filename), 'r')

@patch("builtins.open", new_callable = mock_open)
@patch('csv.writer')
def test_write_output_to_csv_success(mock_writer, mock_file):

    query_results = Mock(spec=bigquery.job.QueryJob)
    query_results.schema = [
        bigquery.SchemaField("col_1", "STRING"),
        bigquery.SchemaField("col_2", "INTEGER")
    ]
    query_results.__iter__ = Mock(return_value=iter([
        ("value_1", 1),
        ("value_2", 2)
    ]))

    csv_filename = "test_output.csv"

    mock_csv_writer = Mock()
    mock_writer.return_value = mock_csv_writer

    result = write_output_to_csv(query_results, csv_filename)
    assert result

    mock_file.assert_called_once_with(os.path.join(CURRENT_FOLDER, csv_filename), 'w', newline = '', encoding = 'utf-8')
    mock_writer.assert_called_once_with(mock_file.return_value)  # Writer called
    mock_csv_writer.writerow.assert_any_call(["col_1", "col_2"])  # Header
    mock_csv_writer.writerow.assert_any_call(("value_1", 1))  # Check rows
    mock_csv_writer.writerow.assert_any_call(("value_2", 2))

def test_run_sql_query_success():

    """
    Test that the SQL command ran successfully, using the orders table.
    """

    sql_query = "SELECT * FROM `mlcase-hassakura.case1.orders`;"

    mock_client.query.return_value.result.return_value = Mock(spec = bigquery.job.QueryJob)
    result = run_sql_query(sql_query)
    assert result

def test_database_exists(bigquery_client):

    dataset = bigquery_client.get_dataset(f"{PROJECT_ID}.{DATASET_ID}")
    assert dataset.dataset_id == DATASET_ID

def test_tables_exist(bigquery_client):
    
    """
    Test if the tables exist in BigQuery. They are: customers, items, orders, categories, items_daily
    """

    table_names = ["customers", "items", "orders", "categories", "items_daily"]

    for table_id in table_names:
        table = bigquery_client.get_table(f"{PROJECT_ID}.{DATASET_ID}.{table_id}")
        assert table.table_id == table_id

def test_orders_item_quantity_data_validation(bigquery_client):

    """
    Test data validation for item quantity from orders table. You can create other checks if necessary.
    """

    query = """
        SELECT * FROM `mlcase-hassakura.case1.orders` WHERE item_quantity <= 0
    """

    query_job = bigquery_client.query(query)
    results = query_job.result()
    assert len(list(results)) == 0
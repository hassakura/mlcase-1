# Case 1 - SQL

## Credentials

Due to new Google Cloud policies, shared credentials in public repos are automatically disabled. To be able to query in the code, **DOWNLOAD the credentials.json file in [THIS LINK](https://drive.google.com/drive/u/0/folders/1RUpBViKoCOmAwgaNebg3rxVVx_SgJOUk) and place it in the script folder**

## Answers to the Case

The answers to the case are in the `create_tables.sql` and `answers_case.sql`, but to be able to actually create, populate and run the queries, we created a Python script which connects to a existing BigQuery project. For each task, there's a query in the `queries` folder that will be executed.

The code is zipped. Extract it to be able to run it.

## Code

### Creating a virtual environment

Prepare you environment by creating a virtualenv:

    python3 -m venv venv

Then you can add the environment binaries to you path running:

    source venv/bin/activate

To leave your venv, just run `deactivate`.

### Depedencies

After creating the venv, you should install the dependencies with:

    pip install -r requirements.txt

### Tests

To run the tests, use:

    pytest -v


### Running the script

Run the script with:

    python3 run_queries_case1.py 

The script should use a JSON file with the credentials to access the API, and they are in the **credentials.json** file.

It creates, populates and then generates CSVs with the answers for all 3 tasks in the case, using the data from BigQuery:

1. The answer will be in the `answer_1_case_1.csv` file, and the query that generated it is in `queries/answer_1_case_1.sql`.
2. The answer will be in the `answer_2_case_1.csv` file, and the query that generated it is in `queries/answer_2_case_1.sql`.
3. The answer will be in the `answer_3_case_1.csv` file, and the query that generated it is in `queries/populate_items_daily.sql`. The SQL file `queries/call_populate_items_daily.sql` simply calls the procedure, and the python script generates the output by selecting all the data in the `items_daily` table.

## Files

**credentials.json**: Credentials to access the BigQuery API. You can download it in [THIS LINK](https://drive.google.com/drive/u/0/folders/1RUpBViKoCOmAwgaNebg3rxVVx_SgJOUk)

There are extra files / folders:

1. **create_tables.sql**: Contains the DDL to create and populate the tables
2. **answers_case.sql**: Contains the SQL code for all 3 questions in the case.
3. **/queries**: Contains the separated queries to generate the answer to the problems, and also creates and populates the tables
   1. **create_tables_case1.sql**: Contain the CREATE TABLES and the schemas for the tables
   2. **populate_tables_case1.sql**: Contain the INSERTS for the tables
   3. **answer_1_case_1.sql**: Contain the SQL query for the first question
   4. **answer_2_case_1.sql**: Contain the SQL query for the second question
   5. **populate_items_daily.sql**: Contain the Procedure for the third question
   6. **call_populate_items_daily.sql**: Contain the call to the Procedure for the third question
4. **answer_x_case_1.csv**: 3 CSVs are generated with the results for the tasks.
5. **diagram/der.png**: Contains the `DER` as a image.
6. **diagram/der_diagram_generate.txt**: Contains the `DER` as a text, to be used in dbdiagram.io website to recreate the DER
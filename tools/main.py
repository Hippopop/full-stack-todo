"""(#process_check) To check the status of required processes!"""

from process_check import check_process_run_status
from port_check import is_port_open
from application_flow import run_application_process
from run_node_server import run_node_server
from asyncio import run
from sys import argv


if __name__ == "__main__":
    if len(argv) < 2:
        print("Please provide the (*name) of the Server Folder.")
        exit(0)

    SERVER_FOLDER_NAME = argv[1]

    XAMPP_PATH = "/Applications/XAMPP/xamppfiles/xampp"
    APACHE_PROCESS_NAME = "httpd"
    MYSQL_PROCESS_NAME = "mysqld"

    try:
        MYSQL_RUNNING = check_process_run_status(APACHE_PROCESS_NAME)
        APACHE_RUNNING = check_process_run_status(APACHE_PROCESS_NAME)
        if APACHE_RUNNING and MYSQL_RUNNING:
            print("Congratulations! Database is actively running on your device!")
        else:
            print("Ooopsies! Looks like the database isn't running.")
            run_application_process(XAMPP_PATH, APACHE_PROCESS_NAME, MYSQL_PROCESS_NAME)

    except Exception as error:
        print(f"Database setup raised an error : {error}")

    try:
        HOST = "localhost"
        PORT = 8080

        STATUS = is_port_open(HOST, PORT)
        if STATUS:
            print(f"Port {PORT} is occupied.")
        else:
            print(f"Port {PORT} is available. Attempting server run.")
            run(run_node_server(SERVER_FOLDER_NAME))
    except Exception as error:
        print(f"Running server raised an error : {error}")
        exit()

"""(#socket) Package that provides a socket to test connection with ports!"""
import socket


def is_port_open(host, port):
    """Checks if the port on the provided host is open or not!"""
    try:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as tester_socket:
            tester_socket.settimeout(5)
            tester_socket.connect((host, port))
            return True
    except (ConnectionRefusedError, socket.timeout) as error:
        return False

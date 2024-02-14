"""
(#platform) Module that provides the method to check the current system information!
(#subprocess) Module that provides the method to run commands in the terminal and get the response!
"""
import platform
import subprocess

MAC_SYSTEM_NAME = "Darwin"
WINDOWS_SYSTEM_NAME = "Windows"


def is_process_running_macos(process_name):
    """Function checking if [process_name] process, is currently running. (*Only for MacOs)"""
    try:
        output = subprocess.check_output(["pgrep", process_name], text=True)
        if output.strip():
            return True
        return False
    except subprocess.CalledProcessError as error:
        return False


def is_process_running_windows(process_name):
    """Function checking if [process_name] process, is currently running. (*Only for Windows)"""
    try:
        output = subprocess.check_output(
            ["tasklist", "/FI", f"IMAGENAME eq {process_name}.exe"], text=True
        )
        if process_name in output:
            return True
        return False
    except subprocess.CalledProcessError as error:
        return False


def check_process_run_status(process_name):
    """
    Function checking if [process_name] process, is currently running.
    (*Works in both, macos and windows!)
    """
    current_system_name = platform.system()
    if current_system_name == MAC_SYSTEM_NAME:
        return is_process_running_macos(process_name)
    if current_system_name == WINDOWS_SYSTEM_NAME:
        return is_process_running_windows(process_name)
    raise OSError()

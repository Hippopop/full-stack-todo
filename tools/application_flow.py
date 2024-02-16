import platform
import functools
import subprocess

MAC_SYSTEM_NAME = "Darwin"
WINDOWS_SYSTEM_NAME = "Windows"


def start_process_windows(path, *processes):
    try:
        subprocess.Popen(
            [path, "start", *list(*processes)],
            shell=True,
        )

        print("App services have been started.")
    except Exception as e:
        print(f"Failed to start app services: {str(e)}")


def stop_process_windows(path, *processes):
    try:
        subprocess.Popen(
            [path, "stop", *list(*processes)],
            shell=True,
        )

        print("App services have been stop!.")
    except Exception as e:
        print(f"Failed to stop app services: {str(e)}")


def start_process_macos(path, *processes):
    try:
        PROCESS_LIST = functools.reduce(lambda x, y: x + " " + y, *processes)
        subprocess.Popen(
            f"{path} start {PROCESS_LIST}".strip(),
            shell=True,
        )
        print("App services have been started.")
    except Exception as e:
        print(f"Failed to start app services: {str(e)}")


def stop_process_macos(path, *processes):
    try:
        PROCESS_LIST = functools.reduce(lambda x, y: x + " " + y, *processes)
        subprocess.Popen(
            f"{path} stop {PROCESS_LIST}".strip(),
            shell=True,
        )
        print("App services have been stop!.")
    except Exception as e:
        print(f"Failed to stop app services: {str(e)}")


def run_application_process(path, *processes):
    if platform.system() == MAC_SYSTEM_NAME:
        start_process_macos(path, processes)
    elif platform.system() == WINDOWS_SYSTEM_NAME:
        start_process_windows(path, processes)
    else:
        raise OSError()


def stop_application_process(path, *processes):
    if platform.system() == MAC_SYSTEM_NAME:
        stop_process_macos(path, processes)
    elif platform.system() == WINDOWS_SYSTEM_NAME:
        stop_process_windows(path, processes)
    else:
        raise OSError()


""" 
import subprocess

def start_xampp_services():
    try:
        # Replace this with the correct path to your XAMPP installation
        xampp_control_path = "C:\\xampp"

        # Start Apache
        subprocess.Popen([xampp_control_path + "\\apache_start.bat"], shell=True)

        # Start MySQL
        subprocess.Popen([xampp_control_path + "\\mysql_start.bat"], shell=True)

        print("XAMPP services have been started.")
    except Exception as e:
        print(f"Failed to start XAMPP services: {str(e)}")

if __name__ == "__main__":
    start_xampp_services()
 """

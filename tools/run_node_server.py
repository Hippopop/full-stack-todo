import os
import subprocess
import asyncio


async def run_node_server(*folder_names):
    current_directory = os.getcwd()
    parentPath = os.path.dirname(current_directory)
    list_of_folders = [
        file
        for file in os.listdir(parentPath)
        if (os.path.isdir(os.path.join(parentPath, file)))
    ]

    for folder in list_of_folders:
        if folder in folder_names:
            if os.path.isfile(os.path.join(parentPath, folder, "package.json")):
                NWD = os.path.join(parentPath, folder)
                subprocess.run(
                    ["npm", "run", "dev"],
                    cwd=NWD,
                )
            else:
                print("Server doesn't have the required files to run.")
                subprocess.run(["npm", "i"], cwd=os.path.join(parentPath, folder))
        else:
            print(f"{folder} is not the server.")

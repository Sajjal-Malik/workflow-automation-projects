import os
import shutil
import platform

def clear_directory(folder_path, folder_name):
    """Deletes all files in the target directory recursively, leaving folders intact."""
    print(f"--- Cleaning {folder_name}: {folder_path} ---")

    if not folder_path or not os.path.exists(folder_path):
        print(f"Directory not found: {folder_path}\n")
        return

    deleted_count = 0
    failed_count = 0

    for root, dirs, files in os.walk(folder_path):
        for file in files:
            file_path = os.path.join(root, file)
            try:
                os.unlink(file_path)
                deleted_count += 1
            except (PermissionError, OSError):
                failed_count += 1

    print(f"Successfully deleted {deleted_count} files.")
    if failed_count > 0:
        print(f"Skipped {failed_count} locked files.")
    print("\n" + "="*50 + "\n")

def cleanup_windows_data():
    """Handles Windows-specific directories (Temp and Prefetch)."""
    # User Temp
    user_temp = os.environ.get('TEMP')
    clear_directory(user_temp, "User Temp Folder")

    system_root = os.environ.get('SystemRoot', 'C:\\Windows')

    # Windows Temp
    windows_temp = os.path.join(system_root, 'Temp')
    clear_directory(windows_temp, "Windows Temp Folder")

    # Windows Prefetch
    prefetch_path = os.path.join(system_root, 'Prefetch')
    clear_directory(prefetch_path, "Prefetch Folder")


def cleanup_linux_data():
    """Handles Linux-specific directories."""
    # Standard Linux Temp
    clear_directory('/tmp', "Linux /tmp Folder")

    # Variable Linux Temp (Optional, requires sudo for some files)
    clear_directory('/var/tmp', "Linux /var/tmp Folder")


if __name__ == "__main__":
    current_os = platform.system()

    if current_os == "Windows":
        cleanup_windows_data()
    elif current_os == "Linux" or current_os == "Darwin": # Darwin is macOS
        cleanup_linux_data()
    else:
        print(f"Unsupported Operating System: {current_os}")

import subprocess
import datetime
import os

def backup_mysql_db(user, password, db_name, backup_dir="backups", mysqldump_path="mysqldump"):
    # Ensure backup directory exists
    os.makedirs(backup_dir, exist_ok=True)
    # Create a filename with timestamp
    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_file = os.path.join(backup_dir, f"{db_name}_backup_{timestamp}.sql")
    # Run mysqldump
    cmd = [
        mysqldump_path,  # Use the provided path or just 'mysqldump' if in PATH
        "--no-tablespaces",  # Add this option to avoid PROCESS privilege error
        "-u", user,
        f"-p{password}",
        db_name
    ]
    with open(backup_file, "w", encoding="utf-8") as f:
        subprocess.run(cmd, stdout=f, check=True)
    print(f"Backup completed: {backup_file}")

if __name__ == "__main__":
    backup_mysql_db(
        user="admin_user",
        password="admin123",
        db_name="CinemaDBcc",
        mysqldump_path=r"E:\sql\mysqldump.exe"  # Use your full path here
    )

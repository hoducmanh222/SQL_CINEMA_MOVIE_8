import os

# Database connection configuration
DB_CONFIG = {
    'host': os.environ.get('DB_HOST', '127.0.0.1'),
    'user': os.environ.get('DB_USER', 'admin_user'),
    'password': os.environ.get('DB_PASSWORD', 'admin123'),
    'database': os.environ.get('DB_NAME', 'CinemaDBcc'),
    'port': int(os.environ.get('DB_PORT', 3306))
}

# Application settings
APP_TITLE = "Cinema Management System"
APP_WIDTH = 1024
APP_HEIGHT = 768

import mysql.connector
from mysql.connector import Error, pooling
import sys
import os

# Add parent directory to path so we can import config
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from config import DB_CONFIG

class DatabaseConnector:
    # Use a class-level pool to share across instances
    _pool = None

    def __init__(self):
        self.connection = None
        self.get_connection()
        
    def get_connection(self):
        """Get a pooled connection or create a new pool if needed."""
        if DatabaseConnector._pool is None:
            try:
                # Increase pool size to 20 (or higher if needed)
                DatabaseConnector._pool = pooling.MySQLConnectionPool(
                    pool_name="mypool",
                    pool_size=20,
                    **DB_CONFIG
                )
            except Error as e:
                print(f"Error creating connection pool: {e}")
                DatabaseConnector._pool = None
        try:
            self.connection = DatabaseConnector._pool.get_connection()
            self.connection.autocommit = True
            return self.connection
        except Error as e:
            print(f"Error getting pooled connection: {e}")
            # Fallback: try direct connection if pool is exhausted
            try:
                self.connection = mysql.connector.connect(**DB_CONFIG)
                self.connection.autocommit = True
                print("Fallback: created direct connection (no pool)")
                return self.connection
            except Error as e2:
                print(f"Error creating direct connection: {e2}")
                self.connection = None
                return None

    def connect(self):
        """Legacy connect method for compatibility."""
        return self.get_connection()
    
    def execute_query(self, query, params=None):
        cursor = None
        try:
            # Ensure connection is active
            if not self.connection or not self.connection.is_connected():
                self.get_connection()
            if not self.connection:
                raise Exception("Database connection is not available.")
            cursor = self.connection.cursor(dictionary=True, buffered=True)
            if params:
                cursor.execute(query, params)
            else:
                cursor.execute(query)
            # Commit for modifying queries
            if query.strip().upper().startswith(('INSERT', 'UPDATE', 'DELETE', 'CALL', 'SET')):
                # autocommit is True, but call commit for compatibility
                self.connection.commit()
                if query.strip().upper().startswith(('INSERT', 'UPDATE', 'DELETE')):
                    return cursor.lastrowid
                elif query.strip().upper().startswith('CALL'):
                    try:
                        return cursor.fetchall()
                    except:
                        return cursor.rowcount
            else:
                return cursor.fetchall()
        except Error as e:
            print(f"Error executing query: {e}")
            if self.connection:
                try:
                    self.connection.rollback()
                except:
                    pass
            return None
        finally:
            if cursor:
                try:
                    cursor.close()
                except:
                    pass

    def call_procedure(self, proc_name, params=None):
        cursor = None
        try:
            if not self.connection or not self.connection.is_connected():
                self.get_connection()
            cursor = self.connection.cursor(dictionary=True, buffered=True)
            if params:
                cursor.callproc(proc_name, params)
            else:
                cursor.callproc(proc_name)
            results = []
            for result in cursor.stored_results():
                results.extend(result.fetchall())
            self.connection.commit()
            return results
        except Error as e:
            print(f"Error calling procedure: {e}")
            return None
        finally:
            if cursor:
                cursor.close()

    def refresh_connection(self):
        """Force reconnection to the database and pool."""
        try:
            if self.connection:
                if self.connection.is_connected():
                    self.connection.close()
            self.get_connection()
            return True
        except Error as e:
            print(f"Error refreshing connection: {e}")
            return False

    def close(self):
        if self.connection and self.connection.is_connected():
            self.connection.close()

    # Optional: utility to create indexes for optimization
    def create_index(self, table, index_name, columns):
        """Create an index if not exists (manual call)."""
        try:
            cols = ", ".join(columns)
            query = f"CREATE INDEX IF NOT EXISTS {index_name} ON {table} ({cols})"
            self.execute_query(query)
        except Exception as e:
            print(f"Error creating index: {e}")

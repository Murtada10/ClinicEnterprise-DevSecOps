import os
import pyodbc
from dotenv import load_dotenv

# Force load the .env file so Python can see your credentials
load_dotenv(override=True)

class DatabaseConnection:
    def __init__(self):
        # We use os.getenv to pull the values securely from the .env file.
        # If a value is missing, it defaults to None (or the provided fallback).
        self.server = os.getenv("DB_SERVER")
        self.database = os.getenv("DB_NAME")
        self.user = os.getenv("DB_USER")
        self.password = os.getenv("DB_PASS")
        self.encrypt = os.getenv("DB_ENCRYPT","yes")
        self.trust_cert = os.getenv("DB_TRUST_CERT","yes")

        # We start with no active connection
        self.connection = None

    def get_connection(self):
        """Establishes the SQL Server connection using pyodbc if it doesn't exist."""
        if self.connection is None:
            # We use f-string to inject our secure variable into the connection string
            conn_str = (
                "DRIVER={ODBC Driver 18 for SQL Server};"
                f"SERVER={self.server};"
                f"DATABASE={self.database};"
                f"UID={self.user};"
                f"PWD={self.password};"
                f"Encrypt={self.encrypt};"
                f"TrustServerCertificate={self.trust_cert};"
            )
            # Actually connect to the database
            self.connection = pyodbc.connect(conn_str)
        
        return self.connection

    def close(self):
        """Safely closes the connection to prevent connection pool exhaustion."""
        if self.connection is not None:
            self.connection.close()
            self.connection = None

    # Context Manager Magic for the "with" statement
    def __enter__(self):
        self.get_connection()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.close()
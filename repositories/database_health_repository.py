class DatabaseHealthRepository:
    def __init__(self, db_connection):
        self.db = db_connection

    def get_connection_stats(self) -> dict:
        query ="""
            SELECT 
            COUNT(*) AS total_sessions,
            SUM(CASE WHEN status = 'running' THEN 1 ELSE 0 END) AS active_sessions
            FROM sys.dm_exec_sessions
            WHERE is_user_process = 1
        """
        cursor = self.db.get_cursor()
        cursor.execute(query)
        row = cursor.fetchone()

        return {
            "total_sessions": row[0] if row else 0,
            "active_sessions": row[1] if row and row[1] is not None else 0
        }

   
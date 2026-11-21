# HLD

```text
[ SQL Server 2022 ]  <-- The Database (External)
       â†‘ â†“
       â†‘ â†“ (pyodbc secure connection)
       â†‘ â†“
[ Tier 2: Infrastructure ] 
  File: infrastructure/database.py
  Job:  Manages the pyodbc connection, loads .env secrets, and handles Context Manager (__enter__/__exit__).
  Rule: Knows NOTHING about patients or business logic. Only knows how to connect to SQL.
       â†‘ â†“
       â†‘ â†“ (passes raw database connection)
       â†‘ â†“
[ Tier 3: Repositories ]
  File: repositories/patient_repository.py
  Job:  Holds the SQL queries. Uses the injected connection to execute SELECT statements safely (?).
  Rule: Knows SQL and knows how to fetch a Patient, but does NOT validate the data itself.
       â†‘ â†“
       â†‘ â†“ (passes raw SQL tuple row)
       â†‘ â†“
[ Tier 1: Domain Models ]
  File: models/patient.py
  Job:  Validates the raw data using Pydantic. Enforces types, calculates age, masks phone numbers.
  Rule: Knows NOTHING about SQL or connections. Only cares about data rules and GDPR.
       â†‘ â†“
       â†‘ â†“ (passes clean, validated Patient object)
       â†‘ â†“
[ Entry Point / Runner ]
  File: main.py
  Job:  The boss. It orchestrates everything. It opens the connection, gives it to the repository, asks for a patient, and prints the result.
```
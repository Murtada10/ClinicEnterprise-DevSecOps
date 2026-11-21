# FullApplicationFlow

```text
Incoming Request / Trigger
       â”‚
       â”œâ”€â”€â”€ [Path A: API Requests] â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”
       â”‚                                                                    â–¼
       â”‚    1. Security Gate (`api/security.py`)
       â”‚       - `load_dotenv()` & `API_KEY` check (`verify_api_key`)
       â”‚       - Validates `X-API-Key` header (401 if invalid/missing)
       â”‚                                                                    â”‚
       â”‚                                                                    â–¼
       â”‚    2. Route Handler (`api/main.py`)
       â”‚       - Receives endpoint call (e.g., `/health`, `/health/db`,
       â”‚         `/dbre/health`, `/de/trigger-parquet-export`,
       â”‚         `/doctors/{doctor_id}`, `/appointments/{appointment_id}`)
       â”‚       - Validates path/query/body inputs & passes dependencies
       â”‚                                                                    â”‚
       â”œâ”€â”€â”€ [Path B: Ingestion / Background Jobs] â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¤
       â”‚       - `ingestion/external_doctor_api_client.py`                 â”‚
       â”‚       - `ingestion/appointment_parquet_export...`                 â”‚
       â”‚                                                                    â–¼
       â”‚    3. Service Layer (`services/`)
       â”‚       - Orchestrates business rules & workflows (e.g., `clinic_service.py`)
       â”‚       - Coordinates repositories, data shaping, and export steps
       â”‚                                                                    â”‚
       â”‚                                                                    â–¼
       â”‚    4. Data & Infrastructure Layer (`repositories/`, `models/`, `infrastructure/`)
       â”‚       - `repositories/` executes DB queries / health stats
       â”‚         (e.g., `database_health_repository.py`)
       â”‚       - `models/` defines schemas / data structures
       â”‚       - `infrastructure/` manages DB connections / low-level adapters
       â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
```
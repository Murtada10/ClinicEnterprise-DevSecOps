# FullApplicationFlow

```text
Incoming Request / Trigger
       │
       ├─── [Path A: API Requests] ─────────────────────────────────────────┐
       │                                                                    ▼
       │    1. Security Gate (`api/security.py`)
       │       - `load_dotenv()` & `API_KEY` check (`verify_api_key`)
       │       - Validates `X-API-Key` header (401 if invalid/missing)
       │                                                                    │
       │                                                                    ▼
       │    2. Route Handler (`api/main.py`)
       │       - Receives endpoint call (e.g., `/health`, `/health/db`,
       │         `/dbre/health`, `/de/trigger-parquet-export`,
       │         `/doctors/{doctor_id}`, `/appointments/{appointment_id}`)
       │       - Validates path/query/body inputs & passes dependencies
       │                                                                    │
       ├─── [Path B: Ingestion / Background Jobs] ──────────────────────────┤
       │       - `ingestion/external_doctor_api_client.py`                 │
       │       - `ingestion/appointment_parquet_export...`                 │
       │                                                                    ▼
       │    3. Service Layer (`services/`)
       │       - Orchestrates business rules & workflows (e.g., `clinic_service.py`)
       │       - Coordinates repositories, data shaping, and export steps
       │                                                                    │
       │                                                                    ▼
       │    4. Data & Infrastructure Layer (`repositories/`, `models/`, `infrastructure/`)
       │       - `repositories/` executes DB queries / health stats
       │         (e.g., `database_health_repository.py`)
       │       - `models/` defines schemas / data structures
       │       - `infrastructure/` manages DB connections / low-level adapters
       └────────────────────────────────────────────────────────────────────┘
```

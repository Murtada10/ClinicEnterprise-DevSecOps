# ClinicEnterprise-DevSecOps

> **Project Status:** `Active Development (Phase 1 — Core Pipeline & API)`  
> An end-to-end **Database Reliability Engineering (DBRE)** and **Secure Data Engineering Platform** blueprint, transitioning a Python extraction engine into a 7-tier, DevSecOps-hardened, and highly available data ecosystem.

---

## 1. Executive Overview
**ClinicEnterprise** is a personal enterprise-grade engineering platform demonstrating clean Object-Oriented architecture, defense-in-depth data security, and production database reliability across two structured phases:
- **Phase 1 (Current — Nov 2026):** 7-Tier Python 3.12 OOP Data Pipeline on SQL Server with Pydantic boundary validation, GDPR PII masking, Dependency Injection, parameterized repositories, structured logging, automated `pytest` suites, `FastAPI` presentation/DBRE endpoints, and planned AES encryption, Parquet ingestion, and SQL Server TDE.
- **Phase 2 (Planned — Dec 2026 – Jan 2027):** Migration to Linux-native **PostgreSQL 16/17 High Availability** (3-node Patroni cluster, HAProxy, PgBouncer), Point-in-Time Recovery (`pgBackRest` + MinIO S3), and full observability (`Prometheus`, `Grafana`, `Loki`).

---

## 2. Target Architecture

```mermaid
flowchart TD
    subgraph App ["Phase 1: 7-Tier Python 3.12 Engine"]
        direction LR
        T1["Tier 1: Domain<br/>Pydantic & GDPR"]
        T2["Tier 2-3: Infra & Repo<br/>DI & Parameterized SQL"]
        T3["Tier 4-5: Services & API<br/>Logging, FastAPI & Pytest"]
        T4["Tier 6-7: Lake & Control<br/>Parquet & DBRE API"]
        T1 --> T2 --> T3 --> T4
    end

    subgraph DB ["Data & Reliability Layer"]
        direction LR
        SQL[("Phase 1: SQL Server<br/>DMVs & Planned TDE")]
        PG[("Phase 2: PostgreSQL HA<br/>Patroni + PgBouncer")]
    end

    subgraph Ops ["Observability & DR (Phase 2)"]
        direction LR
        MON["Prometheus & Grafana<br/>+ Loki Logs"]
        DR["pgBackRest PITR<br/>MinIO S3"]
    end

    T2 --> SQL
    SQL -.->|Phase 2 Migration| PG
    PG --> MON
    PG --> DR
```

---

## 3. Repository Structure

```text
ClinicEnterprise-DevSecOps/
├── api/
│   └── main.py                     # FastAPI app, DI factory & endpoints (/health, /doctors/{id}, /appointments/{id}, /health/db)
├── infrastructure/
│   └── database.py                 # SQL Server connection lifecycle via pyodbc & environment config
├── models/
│   ├── patient.py                  # Pydantic domain model & masked_phone() PII protection
│   ├── doctor.py                   # Doctor domain model & active-status validation
│   ├── appointment.py              # Appointment domain model & object composition
│   └── invoice.py                  # Invoice domain model & boundary rules
├── repositories/
│   ├── patient_repository.py         # Parameterized queries (?) & DI
│   ├── doctor_repository.py          # Doctor data access
│   ├── appointment_repository.py     # Relational joins & incremental extraction
│   └── database_health_repository.py # SQL Server DMV health telemetry queries
├── services/
│   └── clinic_service.py           # Business rules, DI coordination & GDPR-safe structured logging
├── tests/
│   ├── test_clinic_service.py      # 8 unit tests (MagicMock & caplog PII leak checks)
│   └── test_api.py                 # 6 FastAPI TestClient endpoint tests (14/14 total passing)
├── main.py                         # CLI pipeline runner
├── .env.example                    # Safe environment variable template
├── .gitignore                      # Excludes .env, virtual envs, caches & artifacts
├── requirements.txt                # Project runtime & test dependencies
└── README.md
```

---

## 4. Implementation Roadmap & Progress

### Phase 1: 7-Tier Core Python Pipeline (SQL Server)
- [x] **Tier 1 — Domain Models:** `Patient`, `Doctor`, `Appointment`, and `Invoice` Pydantic models with strict boundary validation, Object Composition, and `masked_phone()` PII protection.
- [x] **Tier 2 — Infrastructure:** SQL Server connectivity via `pyodbc` and `.env` credential isolation (via `.gitignore` and `.env.example`).
- [x] **Tier 3 — Repositories:** `PatientRepository`, `DoctorRepository`, `AppointmentRepository`, and `DatabaseHealthRepository` (SQL Server DMVs) using Dependency Injection and 100% parameterized queries (`?`).
- [x] **Tier 4 — Services & Security:** `ClinicService` business rules and GDPR-safe structured `logging` (verified zero PII leakage in `caplog` tests); AES envelope encryption and connection-string masking hardening planned next.
- [x] **Tier 5 — Automated Testing (14/14 Passing):** `pytest` suite covering `8` service unit tests (`MagicMock` + `caplog`) and `6` FastAPI `TestClient` tests. *(Semgrep SAST scan pending).*
- [ ] **Tier 6 — Data Engineering Ingestion:** Partitioned `.parquet` export (`Pandas`/`PyArrow`) with PII phone hashing and external API client (`verify=True`, `timeout=10`).
- [x] **Tier 7 — DBRE Control Plane (In Progress):** `FastAPI` foundation live (`/health`, `/doctors/{id}`, `/appointments/{id}`, `/health/db`); `X-API-Key` validation (`secrets.compare_digest`), `127.0.0.1` binding, and `/de/trigger-parquet-export` pending.
- [ ] **Storage Encryption:** SQL Server Transparent Data Encryption (TDE / AES-256 at rest) and least-privilege DB role hardening.

### Phase 2: Linux & PostgreSQL HA Architecture
- [ ] **Linux Migration:** Full execution migration to Ubuntu Linux (WSL2) under a non-root user with `chmod 600 .env` and `chmod 700` data directories.
- [ ] **PostgreSQL HA Cluster:** PostgreSQL 16/17 + 3-node **Patroni** cluster + **HAProxy** + **PgBouncer** transaction pooling.
- [ ] **Disaster Recovery:** Automated Point-in-Time Recovery (PITR) using **pgBackRest** to local **MinIO (S3)**.
- [ ] **Observability & Network Security:** **Prometheus/Grafana/Loki** telemetry stack + mandatory **SSL/TLS** and **SCRAM-SHA-256** in `pg_hba.conf`.

---

## 5. Core Tech Stack
- **Backend & Data:** Python, Pydantic, FastAPI, Uvicorn, Pandas, PyArrow (Parquet), `pyodbc` / `psycopg3`
- **Testing & Security:** `pytest`, `unittest.mock`, `Semgrep` (SAST), GDPR PII Masking, AES Encryption, SQL Server TDE
- **Databases & HA:** SQL Server (DMVs, TDE), PostgreSQL 16/17, Patroni, HAProxy, PgBouncer, `pgBackRest`, MinIO (S3)
- **Observability & OS:** Prometheus, Grafana, Promtail / Loki, Ubuntu Linux (WSL2)
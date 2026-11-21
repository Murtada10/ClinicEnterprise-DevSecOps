
# Security & DevSecOps Hardening Architecture

This document outlines the defense-in-depth security controls enforced across all 7 tiers of **ClinicEnterprise-DevSecOps**, aligning with **GDPR / HIPAA** privacy principles and the **Principle of Least Privilege**.

---

## 1. Secrets & Configuration Hygiene
- **Environment Isolation:** All database credentials, API keys, and connection parameters are isolated in `.env` (excluded via `.gitignore`) with a sanitized `.env.example` template committed to source control.
- **Host File Permissions (Linux / WSL2):** Enforced strict ownership and permission boundaries (`chmod 600 .env` and `chmod 700` on local staging/Parquet directories) running under a dedicated non-root service account.
- **Secret Scanning:** Pre-commit hygiene (`GitLeaks`) prevents accidental exposure of tokens, passwords, or connection strings in commit history.

## 2. Database Security & Least Privilege (SQL Server)
- **Dedicated Service Login (`db_clinic_etl_worker`):** Replaced elevated `db_owner` privileges with a scoped database role restricted strictly to `SELECT`, `INSERT`, and `VIEW SERVER STATE` (for DBRE health diagnostics).
- **Transport Encryption:** Parameterized `DB_ENCRYPT` and `DB_TRUST_CERT` flags inside the `pyodbc` connection manager to prevent plaintext credential or clinical data transmission.
- **Resource Lifecycle Safety:** Implemented deterministic context managers (`__enter__` / `__exit__`) and explicit transaction boundaries (`commit()` / `rollback()`) to prevent connection leaks and partial writes.
- **SQL Injection Prevention:** 100% parameterized queries (`?` placeholders) across `PatientRepository`, `DoctorRepository`, `AppointmentRepository`, and `DatabaseHealthRepository`—zero string interpolation (`f-string`).

## 3. Application & Schema Validation (Pydantic v2)
- **Boundary Enforcement:** Strict type checking, string length constraints, temporal validation, and positive identifier guards (`Field(gt=0)`) reject malformed payloads before reaching the repository layer.
- **PII / GDPR Data Masking:** Sensitive patient attributes (`PhoneNumber`, `Email`, raw names) are masked via model helpers (e.g., `masked_phone()`) and hashed prior to analytical `.parquet` export.
- **GDPR-Safe Structured Logging:** Replaced `print()` statements with Python's `logging` module, recording opaque surrogate keys (`patient_id`, `doctor_id`) while masking connection strings and personally identifiable information.

## 4. API & External Integration Security
- **API Key Authentication:** Protected FastAPI endpoints (`/dbre/health`, `/de/trigger-parquet-export`) with `X-API-Key` verification using constant-time comparison (`secrets.compare_digest`) to mitigate timing attacks.
- **Network Binding:** Bound Uvicorn to localhost (`127.0.0.1`) for internal cron/orchestrator invocation without unintended public exposure.
- **Outbound TLS Verification:** Enforced `verify=True` and strict request timeouts (`timeout=10`) on external REST integrations (`ExternalDoctorApiClient`).

## 5. Automated Verification (CI/CD)
- **Continuous Testing:** GitHub Actions executes the `pytest` suite on every push to `main` using isolated mock repositories to verify validation rules, PII masking, and business logic without touching production infrastructure.

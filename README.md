# ClinicEnterprise-DevSecOps

# ClinicEnterprise System: Secure DBRE & Data Engineering Platform

## Architecture Overview
End-to-end blueprint transitioning a relational extraction workflow into a 7-tier, object-oriented Python data platform built with Dependency Injection, Pydantic boundary validation, defense-in-depth DevSecOps controls, and Parquet data lake ingestion.

## Phase 1: 7-Tier Core Python Pipeline (SQL Server)
* **Tier 1 — Domain Models:** Strict Pydantic type boundaries and baseline GDPR PII masking.
* **Tier 2 — Infrastructure:** Context-managed database connection lifecycle (`__enter__`/`__exit__`) and `.env` credential isolation.
* **Tier 3 — Repositories:** 100% parameterized queries (`?`), Object Composition for nested entities, and DMV health telemetry extraction.
* **Tier 4 — Services:** Clinical business rule enforcement, GDPR-safe structured logging, and Application-Level AES envelope encryption.
* **Tier 5 — Quality & Security:** Automated unit testing (`pytest`) and Static Application Security Testing (SAST).
* **Tier 6 — Data Engineering Ingestion:** Partitioned `.parquet` exports via Pandas/PyArrow and external REST API ingestion.
* **Tier 7 — DBRE Control Plane:** Headless FastAPI service exposing pipeline triggers and database health telemetry.
* **Storage Security:** SQL Server Transparent Data Encryption (TDE) securing database files at rest.

## Phase 2 Roadmap: Linux & PostgreSQL High Availability
* **Native Execution:** Migrating pipeline execution to WSL2 Ubuntu Linux.
* **Core Engine & Pooling:** PostgreSQL 16/17 with PgBouncer transaction-level connection pooling.
* **High Availability & DR:** 3-node Patroni cluster with HAProxy load balancing, pgBackRest PITR backups, and Prometheus/Grafana observability.

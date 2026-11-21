import hashlib
import logging
import pandas as pd
import pytest
from ingestion.appointment_parquet_exporter import AppointmentParquetExporter


def test_export_writes_partitioned_parquet_and_hashes_phone(tmp_path):
    salt = "clinic-test-salt"
    exporter = AppointmentParquetExporter(output_dir=tmp_path, hash_salt=salt)

    records = [
        {
            "appointment_id": 101,
            "patient_id": 1,
            "doctor_id": 10,
            "appointment_date": "2026-11-20 09:30:00",
            "status": "Scheduled",
            "patient_phone": "+966501234567",
        },
        {
            "appointment_id": 102,
            "patient_id": 2,
            "doctor_id": 11,
            "appointment_date": "2026-11-21 14:00:00",
            "status": "Completed",
            "patient_phone": " +966559876543 ",
        },
    ]

    exported_count = exporter.export(records)

    assert exported_count == 2
    assert (tmp_path / "partition_date=2026-11-20").is_dir()
    assert (tmp_path / "partition_date=2026-11-21").is_dir()

    df = pd.read_parquet(tmp_path, engine="pyarrow")
    assert len(df) == 2
    assert "patient_phone" not in df.columns
    assert "patient_phone_hash" in df.columns

    expected_hash_1 = hashlib.sha256(f"{salt}:+966501234567".encode("utf-8")).hexdigest()
    expected_hash_2 = hashlib.sha256(f"{salt}:+966559876543".encode("utf-8")).hexdigest()
    hashes = set(df["patient_phone_hash"].tolist())

    assert hashes == {expected_hash_1, expected_hash_2}
    assert "+966501234567" not in df.to_string()
    assert "+966559876543" not in df.to_string()


def test_export_returns_zero_for_empty_records(tmp_path, caplog):
    exporter = AppointmentParquetExporter(output_dir=tmp_path, hash_salt="salt")

    with caplog.at_level(logging.WARNING):
        exported_count = exporter.export([])

    assert exported_count == 0
    assert list(tmp_path.iterdir()) == []
    assert "No appointment records to export." in caplog.text


def test_export_raises_when_appointment_date_missing(tmp_path):
    exporter = AppointmentParquetExporter(output_dir=tmp_path, hash_salt="salt")

    with pytest.raises(ValueError, match="appointment_date"):
        exporter.export([{"appointment_id": 1, "patient_phone": "+966501234567"}])


def test_export_handles_null_and_blank_phone(tmp_path):
    exporter = AppointmentParquetExporter(output_dir=tmp_path, hash_salt="salt")

    records = [
        {
            "appointment_id": 201,
            "appointment_date": "2026-11-22 10:00:00",
            "patient_phone": None,
        },
        {
            "appointment_id": 202,
            "appointment_date": "2026-11-22 11:00:00",
            "patient_phone": "   ",
        },
    ]

    exported_count = exporter.export(records)
    assert exported_count == 2

    df = pd.read_parquet(tmp_path, engine="pyarrow")
    assert "patient_phone" not in df.columns
    assert df["patient_phone_hash"].isna().all()


def test_export_logs_count_without_pii(tmp_path, caplog):
    exporter = AppointmentParquetExporter(output_dir=tmp_path, hash_salt="salt")

    records = [
        {
            "appointment_id": 301,
            "appointment_date": "2026-11-23 08:00:00",
            "patient_phone": "+966501112222",
        }
    ]

    with caplog.at_level(logging.INFO):
        exporter.export(records)

    assert "count=1" in caplog.text
    assert "+966501112222" not in caplog.text
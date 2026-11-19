from datetime import datetime
from unittest.mock import MagicMock
from fastapi.testclient import TestClient
import pytest
from api.main import app, get_clinic_service
from models.appointment import Appointment
from models.doctor import Doctor

client = TestClient(app)


@pytest.fixture
def mock_service():
    service = MagicMock()
    app.dependency_overrides[get_clinic_service] = lambda: service
    yield service
    app.dependency_overrides.clear()


def test_health_endpoint():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "ok"}


def test_get_doctor_success(mock_service):
    mock_service.get_active_doctor.return_value = Doctor(
        id=1,
        first_name="Ahmed",
        last_name="Ali",
        specialty="Cardiology",
        is_active=True,
    )

    response = client.get("/doctors/1")
    assert response.status_code == 200
    assert response.json()["id"] == 1
    assert response.json()["is_active"] is True


def test_get_doctor_not_found_returns_404(mock_service):
    mock_service.get_active_doctor.side_effect = ValueError("Doctor not found")

    response = client.get("/doctors/999")
    assert response.status_code == 404


def test_get_appointment_success(mock_service):
    mock_service.get_appointment_details.return_value = Appointment(
        id=10,
        patient_id=101,
        doctor_id=1,
        appointment_date=datetime(2026, 11, 20, 10, 0),
        status="Scheduled",
        notes="Follow-up visit",
    )

    response = client.get("/appointments/10")
    assert response.status_code == 200
    assert response.json()["id"] == 10


def test_get_appointment_not_found_returns_404(mock_service):
    mock_service.get_appointment_details.side_effect = ValueError("Appointment not found")

    response = client.get("/appointments/999")
    assert response.status_code == 404


def test_database_health_endpoint(mock_service):
    mock_service.get_database_health.return_value = {
        "total_sessions": 12,
        "active_sessions": 3,
    }

    response = client.get("/health/db")
    assert response.status_code == 200
    assert response.json() == {"total_sessions": 12, "active_sessions": 3}
from datetime import datetime
from unittest.mock import MagicMock
import pytest
from models.appointment import Appointment
from models.doctor import Doctor
from services.clinic_service import ClinicService


@pytest.fixture
def clinic_mocks():
    doctor_repo = MagicMock()
    appointment_repo = MagicMock()
    health_repo = MagicMock()
    service = ClinicService(doctor_repo, appointment_repo, health_repo)
    return service, doctor_repo, appointment_repo, health_repo


def test_get_active_doctor_returns_doctor(clinic_mocks):
    service, mock_doctor_repo, _, _ = clinic_mocks

    expected_doctor = Doctor(
        id=1,
        first_name="Ahmed",
        last_name="Ali",
        specialty="Cardiology",
        is_active=True
    )
    mock_doctor_repo.get_by_id.return_value = expected_doctor

    result = service.get_active_doctor(1)

    assert result == expected_doctor
    mock_doctor_repo.get_by_id.assert_called_once_with(1)


def test_get_active_doctor_raises_when_inactive(clinic_mocks):
    service, mock_doctor_repo, _, _ = clinic_mocks

    inactive_doctor = Doctor(
        id=2,
        first_name="Sara",
        last_name="Hassan",
        specialty="Dermatology",
        is_active=False
    )
    mock_doctor_repo.get_by_id.return_value = inactive_doctor

    with pytest.raises(ValueError):
        service.get_active_doctor(2)


def test_get_database_health_returns_stats(clinic_mocks):
    service, _, _, mock_health_repo = clinic_mocks

    expected_stats = {"total_sessions": 12, "active_sessions": 3}
    mock_health_repo.get_connection_stats.return_value = expected_stats

    result = service.get_database_health()

    assert result == expected_stats
    mock_health_repo.get_connection_stats.assert_called_once()


def test_get_appointment_details_returns_appointment(clinic_mocks):
    service, _, mock_appointment_repo, _ = clinic_mocks

    expected_appointment = Appointment(
        id=10,
        patient_id=101,
        doctor_id=1,
        appointment_date=datetime(2026, 11, 20, 10, 0),
        status="Scheduled",
        notes="Follow-up visit"
    )
    mock_appointment_repo.get_by_id.return_value = expected_appointment

    result = service.get_appointment_details(10)

    assert result == expected_appointment
    mock_appointment_repo.get_by_id.assert_called_once_with(10)


def test_get_appointment_details_raises_when_not_found(clinic_mocks):
    service, _, mock_appointment_repo, _ = clinic_mocks

    mock_appointment_repo.get_by_id.return_value = None

    with pytest.raises(ValueError):
        service.get_appointment_details(999)


def test_get_active_doctor_raises_when_not_found(clinic_mocks):
    service, mock_doctor_repo, _, _ = clinic_mocks

    mock_doctor_repo.get_by_id.return_value = None

    with pytest.raises(ValueError):
        service.get_active_doctor(999)


def test_get_active_doctor_logs_id_without_pii(clinic_mocks, caplog):
    service, mock_doctor_repo, _, _ = clinic_mocks

    doctor = Doctor(
        id=1,
        first_name="Ahmed",
        last_name="Ali",
        specialty="Cardiology",
        is_active=True
    )
    mock_doctor_repo.get_by_id.return_value = doctor

    with caplog.at_level("INFO"):
        service.get_active_doctor(1)

    assert "doctor_id=1" in caplog.text
    assert "Ahmed" not in caplog.text
    assert "Ali" not in caplog.text
    assert "Cardiology" not in caplog.text

def test_get_active_doctor_inactive_logs_id_without_pii(clinic_mocks, caplog):
    service, mock_doctor_repo, _, _ = clinic_mocks

    inactive_doctor = Doctor(
        id=2,
        first_name="Sara",
        last_name="Hassan",
        specialty="Dermatology",
        is_active=False
    )
    mock_doctor_repo.get_by_id.return_value = inactive_doctor

    with caplog.at_level("WARNING"):
        with pytest.raises(ValueError):
            service.get_active_doctor(2)

    assert "doctor_id=2" in caplog.text
    assert "Sara" not in caplog.text
    assert "Hassan" not in caplog.text
    assert "Dermatology" not in caplog.text
from unittest.mock import MagicMock
import pytest
from fastapi.testclient import TestClient

from api.main import app, get_clinic_service
from services.clinic_service import ClinicService

client = TestClient(app)


@pytest.fixture
def mock_service():
    service = MagicMock(spec=ClinicService)
    app.dependency_overrides[get_clinic_service] = lambda: service
    yield service
    app.dependency_overrides.clear()


def test_dbre_health_missing_api_key_returns_401(monkeypatch):
    monkeypatch.setenv("API_KEY", "test-secret-key")

    response = client.get("/dbre/health")
    assert response.status_code == 401


def test_dbre_health_invalid_api_key_returns_401(monkeypatch):
    monkeypatch.setenv("API_KEY", "test-secret-key")

    response = client.get("/dbre/health", headers={"X-API-Key": "wrong-key"})
    assert response.status_code == 401


def test_dbre_health_valid_api_key_returns_200(mock_service, monkeypatch):
    monkeypatch.setenv("API_KEY", "test-secret-key")
    mock_service.get_database_health.return_value = {
        "total_sessions": 12,
        "active_sessions": 3,
    }

    response = client.get(
        "/dbre/health",
        headers={"X-API-Key": "test-secret-key"},
    )
    assert response.status_code == 200
    assert response.json() == {"total_sessions": 12, "active_sessions": 3}


def test_trigger_parquet_export_missing_api_key_returns_401(monkeypatch):
    monkeypatch.setenv("API_KEY", "test-secret-key")

    response = client.post("/de/trigger-parquet-export")
    assert response.status_code == 401


def test_trigger_parquet_export_invalid_api_key_returns_401(monkeypatch):
    monkeypatch.setenv("API_KEY", "test-secret-key")

    response = client.post(
        "/de/trigger-parquet-export",
        headers={"X-API-Key": "wrong-key"},
    )
    assert response.status_code == 401


def test_trigger_parquet_export_valid_api_key_returns_200(monkeypatch):
    monkeypatch.setenv("API_KEY", "test-secret-key")

    response = client.post(
        "/de/trigger-parquet-export",
        headers={"X-API-Key": "test-secret-key"},
    )
    assert response.status_code == 200
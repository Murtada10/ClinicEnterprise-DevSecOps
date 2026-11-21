import logging
from unittest.mock import MagicMock, patch
import pytest
import requests
from ingestion.external_doctor_api_client import ExternalDoctorApiClient


def test_init_rejects_non_https_url():
    with pytest.raises(ValueError, match="HTTPS"):
        ExternalDoctorApiClient("http://api.external-clinic.example")


@patch("ingestion.external_doctor_api_client.requests.get")
def test_fetch_doctors_enforces_tls_and_timeout(mock_get):
    mock_response = MagicMock()
    mock_response.json.return_value = [
        {"id": 1, "name": "Dr. Tariq Mansour", "specialty": "Neurology"}
    ]
    mock_get.return_value = mock_response

    client = ExternalDoctorApiClient("https://api.external-clinic.example/")
    result = client.fetch_doctors("/doctors")

    assert len(result) == 1
    assert result[0]["id"] == 1
    mock_get.assert_called_once_with(
        "https://api.external-clinic.example/doctors",
        timeout=10,
        verify=True,
    )
    mock_response.raise_for_status.assert_called_once()


@patch("ingestion.external_doctor_api_client.requests.get")
def test_fetch_doctors_raises_on_non_list_payload(mock_get):
    mock_response = MagicMock()
    mock_response.json.return_value = {"error": "unexpected object"}
    mock_get.return_value = mock_response

    client = ExternalDoctorApiClient("https://api.external-clinic.example")

    with pytest.raises(ValueError, match="JSON list"):
        client.fetch_doctors()


@patch("ingestion.external_doctor_api_client.requests.get")
def test_fetch_doctors_propagates_http_error(mock_get):
    mock_response = MagicMock()
    mock_response.raise_for_status.side_effect = requests.HTTPError("503 Server Error")
    mock_get.return_value = mock_response

    client = ExternalDoctorApiClient("https://api.external-clinic.example")

    with pytest.raises(requests.HTTPError):
        client.fetch_doctors()


@patch("ingestion.external_doctor_api_client.requests.get")
def test_fetch_doctors_logs_without_pii(mock_get, caplog):
    mock_response = MagicMock()
    mock_response.json.return_value = [
        {"id": 7, "name": "Dr. Layla Kareem", "phone": "+966501234567"}
    ]
    mock_get.return_value = mock_response

    client = ExternalDoctorApiClient("https://api.external-clinic.example")

    with caplog.at_level(logging.INFO):
        client.fetch_doctors("/doctors")

    assert "count=1" in caplog.text
    assert "Layla Kareem" not in caplog.text
    assert "+966501234567" not in caplog.text
import logging
from typing import Any
import requests

logger = logging.getLogger(__name__)


class ExternalDoctorApiClient:
    def __init__(self, base_url: str, timeout: int = 10):
        if not base_url.startswith("https://"):
            raise ValueError("base_url must use HTTPS to enforce TLS.")
        self.base_url = base_url.rstrip("/")
        self.timeout = timeout

    def fetch_doctors(self, endpoint: str = "/doctors") -> list[dict[str, Any]]:
        url = f"{self.base_url}/{endpoint.lstrip('/')}"
        logger.info("Fetching external doctor feed from endpoint=%s", endpoint)

        response = requests.get(
            url,
            timeout=self.timeout,
            verify=True,
        )
        response.raise_for_status()

        payload = response.json()
        if not isinstance(payload, list):
            raise ValueError("Expected a JSON list of doctor records.")

        logger.info("Fetched external doctor records count=%d", len(payload))
        return payload
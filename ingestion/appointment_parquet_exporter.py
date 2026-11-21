import hashlib
import logging
from pathlib import Path
from typing import Any
import pandas as pd

logger = logging.getLogger(__name__)


class AppointmentParquetExporter:
    def __init__(self, output_dir: str | Path, hash_salt: str = ""):
        self.output_dir = Path(output_dir)
        self.hash_salt = hash_salt

    def _hash_phone(self, phone: Any) -> str | None:
        if phone is None or pd.isna(phone):
            return None
        normalized = str(phone).strip()
        if not normalized:
            return None
        salted = f"{self.hash_salt}:{normalized}".encode("utf-8")
        return hashlib.sha256(salted).hexdigest()

    def export(self, records: list[dict[str, Any]]) -> int:
        if not records:
            logger.warning("No appointment records to export.")
            return 0

        df = pd.DataFrame(records)

        if "appointment_date" not in df.columns:
            raise ValueError("Missing required 'appointment_date' column for partitioning.")

        if "patient_phone" in df.columns:
            df["patient_phone_hash"] = df["patient_phone"].apply(self._hash_phone)
            df = df.drop(columns=["patient_phone"])

        df["partition_date"] = pd.to_datetime(df["appointment_date"]).dt.strftime("%Y-%m-%d")

        self.output_dir.mkdir(parents=True, exist_ok=True)
        df.to_parquet(
            self.output_dir,
            engine="pyarrow",
            partition_cols=["partition_date"],
            index=False,
        )

        exported_count = len(df)
        logger.info("Exported appointments to Parquet count=%d", exported_count)
        return exported_count
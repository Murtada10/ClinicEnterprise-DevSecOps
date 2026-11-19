from pydantic import BaseModel, Field, computed_field
from datetime import datetime
from dateutil.relativedelta import relativedelta

class Patient(BaseModel):
    # Mapping exactly to your physical database schema
    id: int = Field(gt=0)
    first_name: str
    last_name: str
    phone_number: str
    date_of_birth: datetime

    @computed_field
    @property
    def full_name(self) -> str:
        """Combines first and last name for downstream presentation."""
        return f"{self.first_name} {self.last_name}"

    @computed_field
    @property
    def is_adult(self) -> bool:
        """Dynamically calculates if the patient is 18+ based on DateOfBirth."""
        age = relativedelta(datetime.now(), self.date_of_birth).years
        return age >= 18

    def masked_phone(self) -> str:
        if not self.phone_number or len(self.phone_number) < 4:
            return "****"

        prefix = self.phone_number[:3]
        suffix = self.phone_number[-3:]
        mask_length = len(self.phone_number) - 6
        mask = "*" * (mask_length if mask_length > 0 else 4)

        return f"{prefix}{mask}{suffix}"
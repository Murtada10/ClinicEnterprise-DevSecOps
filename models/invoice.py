from pydantic import BaseModel, Field
from datetime import datetime
from decimal import Decimal
from models.appointment import Appointment


class Invoice(BaseModel):
    id: int = Field(gt=0)
    appointment_id: int = Field(gt=0)
    amount: Decimal = Field(ge=0, max_digits=10, decimal_places=2)
    payment_status: str = Field(default="Unpaid", max_length=20)
    issued_at: datetime
    appointment: Appointment | None = None
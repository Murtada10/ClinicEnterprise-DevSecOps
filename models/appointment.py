from pydantic import BaseModel, Field
from datetime import datetime
from models.patient import Patient
from models.doctor import Doctor


class Appointment(BaseModel):
    id: int = Field(gt=0)
    patient_id: int = Field(gt=0)
    doctor_id: int = Field(gt=0)
    appointment_date: datetime
    status: str = Field(default="Scheduled", max_length=20)
    notes: str | None = Field(default=None, max_length=500)

    patient: Patient | None = None
    doctor: Doctor | None = None
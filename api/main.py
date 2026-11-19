from fastapi import Depends, FastAPI, HTTPException, Security

from api.security import verify_api_key
from infrastructure.database import DatabaseConnection
from repositories.appointment_repository import AppointmentRepository
from repositories.database_health_repository import DatabaseHealthRepository
from repositories.doctor_repository import DoctorRepository
from services.clinic_service import ClinicService

app = FastAPI(title="ClinicEnterprise API")


def get_clinic_service() -> ClinicService:
    db = DatabaseConnection()
    doctor_repo = DoctorRepository(db)
    appointment_repo = AppointmentRepository(db)
    health_repo = DatabaseHealthRepository(db)
    return ClinicService(doctor_repo, appointment_repo, health_repo)


@app.get("/health")
def health():
    return {"status": "ok"}


@app.get("/doctors/{doctor_id}")
def get_doctor(doctor_id: int, service: ClinicService = Depends(get_clinic_service)):
    try:
        return service.get_active_doctor(doctor_id)
    except ValueError as exc:
        raise HTTPException(status_code=404, detail=str(exc)) from exc


@app.get("/appointments/{appointment_id}")
def get_appointment(
    appointment_id: int, service: ClinicService = Depends(get_clinic_service)
):
    try:
        return service.get_appointment_details(appointment_id)
    except ValueError as exc:
        raise HTTPException(status_code=404, detail=str(exc)) from exc


@app.get("/health/db")
def database_health(service: ClinicService = Depends(get_clinic_service)):
    return service.get_database_health()


@app.get("/dbre/health")
def dbre_health(
    _: str = Security(verify_api_key),
    service: ClinicService = Depends(get_clinic_service),
):
    return service.get_database_health()


@app.post("/de/trigger-parquet-export")
def trigger_parquet_export(_: str = Security(verify_api_key)):
    return {"status": "accepted", "detail": "Parquet export triggered."}
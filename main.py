from infrastructure.database import DatabaseConnection
from repositories.patient_repository import PatientRepository

def test_repository():
    print("--- Testing Tier 3 (Patient Repository) ---")
    try:
        # Context manager opens connection securely
        with DatabaseConnection() as db:
            # Instantiate repository using Dependency Injection
            repo = PatientRepository(db)
            
            # Fetch patient ID 100000 using our secure parameterized query
            patient = repo.get_patient_by_id(100000)
            
            if patient:
                print("Successfully fetched via PatientRepository!")
                print(f"Patient Name: {patient.full_name}")
                print(f"Is Adult: {patient.is_adult}")
                print(f"Masked Phone (GDPR Safe): {patient.masked_phone()}")
            else:
                print("Patient ID not found.")
                
    except Exception as e:
        print(f"Repository Test Failed: {e}")

if __name__ == "__main__":
    test_repository()
from pydantic import BaseModel, Field, computed_field

class Doctor(BaseModel):
    # Mapping exactly to the future dbo.Doctors table
    id: int = Field(gt=0)
    first_name: str
    last_name: str
    specialty: str
    is_active: bool = True

    @computed_field
    @property
    def full_name(self) -> str:
        """combines first and last name with a professional prefix."""
        return f"Dr. {self.first_name} {self.last_name}"
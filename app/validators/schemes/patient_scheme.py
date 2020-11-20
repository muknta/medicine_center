from pydantic import BaseModel


class PatientScheme(BaseModel):
    user_id: str
    name: str
    surname: str
    address: str
    phone_number: str
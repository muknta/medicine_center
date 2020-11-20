from pydantic import BaseModel


class DoctorScheme(BaseModel):
    user_id: str
    name: str
    surname: str
    address: str
    phone_number: str
    specialtie: str
    
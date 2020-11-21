from datetime import datetime
from pydantic import BaseModel
from typing import Optional


# TODO: make foreign keys?
class UserScheme(BaseModel):
    email: str
    password: str


class DiseaseHistoryScheme(BaseModel):
    author_id: str
    patient_id: str
    title: str
    date_updated: datetime
    date_created: datetime
    diagnosis: str
    status: str
    content: Optional[str]
    file_name: Optional[str]

class ScheduleScheme(BaseModel):
    doctor_id: str
    weekDay: str
    startTime: datetime
    finishTime: datetime
    hospital: Optional[str]
    room: str

class PatientScheme(BaseModel):
    user_id: str
    name: str
    surname: str
    address: str
    phone_number: str

class DoctorScheme(BaseModel):
    user_id: str
    name: str
    surname: str
    address: str
    phone_number: str
    specialtie: str
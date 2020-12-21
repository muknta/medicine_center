from datetime import datetime
from pydantic import BaseModel
from typing import Optional


class MessageScheme(BaseModel):
    doctor_id: str
    patient_id: str
    sender: str
    text: str
    dateCreated: datetime = datetime.now()

from datetime import datetime
from pydantic import BaseModel
from typing import Optional


class ScheduleScheme(BaseModel):
    doctor_id: str
    weekDay: str
    startTime: datetime
    finishTime: datetime
    hospital: Optional[str]
    room: str
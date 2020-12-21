from app.database.database import MongoBase
from typing import Sequence, Tuple


class AppointmentsCollection(MongoBase):
    collection_name: str = 'appointment'
    db_fields: Sequence[Tuple[str]] = ('_id', 'doctor_id', 'patient_id', 'startDateTime', 'finishDateTime', 'note')
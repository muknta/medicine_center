from .database import MongoBase
from typing import Sequence, Tuple


class ScheduleCollection(MongoBase):
    collection_name: str = 'schedule'
    db_fields: Sequence[Tuple[str]] = ('_id', 'doctor_id', 'weekDay', 'startTime', 'finishTime', 'hospital', 'room')

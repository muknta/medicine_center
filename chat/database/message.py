from app.database.database import MongoBase
from typing import Sequence, Tuple


class MessagesCollection(MongoBase):
    collection_name: str = 'message'
    db_fields: Sequence[Tuple[str]] = ('_id', 'doctor_id', 'patient_id', 'sender', 'text', 'dateCreated')

    
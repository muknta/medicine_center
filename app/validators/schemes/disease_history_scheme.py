from datetime import datetime
from pydantic import BaseModel
from typing import Optional


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
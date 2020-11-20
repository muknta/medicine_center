from app.database.database import MongoBase
from typing import Sequence, Tuple


class ProfileImagesCollection(MongoBase):
    collection_name: str = 'profile_images'
    db_fields: Sequence[Tuple[str]] = ('_id', 'user_id', 'path')

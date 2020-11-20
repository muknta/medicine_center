from app.database.database import MongoBase
from typing import Sequence, Tuple
from bson.objectid import ObjectId
from bson.errors import InvalidId


class HistoriesCollection(MongoBase):
    collection_name: str = 'histories'
    db_fields: Sequence[Tuple[str]] = (
        '_id', 'author_id', 'patient_id', 'title', 'date_updated', 'date_created', 'diagnosis', 'status', 'content',
        'file_name')

    @classmethod
    def get_one_obj(cls, filter, projection=None):
        try:
            filter['_id'] = ObjectId(filter['_id'])
        except InvalidId:
            return

        return cls.collection.find_one(filter, projection=projection)



if __name__ == '__main__':
    print(HistoriesCollection.get_all_objects())

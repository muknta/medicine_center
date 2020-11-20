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
    # HistoriesCollection.insert_obj({
    # 'author_id': '5fb55f1d741559b07bc8ed02',
    # "patient_id": '5fb5605b176dde2776481166',
    # 'title': 'Diabetes',
    # 'date_updated': datetime.now(),
    # 'date_created': datetime.now(),
    #     'diagnosis': 'Diabetes',
    #     'status': "Ill",
    #     'content': "This person ill on diabetes"
    # })
    print(HistoriesCollection.get_all_objects())

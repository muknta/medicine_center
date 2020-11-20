from app.database.database import MongoBase
from typing import Sequence, Tuple


class PatientsCollection(MongoBase):
    collection_name: str = 'patient'
    db_fields: Sequence[Tuple[str]] = ('_id', 'user_id', 'profession', 'conditions', 'address')

    # @classmethod
    # def get_one_obj(cls, filter, projection=None):
    #     return {'data': cls.to_json(cls.collection.find_one(filter, projection=projection)), 'result': True}


if __name__ == '__main__':
    # PatientsCollection.insert_obj({
    #     'user_id': '5fb567b71081d96ca7f6e1fb',
    #     'profession': 'Bus driver',
    #     'conditions': 'Passive'
    # })

    print(PatientsCollection.get_all_objects())

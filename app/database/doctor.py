from app.database.database import MongoBase
from typing import Sequence, Tuple


class DoctorsCollection(MongoBase):
    collection_name: str = 'doctor'
    db_fields: Sequence[Tuple[str]] = ('_id', 'user_id', 'hospital_id', 'rating', 'positing')

    @classmethod
    def get_objs(cls, filter, fields=db_fields, projection=None):
        res = list(cls.collection.find(filter, projection=projection))
        res = cls.to_json(res)

        return res


if __name__ == '__main__':
    # DoctorsCollection.insert_obj({
    #     'user_id': '5fb5669ae293ec7298213064',
    #     'hospital_id': '5fb561a1a85dcf7b9e9e1643',
    #     'rating': '4.3',
    #     'positing': 'Pediatrician'
    # })
    print(DoctorsCollection.get_one_obj({'user_id': '5fb55f1d741559b07bc8ed02'}))
    print(DoctorsCollection.get_all_objects())

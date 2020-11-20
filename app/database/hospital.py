from app.database.database import MongoBase
from typing import Sequence, Tuple
from bson.objectid import ObjectId
from bson.errors import InvalidId


class HospitalCollection(MongoBase):
    collection_name: str = 'hospital'
    db_fields: Sequence[Tuple[str]] = ('_id', 'name', 'address', 'phone_number')


if __name__ == '__main__':
    # HospitalCollection.insert_obj({
    #     'name': 'Northwestern Memorial Hospital',
    #     'address': "251 E Huron St, Chicago, IL 60611, USA",
    #     'phone_number': "+1 312-926-2000"
    # })

    print(HospitalCollection.delete_obj_by_id('5fb56287bc19d237a79692fc'))

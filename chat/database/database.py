import bson
import abc
from bson.objectid import ObjectId
from bson.errors import InvalidId

from pymongo import MongoClient

from config import DATABASE_NAME, DB_SOURCE
from bson.objectid import ObjectId
from bson.errors import InvalidId


# TODO: Add validation for attributes in __new__ method
class Meta(abc.ABCMeta):
    @property
    def database(cls):
        if not hasattr(cls, '_database'):
            cls._database = cls._client[DATABASE_NAME]
        return cls._database

    @property
    def collection(cls):
        if not hasattr(cls, '_collection'):
            cls._collection = cls.database[cls.collection_name]
        return cls._collection


class MongoBase(abc.ABC, metaclass=Meta):
    _client = MongoClient(DB_SOURCE)

    @staticmethod
    @abc.abstractmethod
    def collection_name():
        pass

    @staticmethod
    @abc.abstractmethod
    def db_fields():
        pass

    @classmethod
    def validate_incoming_data(cls, data: dict):
        return {key: value for key, value in data.items() if key in cls.db_fields}

    @classmethod
    def get_all_objects(cls, projection=None):
        return list(cls.collection.find({}, projection=projection))

    @classmethod
    def get_one_obj(cls, filter, projection=None):
        if filter.get('_id'):
            try:
                filter['_id'] = ObjectId(filter['_id'])
            except InvalidId:
                return
        return cls.to_json(cls.collection.find_one(filter, projection=projection))

    @classmethod
    def insert_obj(cls, data: dict):
        data = cls.validate_incoming_data(data)
        result = cls.collection.insert_one(data)
        data['_id'] = result.inserted_id
        return data

    @classmethod
    def update_obj_by_id(cls, _id, data: dict, upsert=False):
        if not isinstance(_id, bson.ObjectId):
            _id = bson.ObjectId(_id)
        data = cls.validate_incoming_data(data)
        if data:
            return cls.collection.update_one({'_id': _id}, {'$set': data}, upsert=upsert)

    @classmethod
    def delete_obj_by_id(cls, _id):
        if not isinstance(_id, bson.ObjectId):
            _id = bson.ObjectId(_id)
        return cls.collection.delete_one({'_id': _id})

    @classmethod
    def delete_all_obj(cls):
        return cls.collection.delete_many({})

    @classmethod
    def get_objs(cls, filter, fields=db_fields, projection=None):

        res = list(cls.collection.find(filter, projection=projection))
        res = cls.to_json(res)

        return res

    @staticmethod
    def to_json(data):
        if isinstance(data, list):
            for obj in data:
                fields = obj.keys()
                for field in fields:
                    if isinstance(obj[field], bson.ObjectId):
                        obj[field] = str(obj[field])
        elif isinstance(data, dict):
            fields = data.keys()
            for field in fields:
                if isinstance(data[field], bson.ObjectId):
                    data[field] = str(data[field])

        return data

    @classmethod
    def get_ids(cls):
        collection_id = [str(coll_id) for coll_id in cls.collection.find().distinct('_id')]

        return collection_id

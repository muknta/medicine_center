from passlib.context import CryptContext
import datetime

from app.database.database import MongoBase
from typing import Sequence, Tuple

password_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


class UsersCollection(MongoBase):
    collection_name: str = 'users'
    db_fields: Sequence[Tuple[str]] = (
        '_id', 'email', 'password', 'role', 'name', 'surname', 'phone_number',
        'patronymic', 'gender', 'profession', 'address', 'birthday')

    @classmethod
    def verify_password(cls, plain_password, hashed_password):
        return password_context.verify(plain_password, hashed_password)

    @classmethod
    def get_password_hash(cls, password):
        return password_context.hash(password)

    @classmethod
    def str_to_datetime_date(cls, str_date):
        datetime_len = len('yyyy-MM-dd') # 10
        try:
            datetime_date = datetime.datetime.strptime(
                    str_date[:datetime_len], '%Y-%m-%d').date()
            return datetime_date
        except ValueError:
            raise ValueError('Invalid birthday format.')

    @classmethod
    def date_to_datetime(cls, date_obj):
        return datetime.datetime.combine(date_obj, datetime.time.min)

    @classmethod
    def datetime_to_date(cls, datetime_obj):
        return datetime_obj.date()


if __name__ == '__main__':
    # our test user
    # UsersCollection.insert_obj({
    #     'email': 'xagepittollu-1049@yopmail.com',
    #     'password': UsersCollection.get_password_hash('123456'),
    #     'role': 'patient',
    #     'name': 'Yvette',
    #     'surname': 'Ireland',
    #     'phone_number': '(399) 449-5389',
    #     'patronymic': 'Max',
    #     'gender': 'female',
    #     'birthday': datetime(1985, 9, 1)
    # })

    print(UsersCollection.get_objs({'email': 'xagepittollu-1049@yopmail.com'}))

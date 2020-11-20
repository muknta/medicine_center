from passlib.context import CryptContext

from app.database.database import MongoBase
from typing import Sequence, Tuple

password_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


class UsersCollection(MongoBase):
    collection_name: str = 'users'
    db_fields: Sequence[Tuple[str]] = (
        '_id', 'email', 'password', 'role', 'name', 'surname',
        'phone_number', 'patronymic', 'gender', 'birthday')

    @classmethod
    def verify_password(cls, plain_password, hashed_password):
        return password_context.verify(plain_password, hashed_password)

    @classmethod
    def get_password_hash(cls, password):
        return password_context.hash(password)


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

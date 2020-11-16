from passlib.context import CryptContext

from .database import MongoBase
from typing import Sequence, Tuple

password_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


class UsersCollection(MongoBase):
    collection_name: str = 'users'
    db_fields: Sequence[Tuple[str]] = (
        '_id', 'email', 'password', 'role', 'name', 'surname',
        'phone_number', 'patronymic', 'gender') #, 'birthday'

    @classmethod
    def verify_password(cls, plain_password, hashed_password):
        return password_context.verify(plain_password, hashed_password)

    @classmethod
    def get_password_hash(cls, password):
        return password_context.hash(password)

# if __name__ == '__main__':
#     # our test user
#     UsersCollection.insert_obj({'email': 'test@test.mail', 'password': UsersCollection.get_password_hash('test')})

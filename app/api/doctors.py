from fastapi import APIRouter
from bson.objectid import ObjectId

from app.database.doctor import DoctorsCollection
from app.database.users import UsersCollection


router = APIRouter()


@router.get('/profile/doctor/{user_id}')
async def get_doctor_profile(user_id: str):
    """
    Get data for doctor's profile

    :param user_id: Id of doctor in database
    :return: doctor data
    """
    user_data = UsersCollection.to_json( UsersCollection.get_one_obj({'_id': user_id})['data'])
    doctor_data = DoctorsCollection.to_json(DoctorsCollection.get_one_obj({'user_id': user_id})['data'])

    if not doctor_data:
        return {'data': {}, 'result': False}, 200

    res = {**doctor_data, **user_data}
    del res['password']

    return {'data': res, 'result': True}


@router.get('/doctors/')
async def get_all_doctors():
    """
    Get all doctors from database
    :return: list of doctors
    """
    list_doctors = DoctorsCollection.to_json(DoctorsCollection.get_all_objects()['data'])

    if not list_doctors:
        return {'data': {}, 'result': False}, 200

    for i in range(len(list_doctors)):
        user_data = UsersCollection.to_json(UsersCollection.get_one_obj({'_id': list_doctors[i]['user_id']})['data'])
        list_doctors[i] = {**list_doctors[i], **user_data}
        del list_doctors[i]['password']

    return {'data': list_doctors, 'result': True}

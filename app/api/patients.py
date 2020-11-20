from fastapi import APIRouter
from bson.objectid import ObjectId

from app.database.patient import PatientsCollection
from app.database.users import UsersCollection

router = APIRouter()


@router.get('/profile/patient/{user_id}')
async def get_patient_profile(user_id: str):
    """
    Get data for patients profile

    :param user_id: Id of user in database
    :return: patient data
    """

    user = UsersCollection.get_one_obj({'_id': user_id})
    if user:
        user_data = UsersCollection.to_json(user)
        patient = PatientsCollection.get_one_obj({'user_id': user_id})
        if not patient:
            return {'data': {}, 'result': False}, 200

        patient_data = PatientsCollection.to_json(patient)
        res = {**patient_data, **user_data}
        del res['password']
        return res

    return {'data': {}, 'result': False}


@router.get('/patients/')
async def get_all_patient():
    """
    Get all patients from database
    :return: list of doctors
    """
    list_patient = PatientsCollection.get_all_objects()['data']

    if not list_patient:
        return {'data': {}, 'result': False}, 200

    for i in range(len(list_patient)):
        user = UsersCollection.get_one_obj({'_id': list_patient[i]['user_id']})
        if user and list_patient:
            user_data = UsersCollection.to_json(user)
            list_patient[i] = {**list_patient[i], **user_data}

            del list_patient[i]['password']

    return {'data': list_patient, 'result': True}

from fastapi import APIRouter

from app.api.repository import Repository

router = APIRouter()


@router.get('/profile/patient/{user_id}')
async def get_patient_profile(user_id: str):
    """
    Get data for patients profile

    :param user_id: Id of user in database
    :return: patient data
    """
    patient_profile = Repository.get_patient_by_id(user_id)

    return {'data': patient_profile, 'result': bool(patient_profile)}

@router.post('/patients/search/')
async def get_patients_by_filter(filter:dict):
    """
    Get patients list by attributes for search engine.

    :param filter: dict (column:"value") of attributes to search for.
    :return: list of patients.
    """
    patients = Repository.get_patient_by_dict(filter)

    return patients

@router.get('/patients/')
async def get_all_patient():
    """
    Get all patients from database

    :return: list of patients
    """
    list_patients = Repository.get_all_patients()

    return {'data': list_patients, 'result': bool(list_patients)}

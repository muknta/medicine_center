from fastapi import APIRouter

from app.api.repository import Repository


router = APIRouter()


@router.get('/profile/doctor/{user_id}')
async def get_doctor_profile(user_id: str):
    """
    Get data for doctor's profile

    :param user_id: Id of doctor in database
    :return: doctor data
    """
    doctor_profile = Repository.get_doctor_by_id(user_id)

    return {'data': doctor_profile, 'result': bool(doctor_profile)}


@router.get('/doctors/')
async def get_all_doctors():
    """
    Get all doctors from database

    :return: list of doctors
    """
    list_doctors = Repository.get_all_doctors()

    return {'data': list_doctors, 'result': bool(list_doctors)}

from fastapi import APIRouter

from app.api.repository import Repository


router = APIRouter()


@router.get('/hospital/{hospital_id}')
async def get_hospital_profile(hospital_id: str):
    """
    Get data for hospital profile
    """
    hospital_profile = Repository.get_hospital_by_id(hospital_id)

    return {'data': hospital_profile, 'result': bool(hospital_profile)}


@router.get('/hospitals')
async def get_all_hospitals():
    """
    Get all hospitals from database
    :return: list of hospitals
    """
    list_hospitals = Repository.get_all_hospitals()

    return {'data': list_hospitals, 'result': bool(list_hospitals)}


@router.get('/hospital/{hospital_id}/doctors/')
async def get_hospitals_doctors(hospital_id: str):
    """
    Get doctors of hospital with hospital_id
    :param hospital_id: hospital's id
    :return: list of doctors
    """
    list_doctors = Repository.get_doctors_by_hospital_id(hospital_id)

    return {'data': list_doctors, 'result': bool(list_doctors)}

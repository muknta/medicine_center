from fastapi import APIRouter

from app.database.hospital import HospitalCollection
from app.database.doctor import DoctorsCollection


router = APIRouter()


@router.get('/hospital/{hospital_id}')
async def get_hospital_profile(hospital_id: str):
    """
    Get data for hospital profile

    """
    hospital_data =HospitalCollection.to_json( HospitalCollection.get_one_obj({'_id': hospital_id})['data'])

    if not hospital_data:
        return {'data': {}, 'result': False}, 200

    return {'data': hospital_data, 'result': True}


@router.get('/hospitals')
async def get_all_hospitals():
    """
    Get all hospitals from database
    :return: list of hospitals
    """

    return {'data': HospitalCollection.to_json(HospitalCollection.get_all_objects()['data']), 'result': True}


@router.get('/hospital/{hospital_id}/doctors/')
async def get_hospitals_doctors(hospital_id: str):
    """
    Get doctors of hospital with hospital_id
    :param hospital_id: hospital's id
    :return: list of doctors
    """
    res = DoctorsCollection.to_json(DoctorsCollection.get_objs({'hospital_id': hospital_id}))

    if not res:
        return {'data': {}, 'result': False}, 200

    return {'data': res, 'result': True}

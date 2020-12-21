import json
import shutil
import uuid
import os

from app.api.repository import Repository

from fastapi import APIRouter, File, UploadFile

# add correct db classes. create if don't exist
# from app.validators.schemes.user_schemes import DiseaseHistoryScheme
from app.validators.schemes.schedule_scheme import ScheduleScheme
from app.database.doctor import DoctorsCollection
from app.database.patient import PatientsCollection
from app.database.hospital import HospitalCollection
from app.database.schedule import ScheduleCollection

router = APIRouter()


@router.get('/schedule/{doctor_id}')
async def get_schedule(doctor_id: str):
    """
    Get doctor's all schedules by id
    :param doctor_id:
    :return: schedule_data
    """
    result = Repository.get_schedule(doctor_id)

    return result


@router.post('/schedule/add')
async def add_schedule(schedule: ScheduleScheme):
    """
    Takes schedule, adds it to database.
    :param schedule_id: 
    :return: status
    """
    ScheduleCollection.insert_obj(dict(schedule))
    return {'description': 'Addition successful', 'result': True}


@router.delete('/schedule/delete/{schedule_id}')
async def delete_schedule(schedule_id: str):
    """
    Delete schedule by id
    :param schedule_id: 
    :return: description and status
    """
    if schedule_id in ScheduleCollection.get_ids():
        ScheduleCollection.delete_obj_by_id(schedule_id)
        return {'description': 'Delete successful', 'result': True}
    return {'description': 'Can\'t find schedule by this id', 'result': False}


@router.put('/schedule/update/{schedule_id}')
async def update_schedule(schedule_id: str, new_schedule: ScheduleScheme):
    """
    Update schedule by id with new schedule
    :param schedule_id: id of schedule in database
    :param new_schedule: dict of new schedule
    :return: description and status
    """
    if schedule_id in ScheduleCollection.get_ids():
        ScheduleCollection.update_obj_by_id(schedule_id, dict(new_schedule))
        return {'description': 'Update successful', 'result': True}
    return {'description': 'Can\'t find a schedule by this id', 'result': False}

from fastapi import APIRouter

from app.api.repository import Repository

from app.validators.schemes.appointment_scheme import AppointmentScheme
from app.database.appointment import AppointmentsCollection
from app.database.schedule import ScheduleCollection

router = APIRouter()


@router.post('/appointment/add')
async def add_appointment(appointment:AppointmentScheme):
    """
    Adds an appointment of patient with a doctor
    :param appointment: dictionary containing appointment details
    :return: status
    """
    status = Repository.add_appointment(appointment)
    print(appointment)
    return status

@router.delete('/appointment/delete')
async def delete_appointment(appointment_id:str):
    """
    Deletes an appointment with given id
    :param id: _id of the appointment
    :return: status
    """
    status = Repository.delete_appointment(appointment_id)

    return status

@router.put('/appointment/get/patient{patient_id}')
async def get_appointments_by_patient(patient_id:str):
    """
    Returns a list of appointments given patient_id
    :param patient_id: patient id
    :return: list of appointments
    """
    appointments = Repository.get_appointments_by_patient(patient_id)

    return appointments

@router.put('/appointment/get/doctor{doctor_id}')
async def get_appointments_by_doctor(doctor_id:str):
    """
    Returns a list of appointments given doctor_id
    :param doctor_id: doctor id
    :return: list of appointments
    """
    appointments = Repository.get_appointments_by_doctor(doctor_id)

    return appointments

@router.put('/appointment/get')
async def get_appointments_by_filter(filter:dict):
    """
    Returns a list of appointments given filter
    :param filter: dictionary of what to search for
    :return: appointments list
    """
    appointments = Repository.get_appointments_by_filter(filter)

    return appointments


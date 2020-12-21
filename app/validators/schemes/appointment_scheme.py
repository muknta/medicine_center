from pydantic import BaseModel, validator, ValidationError, root_validator
from datetime import datetime
from typing import Optional
from app.api.repository import Repository

class AppointmentScheme(BaseModel):
    doctor_id: str
    patient_id: str
    startDateTime: datetime = None
    finishDateTime: datetime = None
    note: Optional[str]
    
    # is start time out of doctor's schedule
    @validator('startDateTime')
    def within_working_hours(cls, v, values):
        schedule = Repository.get_schedule(values['doctor_id'])['data']        
        workingHours = [(s['startTime'], s['finishTime'])
                        for s in schedule if s['weekDay']==v.strftime('%A')] # get working hours on the appointment day
        v = v.replace(tzinfo=None)
        for start, finish in workingHours:
            if start.time() <= v.time() <= finish.time():
                return v
        raise ValueError(f'Out of schedule! Doctor is working today at {workingHours}')
        

    # time is occupied by other patients
    # @validator('finishDateTime')
    @root_validator()
    def is_unoccupied(cls, values):
        if 'startDateTime' in values and 'finishDateTime' in values:
            values['startDateTime'] = values['startDateTime'].replace(tzinfo=None)
            values['finishDateTime'] = values['finishDateTime'].replace(tzinfo=None)
            doctors_appointments = Repository.get_appointments_by_doctor(values['doctor_id'])
            for a in doctors_appointments:
                if a['startDateTime'] <= values['startDateTime'] <= a['finishDateTime']  or a['startDateTime'] <= values['finishDateTime'] <= a['finishDateTime']:
                    raise ValueError('Time overlaps with existing appointment')
        return values    

    @validator('startDateTime')
    def is_soon(cls, v):
        maxForward = 2*7*24*60*60 # (2 weeks) maximum time in sec between appointment time and now  
        if v.timestamp() - datetime.today().timestamp() > maxForward:
            raise ValueError('Making appointments 2 weeks+ in the future is not allowed')
        return v

    # no longer then 2 hours
    # @validator('startDateTime', 'finishDateTime')
    @root_validator()
    def is_short(cls, values):
        if 'startDateTime' in values and 'finishDateTime' in values:
            if values['finishDateTime'].timestamp() - values['startDateTime'].timestamp() > 2*60*60:
                raise ValueError('Appointments longer then 2 hours are not allowed')

        return values   

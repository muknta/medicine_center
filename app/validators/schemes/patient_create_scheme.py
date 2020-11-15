from pydantic import BaseModel, validator, ValidationError
import datetime.date
import re


class RegisterScheme(BaseModel):
    email: str
    password1: str
    password2: str
    role: str
    name: str
    surname: str
    phone_number: str
    patronymic: str
    gender: str
    birthday: datetime.date

    @validator('email')
    def is_valid_email(cls, v):
        if re.match(r"[\w-\.]+@([\w-]+\.)+[\w-]{2,4}", v):
        	return v
        raise ValueError('Invalid email.')

    @validator('password1')
    def is_valid_password(cls, v):
        if len(v) >= 6 and re.match(r"[a-zA-Z0-9]", v):
        	return v
        raise ValueError('Password must consist of uppercase, lowercase, numerical with 6 chars minimal length.')

    @validator('password2')
    def are_passwords_match(cls, v, values, **kwargs):
        if 'password1' in values and v == values['password1']:
        	return v
        raise ValueError('Passwords do not match.')

    @validator('gender')
    def is_gender_in_list(cls, v):
        if v in ['male', 'female', 'custom']:
        	return v
        raise ValueError("Choose gender between 'male', 'female' or 'custom'.")

    @validator('name')
    @validator('surname')
    @validator('patronymic')
    def check_name(cls, v):
        if re.match(r"[a-zA-Z]", v):
        	return v
        raise ValueError('Invalid name.')

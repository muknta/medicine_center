from pydantic import BaseModel, validator, ValidationError
import datetime
import re


class RegisterScheme(BaseModel):
    email: str
    password1: str
    password2: str
    name: str
    surname: str
    patronymic: str
    phone_number: str
    gender: str
    birthday: datetime.date

    @validator('email')
    def is_valid_email(cls, v):
        if re.match(r"[\w-\.]+@([\w-]+\.)+[\w-]{2,4}", v):
        	return v
        raise ValueError('Invalid email.')

    @validator('password1')
    def is_valid_password(cls, v):
    	min_len = 6
    	if len(v) >= min_len and re.match(r"[a-zA-Z0-9]", v):
    		return v
    	raise ValueError(
        	f'Password must consist of uppercase, lowercase, numerical with {min_len} chars minimal length.')

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

    @validator('name', 'surname', 'patronymic')
    def check_name(cls, v):
        if re.match(r"[a-zA-Z]", v):
        	return v
        raise ValueError('Invalid name.')

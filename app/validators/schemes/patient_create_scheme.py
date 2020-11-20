from pydantic import BaseModel, validator, ValidationError
from datetime import datetime
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
    profession: str
    address: str
    birthday: str

    @staticmethod
    def _get_regex_range(min_val, max_val):
    	return '{'+str(min_val)+','+str(max_val)+'}'

    @validator('email')
    def is_valid_email(cls, v):
        if re.match(r"[a-zA-Z0-9]+@+[a-zA-Z0-9]+\.+[a-zA-Z]{2,5}", v):
        	return v
        print(f'unvalideed server with {v}')
        raise ValueError('Invalid email.')

    @validator('password1')
    def is_valid_password(cls, v):
    	MIN_LEN = 6
    	MAX_LEN = 30

    	if re.match(rf"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{cls._get_regex_range(MIN_LEN,MAX_LEN)}$", v):
    		return v
    	print(f'unvalideed server with {v}')
    	raise ValueError(
        	f'Password must consist of uppercase, lowercase letter, numerical with {MIN_LEN}-{MAX_LEN} chars length.')

    @validator('password2')
    def are_passwords_match(cls, v, values, **kwargs):
        if 'password1' in values and v == values['password1']:
        	return v
        print(f'unvalideed server with {v}')
        raise ValueError('Passwords do not match.')

    @validator('phone_number')
    def is_valid_phone_number(cls, v):
    	MIN_LEN = 6
    	MAX_LEN = 15

    	if re.match(rf"^\+{'{1,1}'}?\d{cls._get_regex_range(MIN_LEN, MAX_LEN)}$", v):
    		return v
    	print(f'unvalideed server with {v}')
    	raise ValueError(
        	f"Phone number begins with '+' and the rest ({MIN_LEN}-{MAX_LEN} chars) consists of numbers.")

    @validator('gender')
    def is_gender_in_list(cls, v):
    	gender_list = ['male', 'female', 'custom']
    	if v in gender_list:
    		return v
    	print(f'unvalideed server with {v}')
    	raise ValueError(f"Choose gender between {gender_list}")

    @validator('name', 'surname', 'patronymic')
    def check_name(cls, v):
        if re.match(r"[a-zA-Z]+", v):
        	return v
        print(f'unvalideed server with {v}')
        raise ValueError('Invalid name.')

    @validator('birthday')
    def is_valid_birthday(cls, v):
        datetime_len = len('yyyy-MM-dd') # 10
        try:
            print('v isss',v)
            datetime_date = datetime.strptime(
                    v[:datetime_len], '%Y-%m-%d').date()
            print('datetime_date',datetime_date)
            print(type(datetime_date))
            return datetime_date
        except ValueError:
            raise ValueError('Invalid birthday format.')

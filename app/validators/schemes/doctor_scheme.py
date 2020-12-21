from pydantic import BaseModel


class DoctorScheme(BaseModel):
    user_id: str
    hospital_id: str
    rating: str
    positing: str
    email: str
    role: str
    name: str
    surname: str
    phone_number: str
    patronymic: str
    gender: str
    birthday: str
    


# class DoctorScheme(BaseModel):
#     user_id: str
#     name: str
#     surname: str
#     address: str
#     phone_number: str
#     specialtie: str
